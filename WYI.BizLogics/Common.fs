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
        conn = "server=.; database=Studio; Trusted_Connection=True;"
        url = ""

        updateDatabase = true

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

        VsDirSolution = "C:/Dev/Studio"
        req__vueDeployDir = (fun _ -> @"C:/Dev/Studio/vscode/dist")
        fsDir = @"C:/FsRoot/Studio" }

    let hostEnum = 
        let machinename = Environment.MachineName
        match Environment.MachineName with
        | "MAIN" -> HostEnum.Dev
        | "PTNHKDIE15IJZN" -> HostEnum.Kamatera
        | "ubuntu-2gb-ash-1" -> HostEnum.HetznerEastUSA
        | _ -> HostEnum.Dev

    match hostEnum with
    | HostEnum.Kamatera -> 
        h.conn <- "server=localhost\MSSQLSERVER01; database=Studio; Trusted_Connection=True;"
    | _ -> ()

    {   books = new List<BOOK>() }
    |> empty__Runtime<EuComplex,unit,HostData,RuntimeData> "Studio" h


let dbLoggero =
    (fun log -> 
        let p = pLOG_empty()
        p.Content <- log.content
        p.Location <- log.location
        p.Sql <- log.sql
        p)
    |> createDbLogger LOG_metadata conn
    |> Some
        
