module WYI.BizLogics.Init

open System
open System.IO
open System.Collections.Generic
open System.Collections.Concurrent
open System.Threading

open Util.Runtime
open Util.Cat
open Util.Concurrent
open Util.Json
open Util.CollectionModDict
open Util.Db
open Util.DbTx
open Util.Orm

open UtilKestrel.Constants
open UtilKestrel.DbLogger
open UtilKestrel.Init
open UtilKestrel.FileSys
open UtilKestrel.Api

open WYI.Shared.OrmTypes
open WYI.Shared.OrmMor
open WYI.Shared.Types
open WYI.Shared.CustomMor

open WYI.BizLogics.Common
open WYI.BizLogics.Db

let init (runtime:Runtime) = 

    "Init ..."
    |> runtime.output

    let mutable rootPath = ""
    match Environment.MachineName with
    | "ubuntu-2gb-hil-1" -> 
        runtime.host.conn <- @"Host=5.78.201.21;Port=5432;Database=wyi;Username=wyi;Password=e2TpqcaTEYLfkvFMkc"
        runtime.host.cert <- "/root/aspnetapp.pfx"
        rootPath <- "/root"
    | _ -> 
        runtime.host.conn <- @"Host=localhost;Port=5432;Database=wyi;Username=wyi;Password=e2TpqcaTEYLfkvFMkc"
        runtime.host.cert <- 
            Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "aspnetapp.pfx")
        rootPath <- @"C:"
    runtime.host.certpwd <- "123456"

    runtime.host.VsDirSolution <- rootPath + "/Dev/WYI"
    runtime.host.fsDir <- rootPath + "/FsRoot/WYI"
    runtime.host.req__vueDeployDir <- runtime.host.VsDirSolution + "/vscode/dist"

    runtime.host.ToString() |> runtime.output

    conn <- runtime.host.conn
    rdbms <- runtime.host.rdbms

    if runtime.host.updateDatabase then
        updateDbStructure runtime conn

    WYI.Shared.OrmMor.init()

    let config = 
        let res = new Dictionary<string,string>()

        (fun (i:CONFIG) -> res[i.p.Key] <- i.p.Val)
        |> loadAll runtime.output conn CONFIG_metadata
    
        res
        
    runtime.data.apiKeyGemini <-
        let key = "ApiKeyGemini"
        if config.ContainsKey key = false then
            let p = pCONFIG_empty()
            p.Key <- key
            CONFIG_create_incremental_transaction 
                runtime.output ((fun rcd -> ()),(fun (eso,ctx) -> ())) p
        config["ApiKeyGemini"]

    (fun (i:UCAT) -> runtime.data.cats[i.ID] <- i)
    |> loadAll runtime.output conn UCAT_metadata

    (fun (i:UPROVIDER) -> runtime.data.providers[i.ID] <- i)
    |> loadAll runtime.output conn UPROVIDER_metadata

    (fun (i:KUCP) -> 
        runtime.data.catproviders <- 
            [|  runtime.data.catproviders
                [|  i  |] |]
            |> Array.concat)
    |> loadAll runtime.output conn KUCP_metadata

    let importUtilProviders () = 

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
            s |> runtime.output
            let ss = s.Split "|"
            let cat = ss[0].Trim()
            [| 1 .. ss.Length - 1|]
            |> Array.iter(fun i ->
                let provider = ss[i].Trim()
                (cat,provider) |> lines.Add))

        lines.ToArray()
        |> Array.iter(fun (cat,provider) -> 
            cat + " / " + provider |> runtime.output

            match getOrAddCat cat with
            | Some ucat -> 
                getOrAddProvider ucat provider
            | None -> halt runtime.output "" ""
        )
    
    importUtilProviders()

    (fun (i:EU) -> runtime.users[i.ID] <- { 
        units = createModDictInt64 2
        billxs = createModDictInt64 2
        eu = i })
    |> loadAll runtime.output conn EU_metadata

    (fun (i:UNIT) ->
        let eux = runtime.users[i.p.Owner]
        eux.units[i.ID] <- i)
    |> loadAll runtime.output conn UNIT_metadata

    let users = runtime.users.Values |> Seq.toArray

    let sapwd = Util.Crypto.str__sha256 "21:16 EST, March 17th, 2026"

    match 
        users 
        |> Array.tryFind(fun i -> 
            i.eu.p.Username = "sa"
            && i.eu.p.AuthType = euAuthTypeEnum.Admin) with
    | Some rcd -> ()
    | None -> 
        match createEU 
            "sa" sapwd
            "System Administrator" euAuthTypeEnum.Admin with
        | Some rcd -> runtime.users[rcd.ID] <- { 
            units = createModDictInt64 2
            billxs = createModDictInt64 2
            eu = rcd }
        | None -> halt runtime.output ("BizLogics.Init.createEU") ""





