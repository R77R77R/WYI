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
    //"DELETE FROM public.kernel_utilcat" |> tx
    //"DELETE FROM public.kernel_utilprovider" |> tx
    //"DELETE FROM public.kernel_utilcatprovider" |> tx


    //"DELETE FROM public.ca_file" |> tx
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
        // --- Internet & Cable TV (Telcos) ---
        ( "Verizon", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgNTAwIDExMiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cGF0aCBmaWxsPSIjRTMwMDE2IiBkPSJNMTEwLjYgNzkuNEw4Ni40IDUwaDI0LjJWMjQuMkg3OS40djU1LjJoMzEuMnpNNTQuOCAxMi45Yy0zMSAwLTUxLjcgMjIuMi01MS43IDUxLjUgMCAyOS4xIDIwLjcgNTEuNSA1MS43IDUxLjVzNTEuNy0yMi40IDUxLjctNTEuNWMwLTI5LjEtMjAuNy01MS41LTUxLjctNTEuNXoiLz48L3N2Zz4=", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAMklEQVR4AWP4//8/AyUYGfABD8Ax6vBDWjD6IBp9EI0+iEYfRKMPotEH0eiDaPRBNPoAAL0S6967U1mGAAAAAElFTkSuQmCC" )
        ( "Verizon Fios", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgNTAwIDExMiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cGF0aCBmaWxsPSIjRTMwMDE2IiBkPSJNMTEwLjYgNzkuNEw4Ni40IDUwaDI0LjJWMjQuMkg3OS40djU1LjJoMzEuMnpNNTQuOCAxMi45Yy0zMSAwLTUxLjcgMjIuMi01MS43IDUxLjUgMCAyOS4xIDIwLjcgNTEuNSA1MS43IDUxLjVzNTEuNy0yMi40IDUxLjctNTEuNWMwLTI5LjEtMjAuNy01MS41LTUxLjctNTEuNXoiLz48L3N2Zz4=", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAMklEQVR4AWP4//8/AyUYGfABD8Ax6vBDWjD6IBp9EI0+iEYfRKMPotEH0eiDaPRBNPoAAL0S6967U1mGAAAAAElFTkSuQmCC" )
        ( "Spectrum", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiMwMDYyQTkiIGQ9Ik0wIDEwaDcuM2wyLjYgNS40TDEyLjUgMTBIMjB2MTBoLTUuNnYtMy4xbC0yLjMgMi44aC0yLjRsLTIuMy0yLjhWMTBIMHoiLz48L3N2Zz4=", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "Comcast", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiNFMjExMTciIGQ9Ik0xMCAxMEM1IDExIDAgMTUgMCAyMHMwIDUgNSAxMCAxMCAwIDEwLTVWMTB6Ii8+PC9zdmc+", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFElEQVR4AWP4z8BARYwM+DAbfRCNBwBvVQDvH5A98AAAAABJRU5ErkJggg==" )
        ( "Optimum", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiMwMDcxQjgiIGQ9Ik01IDVIMTB2MjBINTV6Ii8+PC9zdmc+", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "Cox", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiMwMDY3QjIiIGQ9Ik01MCAwQzMwIDAgMTAgMTUgMTAgMzVzMjAgMzUgNDAgMzVzNDAtMTUgNDAtMzVTNzAgMCA1MCAweiIvPjwvc3ZnPg==", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "Frontier", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiNGRjAwMDAiIGQ9Ik0wIDEwaDQwdjEwSDB6Ii8+PC9zdmc+", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "Windstream", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiM0QTkxM0QiIGQ9Ik0wIDEwaDMwdjIwSDB6Ii8+PC9zdmc+", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "Century Link", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiMwMDgwMDAiIGQ9Ik0xMCAxMGgyMHYyMEgxMHoiLz48L3N2Zz4=", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "RCN", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiNEMjExMUEiIGQ9Ik0wIDEwaDUwdjIwSDB6Ii8+PC9zdmc+", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )

        // --- Cellphone ---
        ( "AT&T", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMzggMzgiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PHBhdGggZmlsbD0iIzAwQTFFRiIgZD0iTTE5IDBDOC41IDAgMCA4LjUgMCAxOXM4LjUgMTkgMTkgMTkgMTkgMTktOC41IDE5LTE5UzI5LjUgMCAxOSAwem0wIDM2Yy05LjQgMC0xNy03LjYtMTctMTdTOS42IDIgMTkgMiAxNyA5LjYgMTcgMTljMCA5LjQtNy42IDExIDExIDEzeiIvPjwvc3ZnPg==", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAEUlEQVR4AWP4z8BARYwM+AADAIsAFv6z6BMAAAAASUVORK5CYII=" )
        ( "T-Mobile", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDQwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiNFMTAwN0YiIGQ9Ik0wIDBoMTR2MjRIMFYwek00MyAwaDE0djI0SDQzVjB6TTg2IDBoMTR2MjRIODZWMHoiLz48L3N2Zz4=", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )

        // --- Satellite ---
        ( "Direct TV", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiMwMDY3QjIiIGQ9Ik01MCAwTDk0IDI1SDB6Ii8+PC9zdmc+", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "Dish", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiNFMjExMTciIGQ9Ik01IDVIMTV2MjBINXoiLz48L3N2Zz4=", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "Sirius XM", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiMwMDY3QjIiIGQ9Ik0xMCAxMGgyMHYyMEgxMHpNMzAgMTBoNDB2MjBIMzB6Ii8+PC9zdmc+", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )

        // --- Security ---
        ( "ADT", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDUwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiMwMDVEOEEiIGQ9Ik0wIDBoMTAwdjUwSDB6TTIwIDEwaDYwdjMwSDIweiIvPjwvc3ZnPg==", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "Vivint", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiNGRjU5MDAiIGQ9Ik0xMCAxMGgyMHYyMEgxMHoiLz48L3N2Zz4=", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "Brinks", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiMwMDAwMDAiIGQ9Ik01IDVIMTFWMTVINXpNMjAgNkg4MFYxOEgyMHoiLz48L3N2Zz4=", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "Slomin's", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiNFRjA0MDQiIGQ9Ik0xMCAxMEgyMHYyMEgxMHoiLz48L3N2Zz4=", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )

        // --- Payroll & Finance ---
        ( "ADP", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDQwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiNEMjExMUEiIGQ9Ik0xMCAxMEgyMHYzMEgxMHpNMzAgMTBINTB2MTBIMzB6TTMwIDMwSDUwdjEwSDMweiIvPjwvc3ZnPg==", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "Paychex", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiMwMDY3QjIiIGQ9Ik0wIDBoMTAwdjMwSDB6TTEwIDExaDgwVjIwSDEweiIvPjwvc3ZnPg==", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "Global", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiMwMDAwMDAiIGQ9Ik01MCAwQzMwIDAgMTAgMTUgMTAgMzVTNTAgNzAgNTAgNzB6Ii8+PC9zdmc+", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "World Pay", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiM1MzMxM0UiIGQ9Ik0wIDBoMTAwdjMwSDB6Ii8+PC9zdmc+", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )

        // --- Facility & Maintenance ---
        ( "Waste Mgmt.", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiMwMDcwMzkiIGQ9Ik0wIDEwaDQwdjIwSDB6TTEwIDExaDIwdjExSDEweiIvPjwvc3ZnPg==", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "Republic", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiMwMDY3QjIiIGQ9Ik01IDVIMTV2MjBINXpNMTggNUg5OFYyMEgxOHoiLz48L3N2Zz4=", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "GFL", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiM4N0IyMDAiIGQ9Ik0wIDEwaDMwdjIwSDB6Ii8+PC9zdmc+", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "Local companies", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiM4MDgwODAiIGQ9Ik0wIDEwaDExMHYyMEgwem0xMCAxaDgwVjIwSDEweiIvPjwvc3ZnPg==", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )

        ( "Terminix", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiMwMDgwMDAiIGQ9Ik0wIDEwaDEwMHYyMEgwem0xMCAxaDgwdjExSDEweiIvPjwvc3ZnPg==", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "Orkin", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiNFRjA0MDQiIGQ9Ik0wIDEwaDEwMHYyMEgwem0xMCAxaDgwdjExSDEweiIvPjwvc3ZnPg==", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "TruGreen", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiMwMDcwMzkiIGQ9Ik0wIDEwaDEwMHYyMEgwem0xMCAxaDgwdjExSDEweiIvPjwvc3ZnPg==", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "Otis", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiMwMDAwMDAiIGQ9Ik0wIDEwaDMwdjIwSDB6TTEwIDExaDEwdjExSDEweiIvPjwvc3ZnPg==", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )

        // --- SaaS & Subs ---
        ( "Adobe", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgNTEyIDUxMiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cGF0aCBmaWxsPSIjRkYwMDAwIiBkPSJNMzIzLjUgMTYwaC0xMzVMMTkyIDQ0OGg3Mi41bDMxLTY3LjVoNzIuNWwzMSA2Ny41SDQ0OHpNMjU2IDMxMmwzMi03MS4xaC02NHoiLz48L3N2Zz4=", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGklEQVR4AWP4z8BARYwM+DAbfRCNPggYfRCNBwBvVQDvH5A98AAAAABJRU5ErkJggg==" )
        ( "Salesforce", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDcwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiMwMEExRTIiIGQ9Ik01MCAwQzMwIDAgMTUgMTUgMTUgMzVzMTUgMzUgMzUgMzVzMzUtMTUgMzUtMzVTMzAgMCA1MCAweiIvPjwvc3ZnPg==", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAMklEQVR4AWP4//8/AyUYGfABD8Ax6vBDWjD6IBp9EI0+iEYfRKMPotEH0eiDaPRBNPoAAL0S6967U1mGAAAAAElFTkSuQmCC" )
        ( "HubSpot", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiNGRjc3MDAiIGQ9Ik01MCAwQzMwIDAgMTAgMTAgMTAgMzBzMjAgMzAgNDAgMzBzNDAtMTAgNDAtMzBTNzAgMCA1MCAweiIvPjwvc3ZnPg==", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )

        // --- Advertising & Water ---
        ( "Yellow Pages", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiNGRkRBMTAiIGQ9Ik0wIDEwaDExMHYyMEgwem0xMCAxaDgwdjExSDEweiIvPjwvc3ZnPg==", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
        ( "Ready Refresh", "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDMwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGZpbGw9IiMwMDZBQTMiIGQ9Ik01MCAwQzMwIDAgMTAgMTAgMTAgMzBTMzAgNjAgNTAgNjBTOTAgMzAgOTAgMTB6Ii8+PC9zdmc+", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAFklEQVR4AWP4z8BARYwM+DAbfRCNPggAAL8pA9H87v8AAAAAAElFTkSuQmCC" )
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