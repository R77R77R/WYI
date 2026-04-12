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

    ## 任务：根据上传的文件获得账单的信息

    1. 这里上传了一批文件，每个文件名都由[文件ID.后缀]构成；之后凡是提及文件都需要用[文件ID.后缀]的格式
    2. 根据上传的账单文件，提取其中的文字信息
    3. 有可能多个文件对应同一个账单
    4. 文字尝试匹配供应商及其分类信息
    5. 输出账单信息

    ## Exihibit A: 供应商provider及其分类cat的信息

    {providerInfo}

    从上传的文件中提取cat,provider,账号，地址和金额，
    若cat或provider在以上信息中存在，则提取其ID，否则ID=0

    ## 输出格式

    输出的格式严格按照以下要求，不得擅自修改或者添加文字，所有方括号[]和<>都需要保留：

    CategoryID: [从Exihibit A获取],
    Category: [Cellphone],
    ProviderID: [从Exihibit A获取],
    Provider: [T-Mobile],
    AcctNum: [1234567890123],
    AcctName: [Jone Browning]
    Addr: [133 Keystone Dr, Suite 12]
    Town: [Dingmans Ferry]
    State: [PA]
    ZIP: [18328]
    BillDate: [MM/DD/YYYY]
    Amt: [$123.45]
    """


(*

>>>
>>
[1.jpg]
<<
Category ID: [6471],
Category: [Trash],
Provider ID: [0],
Provider: [Forest Lake Sanitation],
Account Number: [CSD00074519],
Account Name: [Forest Lake Sanitation]
Address: [19020 East Wrong Blvd]
City: [Wyoming]
State: [MN]
ZIP: [55092]
Amount: [$359.80]
<<<
>>
[45221.jpg]
[21232.pdf]
<<
Category ID: [6469],
Category: [Payroll],
Provider ID: [254275],
Provider: [ADP],
Account Number: [0],
Account Name: [BREW FITNESS LLC]
Address: []
City: []
State: []
ZIP: []
Amount: [$490.38]
<<<
>>
[2.jpg]
<<
Category ID: [6469],
Category: [Payroll],
Provider ID: [254275],
Provider: [ADP],
Account Number: [0],
Account Name: [BREW FITNESS LLC]
Address: []
City: []
State: []
ZIP: []
Amount: [$11,476.94]
<<<
>>
[2.jpg]
<<
Category ID: [6469],
Category: [Payroll],
Provider ID: [254275],
Provider: [ADP],
Account Number: [0],
Account Name: [BREW FITNESS LLC]
Address: []
City: []
State: []
ZIP: []
Amount: [$169.99]
<<<
>>
[2.jpg]
<<
Category ID: [6471],
Category: [Trash],
Provider ID: [0],
Provider: [LL TRASH],
Account Number: [T001053],
Account Name: [FARRELL'S EXTREME BODY]
Address: []
City: []
State: []
ZIP: []
Amount: [$55.00]
<<<
>>
[2.jpg]
<<
Category ID: [6470],
Category: [Credit Card Processing],
Provider ID: [0],
Provider: [TRANSFIRST],
Account Number: [N0784235424843],
Account Name: [FXB - ELK RIVER]
Address: []
City: []
State: []
ZIP: []
Amount: [$1,621.64]
<<<
>>
[2.jpg]
<<
Category ID: [6470],
Category: [Credit Card Processing],
Provider ID: [0],
Provider: [TSYS/TRANSFIRST],
Account Number: [T436845555720511],
Account Name: [FXB - ELK RIVER]
Address: []
City: []
State: []
ZIP: []
Amount: [$1,545.97]
<<<
>>
[3.pdf]
<<
Category ID: [6462],
Category: [Internet],
Provider ID: [0],
Provider: [Cox Business],
Account Number: [0017410042281101],
Account Name: [SENTINO EARLY CHILDHOOD ACADEMY]
Address: [10080 MORRISON RD]
City: [NEW ORLEANS]
State: [LA]
ZIP: [70127-1821]
Amount: [$520.00]
<<<
>>
[3.pdf]
<<
Category ID: [6464],
Category: [Landlines],
Provider ID: [0],
Provider: [Cox Business],
Account Number: [0017410042281101],
Account Name: [SENTINO EARLY CHILDHOOD ACADEMY]
Address: [10080 MORRISON RD]
City: [NEW ORLEANS]
State: [LA]
ZIP: [70127-1821]
Amount: [$69.18]
<<<
>>
[stanley-security.pdf]
<<
Category ID: [6468],
Category: [Security Monitoring],
Provider ID: [0],
Provider: [STANLEY Convergent Security Solutions, Inc.],
Account Number: [Q-306040],
Account Name: [OUR LADY OF GOOD COUNSEL - HIGH SCHOOL]
Address: [17301 OLD VIC BLVD]
City: [OLNEY]
State: [MD]
ZIP: [20832-1603]
Amount: [$458.46]
<<<
>>
[9906599738.pdf]
<<
Category ID: [6463],
Category: [Cellphone],
Provider ID: [254265],
Provider: [Verizon],
Account Number: [720777348-00006],
Account Name: [OUR LADY OF GOOD COUNSEL]
Address: [17301 OLD VIC BLVD]
City: [OLNEY]
State: [MD]
ZIP: [20832-1603]
Amount: [$351.64]
<<<
>>
[000655403354.pdf]
<<
Category ID: [6462],
Category: [Internet],
Provider ID: [254265],
Provider: [Verizon],
Account Number: [455-308-556-0001-46],
Account Name: [OUR LADY OF GOOD COUNSEL HIGH]
Address: [17301 OLD VIC BLVD]
City: [OLNEY]
State: [MD]
ZIP: [20832-1603]
Amount: [$459.99]
<<<
>>
[000655403354.pdf]
<<
Category ID: [6464],
Category: [Landlines],
Provider ID: [254265],
Provider: [Verizon],
Account Number: [650-459-780-0001-30],
Account Name: [OUR LADY OF GOOD COUNSEL HIGH]
Address: [17301 OLD VIC BLVD]
City: [OLNEY]
State: [MD]
ZIP: [20832-1603]
Amount: [$557.50]
<<<
>>
[000655403354.pdf]
<<
Category ID: [6463],
Category: [Cellphone],
Provider ID: [254265],
Provider: [Verizon],
Account Number: [650-459-780-0001-30],
Account Name: [OUR LADY OF GOOD COUNSEL HIGH]
Address: [17301 OLD VIC BLVD]
City: [OLNEY]
State: [MD]
ZIP: [20832-1603]
Amount: [$46.00]
<<<
>>
[cintas.pdf]
<<
Category ID: [6471],
Category: [Trash],
Provider ID: [0],
Provider: [Cintas],
Account Number: [12509558],
Account Name: [FARRELL'S ELK RIVER]
Address: [19140 FREEPORT ST NW]
City: [ELK RIVER]
State: [MN]
ZIP: [55330-1264]
Amount: [$421.92]
<<<
>>
[CenturyLink.pdf]
<<
Category ID: [6462],
Category: [Internet],
Provider ID: [0],
Provider: [CenturyLink],
Account Number: [651464-5851],
Account Name: [BREW FITNESS]
Address: [808 LAKE ST S]
City: [FOREST LAKE]
State: [MN]
ZIP: [55025-2614]
Amount: [$69.99]
<<<

*)

let reviewBillFiles eux (x:X) =

    let files = 
        x.Json
        |> tryFindAryByAtt "fids"
        |> Array.map(fun item -> 
            match item with
            | Json.Num v -> parse_int64 v
            | _ -> 0L)
        |> Array.filter(fun id -> id > 0L)
        |> Array.distinct
        |> Array.map id__FILEo
        |> Array.filter(fun o -> o.IsSome)
        |> Array.map(fun o -> o.Value)

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
                    prompt 
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
ProviderID: [254300],
Provider: [Cox],
AcctNum: [0017410044200801],
AcctName: [SEA Academy],
Addr: [10080 Morrison Rd],
Town: [New Orleans],
State: [LA],
ZIP: [70127-1821],
BillDate: [01/29/2026],
Amt: [$527.11]               
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
