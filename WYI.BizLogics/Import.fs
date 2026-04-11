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

    [|  "Verizon","","data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABlElEQVR4AWXSg46eQRhA4Wdm/9pYG9dQu+FuUN9g3aBcBLXdoLbtrjGd+kv3JGfseWPv1Nab2VRwW7YsCyCX/W7bnk0Fb0R0KsJC1BtP/e++Ip0R+/AOAM1YVtgZYDmaAPAW+yKu4TIAytAhKGUBSuj43QdwGdcivqEbQMAkS83WYhaAVixRhB70RsARvBYxDZXq1KZV5iWAVagDwCscgQiSO4LzJmN+oiYFTand+jTRoEloRwDAedyBKGCWPEynWZJy8gK0WKgytUnasBAACV0YFIjTeu8zFTMdMys9MwdVaExVmqxVylIJgGc4BnmuCGYkBjwwy2kzE3NRjXlpi9m2SIqcxgOACKZj2dhIzrtMNmpaYk72U1gkFo+f++jEiABEmHb6AWWYmE4qeSSghFOh5HMxHnIfp/4cHyKAMtwKTyQnDAReZ49kxxQ5LniiQARII4FlacyQTl8NuRy4nY0AhtApGRPHL2D6ngd8Q6+z3rnnbKAPAcBdnINp3+6PXwD0Yq6XnoeT7gYY+S2cFHLff3wHuO+UkmFYpsMAAAAASUVORK5CYII=" |]
    |> Array.iter(fun (caption,logo,icon) -> 
        match
            runtime.data.providers.Values
            |> Array.tryFind(fun i -> i.p.Caption = caption) with
        | Some provider ->
            
            ()
        | None -> ())