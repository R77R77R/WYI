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

open WYI.BizLogics.Common
open WYI.BizLogics.Auth
open WYI.BizLogics.Db

let output = runtime.output

let incomingFile (formfile:IFormFile) = 
    task{

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
                true) then

            let prompt = 
                """
                从上传的文件中提取provider,账号，地址和金额，
                输出的格式参考为：
                Provider: [T-Mobile],
                Account Number: [1234567890123],
                Address: [Line1, Line2(optional), City/Township, HI 123456]
                Amount: [$123.45]
                """

            let! msg = 
                UtilKestrel.Open.Google.GeminiMultimodal
                    runtime.output 
                    runtime.data.apiKeyGemini
                    runtime.data.aiModel
                    prompt 
                    [| path |]

            return msg
        else
            return Er.Internal.ToString()

    | None -> return Er.Internal.ToString()
    }
    
let fileid__localpath id = 
    ""
