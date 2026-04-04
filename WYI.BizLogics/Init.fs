module WYI.BizLogics.Init

open System
open System.IO
open System.Collections.Generic
open System.Collections.Concurrent
open System.Threading

open Util.Runtime
open Util.Bin
open Util.Concurrent
open Util.Json
open Util.Collection
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

    conn <- runtime.host.conn
    rdbms <- runtime.host.rdbms

    let mutable rootPath = ""
    match Environment.MachineName with
    | "ubuntu-2gb-hil-1" -> 
        runtime.host.updateDatabase <- false
        runtime.host.cert <- "/root/aspnetapp.pfx"
        rootPath <- "/root"
    | _ -> 
        runtime.host.cert <- 
            Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "aspnetapp.pfx")
        rootPath <- @"C:"
    runtime.host.certpwd <- "123456"

    runtime.host.VsDirSolution <- rootPath + "/Dev/WYI"
    runtime.host.fsDir <- rootPath + "/FsRoot/WYI"
    runtime.host.req__vueDeployDir <- runtime.host.VsDirSolution + "/vscode/dist"

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

    if false then

        //UtilKestrel.Open.Google.GeminiListModels
        //    runtime.output
        //    runtime.data.apiKeyGemini

        UtilKestrel.Open.Google.GeminiMultimodal
            runtime.output 
            runtime.data.apiKeyGemini
            "gemini-2.5-flash"
            "从我上传的文件中提取票号" 
            [| @"G:\我的云端硬盘\Flying\tokyo-lingual.pdf" |]
        |> Async.RunSynchronously
        |> ignore

        UtilKestrel.Open.Google.GeminiChat
            runtime.output
            runtime.data.apiKeyGemini
            "gemini-2.5-flash"
            "给我当前时间"
        |> Async.RunSynchronously
        |> runtime.output

    (fun (i:UCAT) -> runtime.data.cats[i.ID] <- i)
    |> loadAll runtime.output conn UCAT_metadata

    (fun (i:UPROVIDER) -> runtime.data.providers[i.ID] <- i)
    |> loadAll runtime.output conn UPROVIDER_metadata

    let importUtilProviders () = 
        let txt = """
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
    Monthly Recurring Bills | (Miscellaneous)    """

        txt.Split Util.Text.crlf
        |> Array.map(fun s -> s.Trim())
        |> Array.filter(fun s -> s.Contains "|")
        |> Array.map(fun s -> 
            let ss = s.Split "|"
            let cat = ss[0].Trim()
            let provider = ss[1].Trim()
            cat,provider)
        |> Array.filter(fun (cat,provider) -> 
            provider.StartsWith "(" = false && provider.EndsWith ")" = false)
        |> Array.map(fun (cat,provider) -> 
            match
                (match
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
                    | None -> None) with
            | Some ucat -> 
                match
                    runtime.data.providers.Values
                    |> Array.tryFind(fun i -> i.p.Caption = provider) with
                | Some uprovider -> ()
                | None ->
                    match
                        (fun (p:pUPROVIDER) ->
                            p.Cat <- ucat.ID
                            p.Caption <- provider) 
                        |> creator UPROVIDER_metadata with
                    | Some v -> 
                        runtime.data.providers[v.ID] <- v
                    | None -> ()            
            | None -> ())
    //importUtilProviders()

    (fun (i:EU) -> runtime.users[i.ID] <- { eu = i })
    |> loadAll runtime.output conn EU_metadata

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
        | Some rcd -> runtime.users[rcd.ID] <- { eu = rcd }
        | None -> halt runtime.output ("BizLogics.Init.createEU") ""





