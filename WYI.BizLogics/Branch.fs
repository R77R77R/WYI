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
open WYI.BizLogics.Api

let output = runtime.output

let branching (x:X) = 

    let bindx p = 
        x.Struct.proco <- Some p
        Suc x

    match x.Struct.scheme with
    | "public" -> 
        match x.Struct.api with
        | "ping" -> bindx apiPing
        | "auth" -> bindx auth
        | "providers" -> bindx providers
        | "review-bills" -> bindx reviewBills
        | "msg" -> (fun (x:X) -> 
            let json = x.Json
            let name = (tryFindStrByAtt "name" json).Trim()
            let email = (tryFindStrByAtt "email" json).Trim()
            let msg = (tryFindStrByAtt "msg" json).Trim()

            [| ok |]) |> bindx
        | _ -> Fail(Er.ApiNotExists,x)
    | "eu" -> 
        match x.Struct.api with
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
    
    //match service with
    //| "eu" ->
    //    x <- 
    //        x 
    //        |> bind checkSession
    //        |> bind checkSessionEu
    //| "admin" ->
    //    x <- 
    //        x 
    //        |> bind checkSession
    //        |> bind checkSessionEu
    //| "open" ->
    //    x <- 
    //        x 
    //        |> bind checkSession
    //        |> bind checkSessionEu

    //| _ -> ()

    x.Struct.contentType <- "application/json; charset=utf-8"
    x.Struct.rep <-
        runApi branching x 
        |> Braket
        |> json__strFinal
        |> Encoding.UTF8.GetBytes
