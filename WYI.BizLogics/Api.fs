module WYI.BizLogics.Api

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

open WYI.Shared.OrmTypes
open WYI.Shared.Types
open WYI.Shared.OrmMor
open WYI.Shared.CustomMor

open UtilKestrel.Types
open UtilKestrel.Ctx
open UtilKestrel.Api
open UtilKestrel.Json
open UtilKestrel.SSR
open UtilKestrel.Open.Google

open WYI.BizLogics.Common
open WYI.BizLogics.Auth
open WYI.BizLogics.Ai

let output = runtime.output

let providers x = 
    let providers = runtime.data.providers.Values
    runtime.data.cats.Values
    |> Array.map(fun ucat -> 
        let ary = 
            providers 
            |> Array.filter(fun i -> i.p.Cat = ucat.ID)
            |> Array.map UPROVIDER__json
            |> Json.Ary

        [|  ("ucat", ucat |> UCAT__json) 
            ("providers",ary)  |]
        |> Json.Braket)
    |> Json.Ary
    |> wrapOk "data"

let reviewBills (x:X) =

    let files = 
        x.Json
        |> tryFindAryByAtt "fids"
        |> Array.map(fun item -> 
            match item with
            | Json.Num v -> parse_int64 v
            | _ -> 0L)
        |> Array.filter(fun id -> id > 0L)
        |> Array.distinct
        |> Array.map id__FILEo
        |> Array.filter(fun o -> o.IsSome)
        |> Array.map(fun o -> Path.Combine(runtime.host.fsDir,o.Value.p.Path))

    async{
        let! (ex,msg) = 
            GeminiMultimodal
                runtime.output 
                runtime.data.apiKeyGemini
                runtime.data.aiModel
                prompt 
                files
        ex + msg |> output
    }
    |> Async.RunSynchronously

    
    
    [| ok |]



