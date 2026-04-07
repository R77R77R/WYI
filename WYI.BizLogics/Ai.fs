module WYI.BizLogics.Ai

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
open UtilKestrel.Open.Google
open UtilKestrel.Api
open UtilKestrel.Json
open UtilKestrel.SSR

open WYI.BizLogics.Common
open WYI.BizLogics.Auth

let output = runtime.output

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
    任务：
    1. 根据上传的账单文件，提取其中的文字信息
    2. 有可能多个文件对应同一个账单
    3. 文字尝试匹配供应商及其分类信息
    4. 按照每个账单来输出信息

    供应商provider及其分类cat的信息如下，
    {providerInfo}

    从上传的文件中提取cat,provider,账号，地址和金额，
    若cat或provider在以上信息中存在，则提取其ID，否则ID=0
    输出的格式参考为：
    Bill Number X
    Files:
    1. fileA.jpg
    2. fileB.pdf
    ...
    Category ID: [ID],
    Category: [Cellphone],
    Provider ID: [ID],
    Provider: [T-Mobile],
    Account Number: [1234567890123],
    Address: [Line1, Line2(optional), City/Township, HI 123456]
    Amount: [$123.45]
    """
