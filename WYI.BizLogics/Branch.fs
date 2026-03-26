module WYI.BizLogics.Branch

open System
open System.Text
open System.Collections.Generic
open System.Threading
open System.IdentityModel.Tokens.Jwt

open Microsoft.AspNetCore.Http

open Util.Cat
open Util.Text
open Util.Bin
open Util.CollectionModDict
open Util.Perf
open Util.Json
open Util.Http
open Util.HttpServer

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

let branching (x:X) = 

    let bindx p = 
        x.Struct.proco <- Some p
        Suc x

    match x.Struct.scheme with
    | "public" -> 
        match x.Struct.api with
        | "ping" -> bindx apiPing
        | "auth" -> (fun (x:X) -> 

            let getClerkIdentity (httpx: HttpContext) =
                let authHeader = httpx.Request.Headers.["Authorization"].ToString()
                if authHeader.StartsWith("Bearer ", StringComparison.OrdinalIgnoreCase) then
                    try
                        // 1. 去掉 "Bearer " 前缀
                        let token = authHeader.Replace("Bearer ", "")
        
                        // 2. 使用 JwtSecurityTokenHandler 解析（无需密钥即可读取内容）
                        let handler = JwtSecurityTokenHandler()
                        let jwtToken = handler.ReadJwtToken(token)
        
                        // 3. 提取 'sub' 字段，这才是 Clerk 的真正 User ID (如 user_2xb...)
                        let userId = jwtToken.Subject 
        
                        "✅ 成功解析 JWT，Clerk User ID: " + userId
                        |> x.Struct.runtime.output
                        
                        userId
                    with
                    | ex -> 
                        "❌ JWT 解析失败: " + ex.Message
                        |> x.Struct.runtime.output
                        ""                    
                else
                    ""

            let clerkUserId = getClerkIdentity x.Struct.httpx

            let json = x.Json
            let session = (tryFindStrByAtt "session" json).Trim()
            if (tryFindStrByAtt "act" json).Trim() = "sign-out" then
                if runtime.sessions.ContainsKey session then
                    runtime.sessions.Remove session |> ignore
                [| ok |]
            else
                let key = (tryFindStrByAtt "key" json).Trim()
                if key = "B2C88F15-558F-4E9E-A7A9-3611D98D3691" then

                    let eux = 
                        runtime.users.Values
                        |> Seq.toArray
                        |> Array.find(fun i ->  i.eu.p.AuthType = euAuthTypeEnum.Admin)
                
                    if runtime.sessions.ContainsKey session then
                        runtime.sessions.Remove session |> ignore

                    let s = UtilKestrel.Session.user__session runtime.sessions eux

                    [|  ok
                        "session", s.session |> str__json
                        "eux", eux |> EuComplex__json |]
                else
                    er Er.Unauthorized) |> bindx
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
            match "ORDER BY ID DESC" |> Util.Orm.loadall conn (metadata.table,metadata.fieldorders(),metadata.db__rcd) with
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
