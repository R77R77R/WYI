module WYI.BizLogics.ApiPublic

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

let output = runtime.output

let providers x = 
    runtime.data.cats.Values
    |> Array.map(fun ucat -> 
        let ary = 
            runtime.data.catproviders 
            |> Array.filter(fun i -> i.p.Cat = ucat.ID)
            |> Array.map(fun i-> 
                runtime.data.providers[i.p.Provider]
                |> UPROVIDER__json)
            |> Json.Ary

        [|  ("ucat", ucat |> UCAT__json) 
            ("providers",ary)  |]
        |> Json.Braket)
    |> Json.Ary
    |> wrapOk "data"
