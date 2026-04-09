module WYI.BizLogics.Branch

open System
open System.Text
open System.Collections.Generic
open System.Threading

open Microsoft.AspNetCore.Http

open Util.Cat
open Util.Text
open Util.Bin
open Util.CollectionModDict
open Util.Perf
open Util.Json
open Util.Orm

open WYI.Shared.OrmTypes
open WYI.Shared.Types
open WYI.Shared.OrmMor
open WYI.Shared.CustomMor

open UtilKestrel.Types
open UtilKestrel.Ctx
open UtilKestrel.Api
open UtilKestrel.Json
open UtilKestrel.SSR
open UtilKestrel.Server

open WYI.BizLogics.Common
open WYI.BizLogics.Auth
open WYI.BizLogics.ApiPublic
open WYI.BizLogics.ApiEu

let output = runtime.output

let branching (euxo:EuComplex option) (x:X) = 

    let bindx p = 
        x.Struct.proco <- Some p
        Suc x

    match x.Struct.scheme with
    | "public" -> 
        match x.Struct.api with
        | "ping" -> bindx apiPing
        | "auth" -> bindx auth
        | "providers" -> bindx providers
        | "msg" -> (fun (x:X) -> 
            let json = x.Json
            let name = (tryFindStrByAtt "name" json).Trim()
            let email = (tryFindStrByAtt "email" json).Trim()
            let msg = (tryFindStrByAtt "msg" json).Trim()

            [| ok |]) |> bindx
        | _ -> Fail(Er.ApiNotExists,x)
    | "eu" -> 
        let eux = euxo.Value
        match x.Struct.api with
        | "review-bill-files" -> reviewBillFiles eux |> bindx
        | "submit-bill" -> bindx submitBill
        | _ -> Fail(Er.ApiNotExists,x)
    | "admin" -> 
        match x.Struct.api with
        | "plogs" -> (fun x -> 
            let metadata = PLOG_metadata
            match "ORDER BY ID DESC" |> loadall conn (metadata.table,metadata.fieldorders(),metadata.db__rcd) with
            | Some items ->
                items
                |> Array.filter(fun i -> (UtilKestrel.PageLog.req__fromo i.p.Request).IsSome)
                |> (fun items -> if items.Length > 200 then Array.sub items 0 200 else items)
                |> Array.map(fun rcd -> UtilKestrel.PageLog.req__json (rcd.p.Ip,rcd.Createdat,rcd.p.Request))
            | None -> [| |]
            |> wrapOkAry) |> bindx
        | "monitorPerf" -> bindx apiMonitorPerf
        | _ -> Fail(Er.ApiNotExists,x)
    | "open" -> Fail(Er.ApiNotExists,x)
    | _ -> Fail(Er.ApiNotExists,x)

let branch (x:X) = 

    use cw = new CodeWrapper("Server.WebHandler.branch")
    
    let checkEuxo() = 
        let session =
            x.Json
            |> tryFindStrByAtt "session"
        
        match
            runtime.sessions.TryGet session with
        | Some s -> 
            if DateTime.UtcNow.Ticks > s.expiry.Ticks then
                runtime.sessions.Remove session
                None
            else
                x.Struct.sessiono <- Some s
                s.identity
        | None -> None

    let authorized,euxo = 
        match x.Struct.scheme with
        | "eu" -> 
            match checkEuxo() with
            | Some eux -> true,Some eux
            | None -> false,None
        | "admin" -> 
            match checkEuxo() with
            | Some eux -> eux.eu.p.AuthType = euAuthTypeEnum.Admin,Some eux
            | None -> false,None
        | _ -> true,None

    x.Struct.contentType <- "application/json; charset=utf-8"
    x.Struct.rep <-
        if authorized then
            runApi (branching euxo) x 
        else
            er Er.Unauthorized
        |> Braket
        |> json__strFinal
        |> Encoding.UTF8.GetBytes
