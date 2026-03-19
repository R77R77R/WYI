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
open Util.Zmq

open UtilWebServer.Constants
open UtilWebServer.DbLogger
open UtilWebServer.Init
open UtilWebServer.FileSys
open UtilWebServer.Api

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
        runtime.host.cert <- ""
        rootPath <- "/root/aspnetapp.pfx"
    | _ -> 
        runtime.host.cert <- 
            Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "aspnetapp.pfx")
        rootPath <- @"C:"
    runtime.host.certpwd <- "123456"

    runtime.host.VsDirSolution <- rootPath + "/Dev/WYI"
    runtime.host.fsDir <- rootPath + "/FsRoot/WYI"
    runtime.host.req__vueDeployDir <- 
        (fun _ -> runtime.host.VsDirSolution + "/vscode/dist")

    if runtime.host.updateDatabase then
        updateDbStructure runtime conn

    WYI.Shared.OrmMor.init()

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





