module WYI.BizLogics.Api

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
open UtilKestrel.Ctx
open UtilKestrel.Api
open UtilKestrel.Json
open UtilKestrel.SSR
open UtilKestrel.Server

open WYI.BizLogics.Common
open WYI.BizLogics.Auth

let output = runtime.output

let providers x = 
    let providers = runtime.data.providers.Values
    runtime.data.cats.Values
    |> Array.map(fun ucat -> 
        let ary = 
            providers 
            |> Array.filter(fun i -> i.p.Cat = ucat.ID)
            |> Array.map UPROVIDER__json
            |> Json.Ary

        [|  ("ucat", ucat |> UCAT__json) 
            ("providers",ary)  |]
        |> Json.Braket)
    |> Json.Ary
    |> wrapOk "data"

let reviewBills x =

    //let providerInfo =
    //    let items = runtime.data.providers.Values
    //    runtime.data.cats.Values
    //    |> Array.map(fun ucat -> 
    //        let cattext = 
    //            "ID=" + ucat.ID.ToString() + ": " + ucat.p.Caption
    //        let providerstxt = 
    //            items
    //            |> Array.filter(fun i -> i.p.Cat = ucat.ID)
    //            |> Array.map(fun i -> 
    //                "ID=" + i.ID.ToString() + ": " + i.p.Caption)
    //            |> String.concat ", "
    //        cattext + ", Providers: " + providerstxt)
    //    |> String.concat "; "

    //let prompt = 
    //    $"""
    //    供应商provider及其分类cat的信息如下，
    //    {providerInfo}

    //    从上传的文件中提取cat,provider,账号，地址和金额，
    //    若cat或provider在以上信息中存在，则提取其ID，否则ID=0
    //    输出的格式参考为：
    //    Category ID: [ID],
    //    Category: [Cellphone],
    //    Provider ID: [ID],
    //    Provider: [T-Mobile],
    //    Account Number: [1234567890123],
    //    Address: [Line1, Line2(optional), City/Township, HI 123456]
    //    Amount: [$123.45]
    //    """

    //prompt |> output

    //let path = Path.Combine(runtime.host.fsDir,filename)

    //async{
    //    let! (ex,msg) = 
    //        UtilKestrel.Open.Google.GeminiMultimodal
    //            runtime.output 
    //            runtime.data.apiKeyGemini
    //            runtime.data.aiModel
    //            prompt 
    //            [| path |]

    //    ex + msg |> output
    //}
    //|> Async.RunSynchronously

    [| ok |]



