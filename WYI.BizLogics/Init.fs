module Studio.BizLogics.Init

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

open Studio.Shared.OrmTypes
open Studio.Shared.OrmMor
open Studio.Shared.Types
open Studio.Shared.CustomMor

open Studio.BizLogics.Common
open Studio.BizLogics.Db

let init (runtime:Runtime) = 

    "Init ..."
    |> runtime.output

    conn <- runtime.host.conn

    if runtime.host.updateDatabase then
        updateDbStructure runtime conn

    Studio.Shared.OrmMor.init()

    let users = runtime.users.Values |> Seq.toArray
    match users |> Array.tryFind(fun i -> i.eu.p.AuthType = euAuthTypeEnum.Admin) with
    | Some rcd -> ()
    | None -> 
        match createEU "sa" euAuthTypeEnum.Admin with
        | Some rcd -> runtime.users[rcd.ID] <- { eu = rcd }
        | None -> halt runtime.output ("BizLogics.Init.createEU") ""

    (fun (i:BOOK) -> runtime.data.books.Add i)
    |> loadAll runtime.output conn BOOK_metadata




