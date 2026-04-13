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

let lf = Util.Text.lf

let providerInfo() =
    let w = Util.Text.empty__TextBlockWriter()
    let items = runtime.data.providers.Values
    runtime.data.cats.Values
    |> Array.iter(fun ucat -> 
        "CategoryID=" + ucat.ID.ToString() + ": " + ucat.p.Caption + lf
        |> w.newline

        items
        |> Array.filter(fun i -> i.p.Cat = ucat.ID)
        |> Array.map(fun i -> 
            "ProviderID=" + i.ID.ToString() + ": " + i.p.Caption + lf)
        |> w.multiLine

        lf |> w.newline)
    w.text()

let myUnits eux = 
    let w = Util.Text.empty__TextBlockWriter()
    eux.units.Values
    |> Array.map(fun i -> 
        "UnitID=" + i.ID.ToString() + ": " + i.p.Address + " " + i.p.Town + " " + i.p.State + " " + i.p.Zip + lf)
    |> w.multiLine
    w.text()

let myAcctxs eux =
    let w = Util.Text.empty__TextBlockWriter()
    eux.acctxs.Values
    |> Array.iter(fun i ->
        let acct = i.acct
        
        [|  "AcctID=" + acct.ID.ToString()
            ": " + acct.p.AcctName
            " " + acct.p.AcctNum |]
        |> w.multiLine
        
        match i.unito with
        | Some unit -> 
            " " + unit.p.Address + " " + unit.p.Town + " " + unit.p.State + " " + unit.p.Zip
            |> w.newline
        | None -> ()
        
        if i.cato.IsSome && i.providero.IsSome then
            " " + i.providero.Value.p.Caption
            |> w.newline
        
        lf |> w.newline)
    
    w.text()

let prompt eux = 
    $"""

## 任务：根据上传的文件获得账单的信息

1. 这里上传了一批文件，每个文件名都由[文件ID.后缀]构成；之后凡是提及文件都需要用[文件ID.后缀]的格式
2. 根据上传的账单文件，提取其中的文字信息
3. 有可能多个文件对应同一个账单
4. 文字尝试匹配供应商及其分类信息
5. 输出账单信息
6. 如果匹配出多个账单信息，以页码小的优先，最终只输出一个账单信息

## Exihibit A: 供应商provider及其分类cat的信息

{providerInfo()}

## Exihibit B: 可选的商业/住宅单元Unit信息

{myUnits eux}

## Exihibit C: 可选的账号Acct信息

{myAcctxs eux}

## 任务

从上传的文件中提取cat,provider,账号，地址和金额，
若cat或provider在以上信息中存在，则提取其ID，否则ID=0
若unit在以上信息中存在，则提取其ID，否则ID=0
若acct在以上信息中存在，则提取其ID，否则ID=0

## 输出格式

输出的格式严格按照以下要求，不得擅自修改或者添加文字，所有方括号[]和<>都需要保留：

CategoryID: [从Exihibit A获取],
Category: [Cellphone],
ProviderID: [从Exihibit A获取],
Provider: [T-Mobile],
AcctNum: [1234567890123],
AcctName: [Jone Browning]
AcctID: [从Exihibit C获取],
Addr: [133 Keystone Dr, Suite 12]
Town: [Dingmans Ferry]
State: [PA]
ZIP: [18328]
UnitID: [从Exihibit B获取],
BillDate: [MM/DD/YYYY]
Amt: [$123.45]
    """

let reviewBillFiles eux (x:X) =

    let files = x.Json |> Ca.json__files

    let pathes = 
        files
        |> Array.map(fun f -> Path.Combine(runtime.host.fsDir,f.p.Path))

    let pUnit = pUNIT_empty()
    let pAcct = pUACCT_empty()
    let pBill = pUBILL_empty()
    
    let ex,msg =
        async{
            let! (ex,msg) = 
                GeminiMultimodal
                    runtime.output 
                    runtime.data.apiKeyGemini
                    runtime.data.aiModel
                    (prompt eux)
                    pathes
            ex + msg |> output
            return ex,msg
        }
        |> Async.RunSynchronously

    if ex.Length = 0 then

        let json =
(*
CategoryID: [6462],
Category: [Internet],
ProviderID: [254299],
Provider: [Verizon Fios],
AcctNum: [455-308-556-0001-46],
AcctName: [OUR LADY OF GOOD COUNSEL HIGH],
AcctID: [54229565],
Addr: [17301 OLD VIC BLVD],
Town: [OLNEY],
State: [MD],
ZIP: [20832-1603],
UnitID: [29554264],
BillDate: [05/16/2022],
Amt: [$459.99]
*)

            let parse (line:string) = 
                let k = line.Substring(0,line.IndexOf ":")
                let v = Util.Text.regex_match
                            (str__regex "(?<=\[).*?(?=\])") line
                k,Json.Str v

            msg.Split lf
            |> Array.filter(fun line -> line.Contains ":")
            |> Array.map parse
            |> Json.Braket

        pUnit.Address <- tryFindStrByAtt "Addr" json
        pUnit.Town <- tryFindStrByAtt "Town" json
        pUnit.State <- tryFindStrByAtt "State" json
        pUnit.Zip <- tryFindStrByAtt "ZIP" json
        
        pAcct.AcctNum <- tryFindStrByAtt "AcctNum" json
        pAcct.AcctName <- tryFindStrByAtt "AcctName" json

        pBill.Owner <- eux.eu.ID

        pBill.Cat <- tryFindStrByAtt "CategoryID" json |> parse_int64
        pBill.Provider <- tryFindStrByAtt "ProviderID" json |> parse_int64
        pBill.Unit <- tryFindStrByAtt "UnitID" json |> parse_int64
        pBill.UAcct <- tryFindStrByAtt "AcctID" json |> parse_int64

        pBill.YYYYMMDD <-
            let mutable s = tryFindStrByAtt "BillDate" json
            s <- s.Replace("/","").Replace(" ","")
            if s.Length = 8 then
                let mm = s.Substring(0,2)
                let dd = s.Substring(2,2)
                let yyyy = s.Substring(4,4)
                yyyy + mm + dd
            else
                ""
        pBill.Amt <- (tryFindStrByAtt "Amt" json).Replace("$","") |> parse_float
    
    ex,(pUnit,pAcct,pBill)
