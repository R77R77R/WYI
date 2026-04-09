module WYI.BizLogics.ApiEu

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

let myUnit eux (x:X) = 
    match
        x.Json
        |> tryFindStrByAtt "act" with
    | "create" ->
        match 
            (fun (p:pUNIT) -> 
                p.Owner <- eux.eu.ID) 
            |> creator UNIT_metadata with
        | Some rcd -> 
            eux.units[rcd.ID] <- rcd
            rcd
            |> UNIT__json
            |> wrapOk "data"
        | None -> er Er.Internal
    | "ls" -> 
        eux.units.Values
        |> Array.map UNIT__json
        |> Json.Ary
        |> wrapOk "data"
    | "search" ->
        let term = (x.Json |> tryFindStrByAtt "term").ToLower()
        eux.units.Values
        |> Array.filter(fun i -> i.p.Caption.ToLower().Contains term)
        |> Array.map UNIT__json
        |> Json.Ary
        |> wrapOk "data"
    | _ -> er Er.InvalideParameter

let reviewBillFiles eux (x:X) =

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
        |> Array.map(fun o -> o.Value)

    let pathes = 
        files
        |> Array.map(fun f -> Path.Combine(runtime.host.fsDir,f.p.Path))

    let ex,msg =
        async{
            let! (ex,msg) = 
                GeminiMultimodal
                    runtime.output 
                    runtime.data.apiKeyGemini
                    runtime.data.aiModel
                    prompt 
                    pathes
            ex + msg |> output
            return ex,msg
        }
        |> Async.RunSynchronously

    if ex.Length = 0 then

        let pretx = None |> opctx__pretx

        let rcd =
            let p = 
                let p = pUBILL_empty()

                let json =
                    let parse (line:string) = 
                        let k = line.Substring(0,line.IndexOf ":")
                        let v = Util.Text.regex_match
                                    (str__regex "(?<=\[).*?(?=\])") line
                        k,Json.Str v

                    msg.Split lf
                    |> Array.filter(fun line -> line.Length > 0)
                    |> Array.map parse
                    |> Json.Braket

                
                p.ProviderText <- tryFindStrByAtt "Provider" json
                p.UnitText <- tryFindStrByAtt "Unit" json

                p

            p
            |> populateCreateTx pretx UBILL_metadata

        files
        |> Array.iter(fun f -> 
            f.p.Bill <- rcd.ID
            (f.ID,DateTime.UtcNow,f.p)
            |> build_update_sql FILE_metadata
            |> pretx.sqls.Add)

        if pretx |> loggedPipeline dbLoggero "reviewBillFiles" conn then
            let billx = {
                cato = rcd.p.Cat |> id__UCATo
                providero = rcd.p.Provider |> id__UPROVIDERo
                owner = eux.eu
                unito = rcd.p.Unit |> id__UNITo
                accto = rcd.p.UAcct |> id__UACCTo
                files = files
                bill = rcd }
            eux.billxs[rcd.ID] <- billx

            billx
            |> BillComplex__json
            |> wrapOk "data"
        else
            files
            |> Array.iter(fun f -> f.p.Bill <- 0L)
            er Er.Internal
    else
        [|  "Er",(Er.API3rdParty.ToString() |> Json.Str)
            "Msg",(msg |> Json.Str) |]

let submitBill (x:X) =

    

    [|  ok |]



