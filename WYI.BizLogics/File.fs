module WYI.BizLogics.File

open System
open System.Text
open System.IO
open System.Collections.Generic
open System.Threading

open Microsoft.AspNetCore.Http

open Util.Cat
open Util.Text
open Util.Bin
open Util.CollectionModDict
open Util.Perf
open Util.Json
open Util.Orm

open WYI.Shared.OrmTypes
open WYI.Shared.Types
open WYI.Shared.OrmMor
open WYI.Shared.CustomMor

open UtilKestrel.Types
open UtilKestrel.Db
open UtilKestrel.Api
open UtilKestrel.Json
open UtilKestrel.SSR
open UtilKestrel.Server

open ImageMagick

open WYI.BizLogics.Common
open WYI.BizLogics.Auth
open WYI.BizLogics.Db

let output = runtime.output


let generateThumbnailBytes (fileStream: Stream) (isPdf: bool) =
    try
        // 1. 配置读取参数
        let settings = MagickReadSettings()
        if isPdf then
            settings.FrameIndex <- uint32 0 // 只读取 PDF 第一页
            settings.FrameCount <- uint32 1
            settings.Density <- Density(96.0) // 设置渲染分辨率，96 足够清晰且速度快

        // 2. 加载图片/PDF
        using (new MagickImage(fileStream, settings)) (fun image ->
            // 3. 图像处理
            image.Format <- MagickFormat.Jpeg // 统一转为 Jpeg 缩小体积
            image.Resize(MagickGeometry(uint32 200, uint32 0)) // 宽度固定 200px，高度按比例缩放
            image.Strip() // 移除所有元数据（如相机信息、坐标等）以压缩体积

            // 4. 返回字节流用于存入数据库
            image.ToByteArray()
        )
    with ex ->
        [||]

let incomingFile httpx (formfile:IFormFile) = 
    async{

    let rawfilename = formfile.FileName
    
    let filename,suffix = 
        if rawfilename.Contains "." then
            let suffix = rawfilename.Substring(rawfilename.LastIndexOf "." + 1).ToLower()
            FILE_id.Value.ToString() + "." + suffix,suffix
        else
            FILE_id.Value.ToString(),""

    let path = Path.Combine(runtime.host.fsDir,filename)

    match
        (fun (p:pFILE) -> 
            p.State <- fileStateEnum.Failed
            p.Size <- formfile.Length
            p.Suffix <- suffix
            p.ContentType <- formfile.ContentType
            p.Caption <- rawfilename) 
        |> creator FILE_metadata with
    | Some rcd ->

        do! async {
            // 使用 use 确保离开这个 scope 时，文件句柄被立即 Dispose (释放锁)
            use stream = new FileStream(path, FileMode.Create)
            // 必须 AwaitTask 确保拷贝彻底完成
            do! formfile.CopyToAsync(stream) |> Async.AwaitTask
        } 

        if
            rcd
            |> updateRcd "" conn FILE_metadata None (fun p -> 
                p.State <- fileStateEnum.Normal
                p.Path <- filename
                p.Thumbnail <-
                    use stream = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.Read)
                    let isPdf = p.Suffix.ToLower() = "pdf"
                    generateThumbnailBytes stream isPdf
                true) then
            let rep =
                [|  ok  
                    ("file",rcd |> FILE__json)
                    ("billx",BillComplex_empty() |> BillComplex__json) |]
                |> Json.Braket

            rcd.p.ContentType |> runtime.output
            rcd.p.Path |> runtime.output
            rcd.p.Thumbnail.Length.ToString() + " bytes Thumbnail" |> runtime.output

            return rep
        else
            return er Er.Internal |> Json.Braket

    | None -> return er Er.Internal |> Json.Braket
    }
    
let fileid__bin id = 
    
    match
        id
        |> parse_int64
        |> id__FILEo with
    | Some file -> 
        let bin = 
            Path.Combine(runtime.host.fsDir,file.p.Path)
            |> Util.FileSys.try_read_bin
            |> snd
        bin,file.p.Path |> Util.FileSys.filename__mime
    | None -> [||],""

let id__thumbnail id = 
    match 
        id
        |> parse_int64
        |> id__FILEo with
    | Some v -> v.p.Thumbnail
    | None -> [||]
        