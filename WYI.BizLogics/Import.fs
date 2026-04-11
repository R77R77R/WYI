module WYI.BizLogics.Import

open System
open System.IO
open System.Threading
open System.Text
open System.Collections.Generic
open System.Collections.Concurrent

open Util.Cat
open Util.Runtime
open Util.Db
open Util.DbTx
open Util.Orm

open UtilKestrel.DbLogger
open UtilKestrel.Db
open UtilKestrel.Common

open WYI.Shared.OrmTypes
open WYI.Shared.Types
open WYI.Shared.OrmMor
open WYI.Shared.CustomMor

open WYI.BizLogics.Common
open WYI.BizLogics.Db

let tx sql = 

    sql |> runtime.output

    let pretx = None |> opctx__pretx

    sql
    |> str__sql
    |> pretx.sqls.Add

    match 
        pretx
        |> pipeline conn with
    | Suc ctx -> ()
    | Fail(dte,ctx) -> 
        halt runtime.output "" ""

let clearData() = 
    //"DELETE FROM public.kernel_utilbill" |> tx
    //"DELETE FROM public.kernel_utilacct" |> tx
    //"DELETE FROM public.kernel_unit" |> tx
    ()

let importUtilProviders () = 

    let checkBind (cat:UCAT) (provider:UPROVIDER) = 
        match
            runtime.data.catproviders
            |> Array.tryFind(fun i -> i.p.Cat = cat.ID && i.p.Provider = provider.ID) with
        | Some v -> ()
        | None ->
            match
                (fun (p:pKUCP) -> 
                    p.Cat <- cat.ID
                    p.Provider <- provider.ID)
                |> creator KUCP_metadata with
            | Some rcd -> 
                runtime.data.catproviders <-
                    [|  runtime.data.catproviders
                        [| rcd |] |]
                    |> Array.concat
            | None -> halt runtime.output "" ""

    let getOrAddCat cat = 
        match
            runtime.data.cats.Values
            |> Array.tryFind(fun i -> i.p.Caption = cat) with
        | Some ucat -> Some ucat
        | None ->
            match
                (fun (p:pUCAT) -> 
                    p.Caption <- cat) 
                |> creator UCAT_metadata with
            | Some v -> 
                runtime.data.cats[v.ID] <- v
                Some v
            | None -> None

    let getOrAddProvider ucat provider = 
        match
            runtime.data.providers.Values
            |> Array.tryFind(fun i -> i.p.Caption = provider) with
        | Some uprovider -> 
            checkBind ucat uprovider
        | None ->
            match
                (fun (p:pUPROVIDER) ->
                    p.Cat <- ucat.ID
                    p.Caption <- provider) 
                |> creator UPROVIDER_metadata with
            | Some v -> 
                runtime.data.providers[v.ID] <- v
                checkBind ucat v
            | None -> halt runtime.output "" ""        

    "DELETE FROM public.kernel_utilcat" |> tx
    "DELETE FROM public.kernel_utilprovider" |> tx
    "DELETE FROM public.kernel_utilcatprovider" |> tx

    let lines = new List<string * string>()

    """
Internet | Spectrum
Internet | Comcast
Internet | Windstream
Cellphone | Verizon
Cellphone | AT&T
Cellphone | T-Mobile
Landlines | Verizon
Cable TV | Spectrum
Cable TV | Comcast
Cable TV | Optimum
Satellite TV | Direct TV
Satellite TV | Dish
Satellite Radio | Sirius XM
Security Monitoring | ADT
Security Monitoring | Vivint
Security Monitoring | Brinks
Payroll | ADP
Payroll | Paychex
Credit Card Processing | Global
Credit Card Processing | World Pay
Trash | Waste Mgmt.
Trash | Republic
Trash | GFL
Trash | Local companies
Pest Control | Terminix
Pest Control | Orkin
Lawn Care | TruGreen
Subscriptions/Memberships | Adobe
Subscriptions/Memberships | Salesforce
Subscriptions/Memberships | HubSpot
Advertising | Billboards
Advertising | Newspapers
Advertising | Magazines
Advertising | Yellow Pages
Water Delivery | Ready Refresh
Water Delivery | Primo
Water Delivery | Crystal Rock
Propane Gas | (Not specified)
Heating Oil | (Not specified)
Elevator Maintenance Contracts | Otis
CO2 (for Restaurants) | (Not specified)
Monthly Recurring Bills | (Miscellaneous)    """.Split Util.Text.lf
    |> Array.map(fun s -> s.Trim())
    |> Array.filter(fun s -> s.Contains "|")
    |> Array.map(fun s -> 
        let ss = s.Split "|"
        let cat = ss[0].Trim()
        let provider = ss[1].Trim()
        cat,provider)
    |> Array.filter(fun (cat,provider) ->
        provider.StartsWith "(" = false && provider.EndsWith ")" = false)
    |> Array.iter lines.Add
    
    """
Internet | Spectrum | Comcast | Windstream/ Frontier/Century Link/Verizon Fios/Optimum/Cox/RCN
Cellphone | Verizon | AT&T | T-Mobile
Landlines
Cable TV | Spectrum | Comcast | Windstream/ Frontier/Century Link/Verizon Fios/Optimum/Cox/RCN
Satellite TV | Direct TV | Dish
Satellite Radio | Sirius XM
Security Monitoring | ADT | Vivint | Brinks/Slomin's
Payroll | ADP | Paychex
Credit Card Processing | Global | World Pay
Trash | Waste Mgmt. | Republic | GFL | Local companies
Pest Control | Terminix | Orkin/Plunkett's
Lawn Care | TruGreen
Subscriptions/Memberships | Adobe | Salesforce | HubSpot
Advertising | Billboards | Newspapers | Magazines | Yellow Pages
Water Delivery | Ready Refresh | Primo | Crystal Rock
Elevator Maintenance Contracts | Otis        """.Split Util.Text.lf
    |> Array.map(fun s -> s.Trim().Replace("/","|"))
    |> Array.filter(fun s -> s.Contains "|")
    |> Array.iter(fun s -> 
        let ss = s.Split "|"
        let cat = ss[0].Trim()
        [| 1 .. ss.Length - 1|]
        |> Array.iter(fun i ->
            let provider = ss[i].Trim()
            (cat,provider) |> lines.Add))

    lines.ToArray()
    |> Array.iter(fun (cat,provider) -> 
        match getOrAddCat cat with
        | Some ucat -> 
            getOrAddProvider ucat provider
        | None -> halt runtime.output "" ""
    )

    [|  "Verizon","data:image/svg+xml;charset=utf-8;base64,PHN2ZyB2aWV3Qm94PSIwIDAgNTAwIDExMiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPGRlZnM+PC9kZWZzPgo8ZyB0cmFuc2Zvcm09Im1hdHJpeCgwLjgyNTU3OCwgMCwgMCwgMC44MjU1NzgsIC03OS40MjY1NDgsIC03OS40NTE3NDgpIiBzdHlsZT0iIj4KPHBhdGggY2xhc3M9InN0MCIgZD0iTTYwNi43OCwyMjkuMzA2aDI5LjY2MXYtNTQuMTg3YzAtMTIuMzYsNy4yMjUtMjEuMTA3LDE3Ljg3Mi0yMS4xMDdjMTAuMjY3LDAsMTUuNTkxLDcuMjI3LDE1LjU5MSwxNy40OTV2NTcuOCBoMjkuNjYxdi02My41MDNjMC0yMS40ODgtMTIuOTI4LTM2LjY5OS0zMy44NDQtMzYuNjk5Yy0xMy4zMDgsMC0yMi42MjYsNS43MDUtMjkuNjYxLDE2LjE2MmgtMC41NzF2LTEzLjMwOWgtMjguNzFWMjI5LjMwNnogTTU0OC41OTgsMTI5LjI5NWMtMzAuOTkzLDAtNTEuNzE2LDIyLjI0Ni01MS43MTYsNTEuNTI3YzAsMjkuMDkyLDIwLjcyNCw1MS41MjgsNTEuNzE2LDUxLjUyOHM1MS43MTYtMjIuNDM2LDUxLjcxNi01MS41MjggQzYwMC4zMTQsMTUxLjU0LDU3OS41OSwxMjkuMjk1LDU0OC41OTgsMTI5LjI5NXogTTU0OC40MDgsMjEwLjQ4M2MtMTQuMDcyLDAtMjEuNDg1LTExLjc4Ny0yMS40ODUtMjkuNjYxIGMwLTE4LjA2Myw3LjQxMy0yOS42NjIsMjEuNDg1LTI5LjY2MmMxNC4wNjksMCwyMS44NjUsMTEuNTk4LDIxLjg2NSwyOS42NjJDNTcwLjI3MywxOTguNjk2LDU2Mi40NzcsMjEwLjQ4Myw1NDguNDA4LDIxMC40ODN6IE00MTIuNDYsMjI5LjMwNmg4My4yOHYtMjMuMzg1aC00Ny4xNTN2LTAuNTczbDQ1LjA2Mi01MC41NzZ2LTIyLjgxNEg0MTIuNDZ2MjMuMzg1aDQ1LjYzM3YwLjU3MUw0MTIuNDYsMjA2Ljg3VjIyOS4zMDZ6IE0zNzQuNDI5LDIyOS4zMDZoMjkuODUxdi05Ny4zNDhoLTI5Ljg1MVYyMjkuMzA2eiBNMzA1LjIxOSwyMjkuMzA2aDI5LjY2MXYtNDQuNjhjMC0yMC4zNDYsMTIuMTY5LTI5LjI4MywzMC44MDItMjYuODFoMC41NzEgdi0yNS42NjhjLTEuNTIyLTAuNTcxLTMuMjMyLTAuNzYxLTYuMDg0LTAuNzYxYy0xMS41OTgsMC0xOS4zOTQsNS4zMjMtMjYuMDUsMTYuNzMxaC0wLjU3MXYtMTYuMTZoLTI4LjMyOVYyMjkuMzA2eiBNMjUwLjY1MSwyMTAuNjc1Yy0xMy4xMiwwLTIxLjEwNS04LjU1OS0yMi42MjctMjEuNjc1aDcwLjE2YzAuMTktMjAuOTE4LTUuMzI1LTM3LjY1LTE2LjkyMy00OC4xMDcgYy04LjE3NC03LjYwNS0xOS4wMTQtMTEuNzg5LTMyLjcwMy0xMS43ODljLTI5LjI3OSwwLTQ5LjYyNSwyMi4yNDYtNDkuNjI1LDUxLjMzN2MwLDI5LjI4LDE5LjM5NCw1MS43MTYsNTEuNTI3LDUxLjcxNiBjMTIuMTY5LDAsMjEuODY1LTMuMjMyLDI5Ljg1MS04Ljc0N2M4LjU1Ny01Ljg5MSwxNC42NC0xNC40NSwxNi4zNS0yMy4wMDVoLTI4LjUxOSBDMjY1LjI5MSwyMDYuODcsMjU5LjM5NiwyMTAuNjc1LDI1MC42NTEsMjEwLjY3NXogTTI0OS4xMjksMTUwLjM5OWMxMC40NTcsMCwxNy42ODIsNy43OTgsMTguODIzLDE5LjIwNWgtMzkuNzM4IEMyMzAuNDk3LDE1OC4wMDQsMjM2Ljc3LDE1MC4zOTksMjQ5LjEyOSwxNTAuMzk5eiBNMzc0LjQyOSw5Ny4zNWgyOS44NTF2MjYuNDNoLTI5Ljg1MVY5Ny4zNXoiIHN0eWxlPSJmaWxsOiByZ2IoMjM4LCAwLCAzMCk7Ij48L3BhdGg+CjxnPgo8cmFkaWFsR3JhZGllbnQgaWQ9IlNWR0lEXzFfIiBjeD0iLTExMDMuNjk5MyIgY3k9IjI0MjguMDkyMyIgcj0iMzU0LjM2ODciIGdyYWRpZW50VHJhbnNmb3JtPSJtYXRyaXgoMC4wNDk1IC0wLjEzNzEgMC4xNDgzIDAuMDUzNiAtMTQ1LjY0MjggLTY4Ljg2NzcpIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSI+CjxzdG9wIG9mZnNldD0iMCIgc3R5bGU9InN0b3AtY29sb3I6I0Y1RkYxRSI+PC9zdG9wPgo8c3RvcCBvZmZzZXQ9IjAuMjU3IiBzdHlsZT0ic3RvcC1jb2xvcjojRjVGRjFFIj48L3N0b3A+CjxzdG9wIG9mZnNldD0iMC4yNjU1IiBzdHlsZT0ic3RvcC1jb2xvcjojRjVGQTFFIj48L3N0b3A+CjxzdG9wIG9mZnNldD0iMC40MjMiIHN0eWxlPSJzdG9wLWNvbG9yOiNGNUE2MjAiPjwvc3RvcD4KPHN0b3Agb2Zmc2V0PSIwLjU2MjEiIHN0eWxlPSJzdG9wLWNvbG9yOiNGNTYzMjEiPjwvc3RvcD4KPHN0b3Agb2Zmc2V0PSIwLjY3NzkiIHN0eWxlPSJzdG9wLWNvbG9yOiNGNTMzMjIiPjwvc3RvcD4KPHN0b3Agb2Zmc2V0PSIwLjc2NTciIHN0eWxlPSJzdG9wLWNvbG9yOiNGNTE1MjMiPjwvc3RvcD4KPHN0b3Agb2Zmc2V0PSIwLjgxNTUiIHN0eWxlPSJzdG9wLWNvbG9yOiNGNTBBMjMiPjwvc3RvcD4KPC9yYWRpYWxHcmFkaWVudD4KPHBhdGggY2xhc3M9InN0MSIgZD0iTTE2NC4yMDEsMjI4LjA5NWwtMzYuOTA4LTk2LjEzN0g5Ny4zNWwzNi45MDgsOTYuMTM3YzAuMjgsMC43MzMsMC45ODMsMS4yMTMsMS43NjUsMS4yMTNoMjkuOTQzIEMxNjUuMTg0LDIyOS4zMDgsMTY0LjQ4MSwyMjguODI4LDE2NC4yMDEsMjI4LjA5NXoiIHN0eWxlPSJmaWxsOiB1cmwoI1NWR0lEXzFfKTsiPjwvcGF0aD4KPHBhdGggY2xhc3M9InN0MCIgZD0iTTEzNy43ODcsMjI4LjA5NWwzNi45MDgtOTYuMTM3aDI5Ljk0M2wtMzYuOTA4LDk2LjEzN2MtMC4yOCwwLjczMy0wLjk4MywxLjIxMy0xLjc2NSwxLjIxM2gtMjkuOTQzIEMxMzYuODA1LDIyOS4zMDgsMTM3LjUwOCwyMjguODI4LDEzNy43ODcsMjI4LjA5NXoiIHN0eWxlPSJmaWxsOiByZ2IoMjM4LCAwLCAzMCk7Ij48L3BhdGg+CjwvZz4KPC9nPgo8L3N2Zz4=","data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABlElEQVR4AWXSg46eQRhA4Wdm/9pYG9dQu+FuUN9g3aBcBLXdoLbtrjGd+kv3JGfseWPv1Nab2VRwW7YsCyCX/W7bnk0Fb0R0KsJC1BtP/e++Ip0R+/AOAM1YVtgZYDmaAPAW+yKu4TIAytAhKGUBSuj43QdwGdcivqEbQMAkS83WYhaAVixRhB70RsARvBYxDZXq1KZV5iWAVagDwCscgQiSO4LzJmN+oiYFTand+jTRoEloRwDAedyBKGCWPEynWZJy8gK0WKgytUnasBAACV0YFIjTeu8zFTMdMys9MwdVaExVmqxVylIJgGc4BnmuCGYkBjwwy2kzE3NRjXlpi9m2SIqcxgOACKZj2dhIzrtMNmpaYk72U1gkFo+f++jEiABEmHb6AWWYmE4qeSSghFOh5HMxHnIfp/4cHyKAMtwKTyQnDAReZ49kxxQ5LniiQARII4FlacyQTl8NuRy4nY0AhtApGRPHL2D6ngd8Q6+z3rnnbKAPAcBdnINp3+6PXwD0Yq6XnoeT7gYY+S2cFHLff3wHuO+UkmFYpsMAAAAASUVORK5CYII=" |]
    |> Array.iter(fun (caption,logo,icon) -> 
        match
            runtime.data.providers.Values
            |> Array.tryFind(fun i -> i.p.Caption = caption) with
        | Some provider ->
            let mutable dirty = false
            if provider.p.Logo <> logo then
                provider.p.Logo <- logo
                dirty <- true
            if provider.p.Icon <> icon then
                provider.p.Icon <- icon
                dirty <- true
            if dirty then
                UPROVIDER_update runtime.output provider
        | None -> ())