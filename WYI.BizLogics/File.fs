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
                true) then

            let providerInfo =
                let items = runtime.data.providers.Values
                runtime.data.cats.Values
                |> Array.map(fun ucat -> 
                    let cattext = 
                        "ID=" + ucat.ID.ToString() + ": " + ucat.p.Caption
                    let providerstxt = 
                        items
                        |> Array.filter(fun i -> i.p.Cat = ucat.ID)
                        |> Array.map(fun i -> 
                            "ID=" + i.ID.ToString() + ": " + i.p.Caption)
                        |> String.concat ", "
                    cattext + ", Providers: " + providerstxt)
                |> String.concat "; "

            let prompt = 
                $"""
                供应商provider及其分类cat的信息如下，
                {providerInfo}

                从上传的文件中提取cat,provider,账号，地址和金额，
                若cat或provider在以上信息中存在，则提取其ID，否则ID=0
                输出的格式参考为：
                Category ID: [ID],
                Category: [Cellphone],
                Provider ID: [ID],
                Provider: [T-Mobile],
                Account Number: [1234567890123],
                Address: [Line1, Line2(optional), City/Township, HI 123456]
                Amount: [$123.45]
                """

            prompt |> output

            let! (ex,msg) = 
                UtilKestrel.Open.Google.GeminiMultimodal
                    runtime.output 
                    runtime.data.apiKeyGemini
                    runtime.data.aiModel
                    prompt 
                    [| path |]

            ex + msg |> output

            let ucat,uprovider,acctnum,addr,amt = 
                if ex = "" then
                    "-","-","-","-","-"
                else
                    "-","-","-","-","-"
                
            return [|   ok 
                        ("filename",Json.Str rawfilename)
                        ("ucat", ucat |> Json.Str)
                        ("uprovider", uprovider |> Json.Str)
                        ("acctnum", acctnum |> Json.Str)
                        ("addr", addr |> Json.Str)
                        ("amt", amt |> Json.Num)
                        ("ex",ex |> Json.Str)
                        ("msg",msg |> Json.Str) |] |> Json.Braket
        else
            return er Er.Internal |> Json.Braket

    | None -> return er Er.Internal |> Json.Braket
    }
    
let fileid__localpath id = 
    ""
