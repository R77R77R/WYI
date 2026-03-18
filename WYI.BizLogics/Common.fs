module WYI.BizLogics.Common

open System
open System.Collections.Generic
open System.Collections.Concurrent

open Util.Cat
open Util.Db
open Util.DbTx
open Util.CollectionModDict
open Util.Orm

open UtilWebServer.Common
open UtilWebServer.Db
open UtilWebServer.DbLogger
open UtilWebServer.Runtime

open WYI.Shared.OrmTypes
open WYI.Shared.OrmMor
open WYI.Shared.Types


type Session = SessionTemplate<EuComplex,unit>
type Sessions = SessionsTemplate<EuComplex,unit>

type HostData = {
mutable version: int }

type Runtime = RuntimeTemplate<EuComplex,unit,RuntimeData,HostData>

type X = UtilWebServer.Api.ApiCtx<Runtime,Session,Er>

type CtxWrappedX = CtxWrapper<X,Er>

type HostEnum = 
| Dev
| Kamatera
| HetznerEastUSA

let runtime = 

    let h = {
        data = { version = 0 }
        port = 1723
        rdbms = Util.Db.Rdbms.PostgreSql
        conn = @"Host=178.156.223.41;Port=5432;Database=wyi;Username=wyi;Password=e2TpqcaTEYLfkvFMkc"
        url = ""

        updateDatabase = false

        DiscordAppId = 
            [|  "1254790111"
                "913181274" |]
            |> String.Concat
        DiscordPubKey = 
            [|  "e0300e71e2dc"
                "94ec42425c"
                "eea8faed6b6"
                "172158dbbc1"
                "b882fa2750f"
                "b55dec22a" |]
            |> String.Concat
        DiscordSecret = 
            [|  "YwZeJGUrR"
                "JwL3E7V"
                "cwlgtvJ_"
                "oeT01nom" |]
            |> String.Concat

        VsDirSolution = "C:/Dev/WYI"
        req__vueDeployDir = (fun _ -> @"C:/Dev/WYI/vscode/dist")
        fsDir = @"C:/FsRoot/WYI" }

    let hostEnum = 
        let machinename = Environment.MachineName
        match Environment.MachineName with
        | "MAIN" -> HostEnum.Dev
        | "PTNHKDIE15IJZN" -> HostEnum.Kamatera
        | "ubuntu-2gb-ash-1" -> HostEnum.HetznerEastUSA
        | _ -> HostEnum.Dev

    match hostEnum with
    | HostEnum.HetznerEastUSA -> 
        h.updateDatabase <- true
    | _ -> 
        h.updateDatabase <- true


    {   desc = "" }
    |> empty__Runtime<EuComplex,unit,HostData,RuntimeData> "WYI" h


let dbLoggero =
    (fun log -> 
        let p = pLOG_empty()
        p.Content <- log.content
        p.Location <- log.location
        p.Sql <- log.sql
        p)
    |> createDbLogger LOG_metadata conn
    |> Some
        
