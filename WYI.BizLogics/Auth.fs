module WYI.BizLogics.Auth

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

open WYI.BizLogics.Common

let output = runtime.output

let auth (x:X) =

    let clerkUserId =
        UtilKestrel.Open.Clerk.getClerkIdentity output x.Struct.httpx

    let json = x.Json
            
    json
    |> json__strFinal
    |> output

    let session = (tryFindStrByAttWithDefault "" "session" json).Trim()
    let cid = tryFindStrByAtt "clerkId" json
    if (tryFindStrByAtt "act" json).Trim() = "sign-out" then
        if runtime.sessions.ContainsKey session then
            runtime.sessions.Remove session |> ignore
        [| ok |]
    else if clerkUserId = cid then
               
        let email = tryFindStrByAtt "email" json
        let caption = tryFindStrByAtt "caption" json
        let avatar = tryFindStrByAtt "avatar" json

        let mutable euxo =
            runtime.users.Values
            |> Seq.toArray
            |> Array.tryFind(fun i ->  i.eu.p.ClerkUserID = cid) 
            
        match euxo with
        | Some eux ->
            if email <> eux.eu.p.Email
                || caption <> eux.eu.p.Caption
                || avatar <> eux.eu.p.Avatar then

                eux.eu.p.Email <- email
                eux.eu.p.Caption <- caption
                eux.eu.p.Avatar <- avatar
                        
                eux.eu
                |> EU_update output
        | None -> 
            let p = pEU_empty()

            p.ClerkUserID <- cid
            p.Email <- email
            p.Caption <- caption
            p.Avatar <- avatar

            EU_create_incremental_transaction output ((fun rcd -> 
                let eux = { 
                    units = createModDictInt64 2
                    acctxs = createModDictInt64 2
                    billxs = createModDictInt64 2
                    eu = rcd }
                runtime.users[eux.eu.ID] <- eux
                euxo <- Some eux),(fun (eso,ctx) -> ())) p

        if runtime.sessions.ContainsKey session then
            runtime.sessions.Remove session |> ignore
        match euxo with
        | Some eux -> 
            let s = UtilKestrel.Session.user__session runtime.sessions eux
            let euxSimplified = {
                units = createModDictInt64 2
                acctxs = createModDictInt64 2
                billxs = createModDictInt64 2
                eu = eux.eu }

            [|  ok
                "session", s.session |> str__json
                "eux", euxSimplified |> EuComplex__json |]
        | None -> er Er.Internal

    else
        er Er.Unauthorized

