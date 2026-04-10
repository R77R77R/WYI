module WYI.BizLogics.Common

open System
open System.Collections.Generic
open System.Collections.Concurrent

open Util.Cat
open Util.Db
open Util.DbTx
open Util.CollectionModDict
open Util.Orm

open UtilKestrel.Types
open UtilKestrel.Ctx
open UtilKestrel.DbLogger
open UtilKestrel.Runtime

open WYI.Shared.OrmTypes
open WYI.Shared.OrmMor
open WYI.Shared.Types


type Session = SessionTemplate<EuComplex,unit>
type Sessions = SessionsTemplate<EuComplex,unit>

type HostData = {
mutable version: int }

type Runtime = RuntimeTemplate<EuComplex,unit,RuntimeData,HostData>

type X = EchoCtx<Runtime,Session,Er>
type WrapX = CtxWrapper<X,Er>

let runtime = 

    let h = {
        data = { version = 0 }
        port = 1723
        rdbms = Util.Db.Rdbms.PostgreSql
        conn = ""
        url = ""
        cert = ""
        certpwd = ""

        updateDatabase = true

        VsDirSolution = "C:/Dev/WYI"
        req__vueDeployDir = @"C:/Dev/WYI/vscode/dist"
        fsDir = @"C:/FsRoot/WYI" }


    {   apiKeyGemini = ""
        aiModel = "gemini-2.5-flash"
        cats = createModDictInt64 8
        providers = createModDictInt64 8
        catproviders = [||] }
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
        
