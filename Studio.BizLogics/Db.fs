module Studio.BizLogics.Db

open System
open System.IO
open System.Threading
open System.Text
open System.Collections.Generic
open System.Collections.Concurrent

open Util.Text
open Util.Crypto
open Util.Db
open Util.DbTx
open Util.Orm
open Util.Zmq

open UtilWebServer.DbLogger
open UtilWebServer.Db
open UtilWebServer.Common

open Studio.Shared.OrmTypes
open Studio.Shared.Types
open Studio.Shared.OrmMor
open Studio.Shared.CustomMor

open Studio.BizLogics.Common

let dbLoggero =
    (fun log -> 
        let p = pLOG_empty()
        p.Content <- log.content
        p.Location <- log.location
        p.Sql <- log.sql
        p)
    |> createDbLogger LOG_metadata conn
    |> Some

let creator metadata populate = 
    let p = metadata.empty__p()
    populate p
    p__createRcd p metadata dbLoggero metadata.table conn

let createEU caption auth = 
    (fun (p:pEU) -> 
        p.Caption <- caption
        p.AuthType <- auth) 
    |> creator EU_metadata
