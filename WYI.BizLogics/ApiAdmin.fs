module WYI.BizLogics.ApiAdmin

open System
open System.Text
open System.IO
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
open Util.Db
open Util.DbTx

open WYI.Shared.OrmTypes
open WYI.Shared.Types
open WYI.Shared.OrmMor
open WYI.Shared.CustomMor

open UtilKestrel.Types
open UtilKestrel.Ctx
open UtilKestrel.Api
open UtilKestrel.Json
open UtilKestrel.Db
open UtilKestrel.Open.Google

open WYI.BizLogics.Common
open WYI.BizLogics.Db
open WYI.BizLogics.Auth
open WYI.BizLogics.Ai
open WYI.BizLogics.ApiHelperBill


let output = runtime.output

let users (x:X) = 
    match
        x.Json
        |> tryFindStrByAtt "act" with
    | "ls" -> 
        runtime.users.Values
        |> Array.map(fun i -> i.eu |> EU__json)
        |> Json.Ary
        |> wrapOk "data"
    | "search" ->
        let term = (x.Json |> tryFindStrByAtt "term").ToLower()
        runtime.users.Values
        |> Array.filter(fun i ->
            let mutable hit = false
            if i.eu.p.Email.ToLower().Contains term then hit <- true
            if i.eu.p.Caption.ToLower().Contains term then hit <- true
            if i.eu.p.Username.ToLower().Contains term then hit <- true
            hit)
        |> Array.map(fun i -> i.eu |> EU__json)
        |> Json.Ary
        |> wrapOk "data"
    | _ -> er Er.InvalideParameter

let billxs (x:X) = 

    match
        x.Json
        |> tryFindStrByAtt "act" with
    | "ls" -> 
        billxs()
        |> Array.map BillComplex__json
        |> Json.Ary
        |> wrapOk "data"
    | "search" ->
        (x.Json |> tryFindStrByAtt "term").ToLower()
        |> searchBillx
        |> Array.map BillComplex__json
        |> Json.Ary
        |> wrapOk "data"
    | _ -> er Er.InvalideParameter

let providers (x:X) = 
    match
        x.Json
        |> tryFindStrByAtt "act" with
    | "create" ->
        match 
            (fun (p:pUPROVIDER) -> 
                ()) 
            |> creator UPROVIDER_metadata with
        | Some rcd -> 
            runtime.data.providers[rcd.ID] <- rcd
            rcd
            |> UPROVIDER__json
            |> wrapOk "data"
        | None -> er Er.Internal
    | "ls" -> 
        runtime.data.providers.Values
        |> Array.map UPROVIDER__json
        |> Json.Ary
        |> wrapOk "data"
    | "search" ->
        let term = (x.Json |> tryFindStrByAtt "term").ToLower()
        runtime.data.providers.Values
        |> Array.filter(fun i -> i.p.Caption.ToLower().Contains term)
        |> Array.map UPROVIDER__json
        |> Json.Ary
        |> wrapOk "data"
    | _ -> er Er.InvalideParameter


