module WYI.BizLogics.Branch

open System
open System.Text
open System.Collections.Generic
open System.Threading

open Util.Cat
open Util.Text
open Util.Bin
open Util.CollectionModDict
open Util.Perf
open Util.Json
open Util.Http
open Util.HttpServer
open Util.Zmq

open WYI.Shared.OrmTypes
open WYI.Shared.Types
open WYI.Shared.OrmMor
open WYI.Shared.CustomMor

open UtilWebServer.Common
open UtilWebServer.Api
open UtilWebServer.Json
open UtilWebServer.SSR
open UtilWebServer.Server.Monitor

open WYI.BizLogics.Common

let branching (x:X) = 

    let bindx p = 
        x.proco <- Some p
        Suc x

    match x.service with
    | "public" -> 
        match x.api with
        | "ping" -> bindx apiPing
        | "auth" -> (fun x -> 
            let session = (tryFindStrByAtt "session" x.json).Trim()
            if (tryFindStrByAtt "act" x.json).Trim() = "sign-out" then
                if runtime.sessions.ContainsKey session then
                    runtime.sessions.Remove session |> ignore
                [| ok |]
            else
                let key = (tryFindStrByAtt "key" x.json).Trim()
                if key = "B2C88F15-558F-4E9E-A7A9-3611D98D3691" then

                    let eux = 
                        runtime.users.Values
                        |> Seq.toArray
                        |> Array.find(fun i ->  i.eu.p.AuthType = euAuthTypeEnum.Admin)
                
                    if runtime.sessions.ContainsKey session then
                        runtime.sessions.Remove session |> ignore

                    let s = UtilWebServer.Session.user__session runtime.sessions eux

                    [|  ok
                        "session", s.session |> str__json
                        "eux", eux |> EuComplex__json |]
                else
                    er Er.Unauthorized) |> bindx
        | "msg" -> (fun x -> 
            let name = (tryFindStrByAtt "name" x.json).Trim()
            let email = (tryFindStrByAtt "email" x.json).Trim()
            let msg = (tryFindStrByAtt "msg" x.json).Trim()

            let p = pBOOK_empty()
            p.Caption <- name
            p.Email <- email
            p.Message <- msg
            match 
                UtilWebServer.Db.p__createRcd 
                    p BOOK_metadata dbLoggero "/api/public/msg" conn with
            | Some rcd -> [| ok |]
            | None -> er Er.Internal) |> bindx
        | _ -> Fail(Er.ApiNotExists,x)
    | "eu" -> 
        match x.api with
        | _ -> Fail(Er.ApiNotExists,x)
    | "admin" -> 
        match x.api with
        | "plogs" -> (fun x -> 
            let metadata = PLOG_metadata
            match "ORDER BY ID DESC" |> Util.Orm.loadall conn (metadata.table,metadata.fieldorders(),metadata.db__rcd) with
            | Some items ->
                items
                |> Array.filter(fun i -> (UtilWebServer.PageLog.req__fromo i.p.Request).IsSome)
                |> (fun items -> if items.Length > 200 then Array.sub items 0 200 else items)
                |> Array.map(fun rcd -> UtilWebServer.PageLog.req__json (rcd.p.Ip,rcd.Createdat,rcd.p.Request))
            | None -> [| |]
            |> wrapOkAry) |> bindx
        | "books" -> (fun x -> 
            let metadata = BOOK_metadata
            match 
                "ORDER BY ID DESC"
                |> Util.Orm.loadall conn
                    (metadata.table,metadata.fieldorders(),metadata.db__rcd) with
            | Some items ->
                if items.Length > 200 then
                    Array.sub items 0 200
                else
                    items 
                |> Array.map(fun rcd -> 
                    let clone = BOOK_clone rcd
                    clone.p.Message <- clone.p.Message.Replace(crlf,"<br>")
                    clone)
                |> Array.map BOOK__json
            | None -> [| |]
            |> wrapOkAry) |> bindx
        | "monitorPerf" -> bindx apiMonitorPerf
        | "monitorServer" -> bindx (fun x -> x.runtime |> apiMonitor)
        | _ -> Fail(Er.ApiNotExists,x)
    | "open" -> Fail(Er.ApiNotExists,x)
    | _ -> Fail(Er.ApiNotExists,x)


let branch req service api json = 

    use cw = new CodeWrapper("Server.WebHandler.branch")

    let mutable x = incoming__x runtime req service api "" json
    
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

    runApi branching x
