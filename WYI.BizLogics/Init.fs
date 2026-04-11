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

    WYI.BizLogics.Import.clearData()

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
    
    //WYI.BizLogics.Import.importUtilProviders()

    (fun (i:EU) -> runtime.users[i.ID] <- { 
        units = createModDictInt64 2
        acctxs = createModDictInt64 2
        billxs = createModDictInt64 2
        eu = i })
    |> loadAll runtime.output conn EU_metadata

    (fun (i:UNIT) ->
        let eux = runtime.users[i.p.Owner]
        eux.units[i.ID] <- i)
    |> loadAll runtime.output conn UNIT_metadata

    let files =
        let res = Dictionary<int64,List<FILE>>()
        (fun i -> 
            if res.ContainsKey i.p.Bill = false then
                res[i.p.Bill] <- new List<FILE>()
            res[i.p.Bill].Add i)
        |> loadAll runtime.output conn FILE_metadata
        res

    (fun (ubill:UBILL) ->
        let eux = runtime.users[ubill.p.Owner]

        let cato,providero =
            match
                runtime.data.catproviders
                |> Array.tryFind(fun kucp ->
                    kucp.p.Cat = ubill.p.Cat && kucp.p.Provider = ubill.p.Provider) with
            | Some kucp -> 
                runtime.data.cats[kucp.p.Cat] |> Some,runtime.data.providers[kucp.p.Provider] |> Some
            | None -> None,None
        
        eux.billxs[ubill.ID] <- {
            cato = cato
            providero = providero
            owner = eux.eu
            unito = eux.units.TryGet ubill.p.Unit
            accto = None
            files = files[ubill.ID].ToArray()
            bill = ubill })
    |> loadAll runtime.output conn UBILL_metadata

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
            acctxs = createModDictInt64 2
            billxs = createModDictInt64 2
            eu = rcd }
        | None -> halt runtime.output ("BizLogics.Init.createEU") ""





