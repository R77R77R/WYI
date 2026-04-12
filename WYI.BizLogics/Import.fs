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

    "DELETE FROM public.kernel_utilcat" |> tx
    "DELETE FROM public.kernel_utilprovider" |> tx
    "DELETE FROM public.kernel_utilcatprovider" |> tx

    "DELETE FROM public.ca_file" |> tx

    runtime.host.fsDir
    |> Directory.GetFiles
    |> Array.iter(fun f -> 
        File.Delete f
        "Deleted: " + f |> output)

    "DELETE FROM public.kernel_utilbill" |> tx
    "DELETE FROM public.kernel_utilacct" |> tx
    "DELETE FROM public.kernel_unit" |> tx

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

    [|
        // --- Internet | Cellphone | Landlines ---
        ( "Verizon", "https://icon.horse/icon/verizon.com", "https://www.google.com/s2/favicons?domain=verizon.com&sz=32" )
        ( "Verizon Fios", "https://icon.horse/icon/verizon.com", "https://www.google.com/s2/favicons?domain=verizon.com&sz=32" )
        ( "AT&T", "https://icon.horse/icon/att.com", "https://www.google.com/s2/favicons?domain=att.com&sz=32" )
        ( "T-Mobile", "https://icon.horse/icon/t-mobile.com", "https://www.google.com/s2/favicons?domain=t-mobile.com&sz=32" )
        ( "Spectrum", "https://icon.horse/icon/spectrum.com", "https://www.google.com/s2/favicons?domain=spectrum.com&sz=32" )
        ( "Comcast", "https://icon.horse/icon/xfinity.com", "https://www.google.com/s2/favicons?domain=comcast.com&sz=32" )
        ( "Windstream", "https://icon.horse/icon/windstream.com", "https://www.google.com/s2/favicons?domain=windstream.com&sz=32" )
        ( "Frontier", "https://icon.horse/icon/frontier.com", "https://www.google.com/s2/favicons?domain=frontier.com&sz=32" )
        ( "Century Link", "https://icon.horse/icon/centurylink.com", "https://www.google.com/s2/favicons?domain=centurylink.com&sz=32" )
        ( "Optimum", "https://icon.horse/icon/optimum.com", "https://www.google.com/s2/favicons?domain=optimum.com&sz=32" )
        ( "Cox", "https://icon.horse/icon/cox.com", "https://www.google.com/s2/favicons?domain=cox.com&sz=32" )
        ( "RCN", "https://icon.horse/icon/rcn.com", "https://www.google.com/s2/favicons?domain=rcn.com&sz=32" )

        // --- Satellite TV & Radio ---
        ( "Direct TV", "https://icon.horse/icon/directv.com", "https://www.google.com/s2/favicons?domain=directv.com&sz=32" )
        ( "Dish", "https://icon.horse/icon/dish.com", "https://www.google.com/s2/favicons?domain=dish.com&sz=32" )
        ( "Sirius XM", "https://icon.horse/icon/siriusxm.com", "https://www.google.com/s2/favicons?domain=siriusxm.com&sz=32" )

        // --- Security Monitoring ---
        ( "ADT", "https://icon.horse/icon/adt.com", "https://www.google.com/s2/favicons?domain=adt.com&sz=32" )
        ( "Vivint", "https://icon.horse/icon/vivint.com", "https://www.google.com/s2/favicons?domain=vivint.com&sz=32" )
        ( "Brinks", "https://icon.horse/icon/brinks.com", "https://www.google.com/s2/favicons?domain=brinks.com&sz=32" )
        ( "Slomin's", "https://icon.horse/icon/slomins.com", "https://www.google.com/s2/favicons?domain=slomins.com&sz=32" )

        // --- Payroll & Finance ---
        ( "ADP", "https://icon.horse/icon/adp.com", "https://www.google.com/s2/favicons?domain=adp.com&sz=32" )
        ( "Paychex", "https://icon.horse/icon/paychex.com", "https://www.google.com/s2/favicons?domain=paychex.com&sz=32" )
        ( "Global", "https://icon.horse/icon/globalpaymentsinc.com", "https://www.google.com/s2/favicons?domain=globalpaymentsinc.com&sz=32" )
        ( "World Pay", "https://icon.horse/icon/worldpay.com", "https://www.google.com/s2/favicons?domain=worldpay.com&sz=32" )

        // --- Trash & Facilities ---
        ( "Waste Mgmt.", "https://icon.horse/icon/wm.com", "https://www.google.com/s2/favicons?domain=wm.com&sz=32" )
        ( "Republic", "https://icon.horse/icon/republicservices.com", "https://www.google.com/s2/favicons?domain=republicservices.com&sz=32" )
        ( "GFL", "https://icon.horse/icon/gflenv.com", "https://www.google.com/s2/favicons?domain=gflenv.com&sz=32" )
        ( "Local companies", "https://img.icons8.com/color/96/truck.png", "https://img.icons8.com/color/32/truck.png" )
        ( "Otis", "https://icon.horse/icon/otis.com", "https://www.google.com/s2/favicons?domain=otis.com&sz=32" )

        // --- Pest Control & Lawn Care ---
        ( "Terminix", "https://icon.horse/icon/terminix.com", "https://www.google.com/s2/favicons?domain=terminix.com&sz=32" )
        ( "Orkin", "https://icon.horse/icon/orkin.com", "https://www.google.com/s2/favicons?domain=orkin.com&sz=32" )
        ( "Plunkett's", "https://icon.horse/icon/plunketts.net", "https://www.google.com/s2/favicons?domain=plunketts.net&sz=32" )
        ( "TruGreen", "https://icon.horse/icon/trugreen.com", "https://www.google.com/s2/favicons?domain=trugreen.com&sz=32" )

        // --- Subscriptions & SaaS ---
        ( "Adobe", "https://icon.horse/icon/adobe.com", "https://www.google.com/s2/favicons?domain=adobe.com&sz=32" )
        ( "Salesforce", "https://icon.horse/icon/salesforce.com", "https://www.google.com/s2/favicons?domain=salesforce.com&sz=32" )
        ( "HubSpot", "https://icon.horse/icon/hubspot.com", "https://www.google.com/s2/favicons?domain=hubspot.com&sz=32" )

        // --- Advertising & Water ---
        ( "Billboards", "https://img.icons8.com/color/96/billboard.png", "https://img.icons8.com/color/32/billboard.png" )
        ( "Newspapers", "https://img.icons8.com/color/96/news.png", "https://img.icons8.com/color/32/news.png" )
        ( "Magazines", "https://img.icons8.com/color/96/magazine.png", "https://img.icons8.com/color/32/magazine.png" )
        ( "Yellow Pages", "https://icon.horse/icon/yellowpages.com", "https://www.google.com/s2/favicons?domain=yellowpages.com&sz=32" )
        ( "Ready Refresh", "https://icon.horse/icon/readyrefresh.com", "https://www.google.com/s2/favicons?domain=readyrefresh.com&sz=32" )
        ( "Primo", "https://icon.horse/icon/primowater.com", "https://www.google.com/s2/favicons?domain=primowater.com&sz=32" )
        ( "Crystal Rock", "https://icon.horse/icon/crystalrock.com", "https://www.google.com/s2/favicons?domain=crystalrock.com&sz=32" )
        |]     
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