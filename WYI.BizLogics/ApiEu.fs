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
open WYI.BizLogics.ApiHelperAcct
open WYI.BizLogics.ApiHelperBill

let output = runtime.output

let myUnits eux (x:X) = 
    let json = x.Json
    match
        json
        |> tryFindStrByAtt "act" with
    | "create" ->
        match
            json
            |> tryFindByAtt "data" with
        | Some (s,data) -> 
            match 
                (fun (p:pUNIT) -> 
                    p.Address <- tryFindStrByAtt "addr" data
                    p.Town <- tryFindStrByAtt "town" data
                    p.State <- tryFindStrByAtt "state" data
                    p.Zip <- tryFindStrByAtt "zip" data
                    p.Owner <- eux.eu.ID) 
                |> creator UNIT_metadata with
            | Some rcd -> 
                eux.units[rcd.ID] <- rcd
                rcd
                |> UNIT__json
                |> wrapOk "data"
            | None -> er Er.Internal
        | None -> er Er.InvalideParameter
    | "ls" -> 
        eux.units.Values
        |> Array.map UNIT__json
        |> Json.Ary
        |> wrapOk "data"
    | "search" ->
        let term = (x.Json |> tryFindStrByAtt "term").ToLower()
        eux.units.Values
        |> Array.filter(fun i ->
            let mutable hit = false
            if i.p.Address.ToLower().Contains term then hit <- true
            if i.p.Town.ToLower().Contains term then hit <- true
            if i.p.State.ToLower().Contains term then hit <- true
            if i.p.Zip.ToLower().Contains term then hit <- true
            hit)
        |> Array.map UNIT__json
        |> Json.Ary
        |> wrapOk "data"
    | _ -> er Er.InvalideParameter

let myAcctxs eux (x:X) = 
    let json = x.Json
    match
        json
        |> tryFindStrByAtt "act" with
    | "create" ->
        match
            json
            |> tryFindByAtt "data" with
        | Some (s,data) -> 
            match 
                (fun (p:pUACCT) -> 
                    p.AcctNum <- tryFindStrByAtt "acctnum" data)
                    //p.client <- eux.eu.ID) 
                |> creator UACCT_metadata with
            | Some rcd -> 
                //eux.acctxs[rcd.ID] <- {
                //    acct = rcd}
                rcd
                |> UACCT__json
                |> wrapOk "data"
            | None -> er Er.Internal
        | None -> er Er.InvalideParameter
    | "ls" -> 
        eux.acctxs.Values
        |> Array.map AcctComplex__json
        |> Json.Ary
        |> wrapOk "data"
    | "search" ->
        (x.Json |> tryFindStrByAtt "term").ToLower()
        |> searchAcctx eux.acctxs.Values
        |> Array.map AcctComplex__json
        |> Json.Ary
        |> wrapOk "data"
    | _ -> er Er.InvalideParameter

let myBillxs eux (x:X) = 

    match
        x.Json
        |> tryFindStrByAtt "act" with
    | "ls" -> 
        eux.billxs.Values
        |> Array.map BillComplex__json
        |> Json.Ary
        |> wrapOk "data"
    | "search" ->
        (x.Json |> tryFindStrByAtt "term").ToLower()
        |> searchBillx eux.billxs.Values
        |> Array.map BillComplex__json
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

    let pretx = None |> opctx__pretx
    let p = pUBILL_empty()

    p.Owner <- eux.eu.ID
    
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

        let json =

        (*

CategoryID: [6462],
Category: [Internet],
ProviderID: [0],
Provider: [CenturyLink],
AcctNum: [6514645851088],
AcctName: [BREW FITNESS],
Addr: [808 LAKE ST S],
Town: [FOREST LAKE],
State: [MN],
ZIP: [55025],
BillDate: [05/01/2021],
Amt: [$69.99]                
        *)

            let parse (line:string) = 
                let k = line.Substring(0,line.IndexOf ":")
                let v = Util.Text.regex_match
                            (str__regex "(?<=\[).*?(?=\])") line
                k,Json.Str v

            msg.Split lf
            |> Array.filter(fun line -> line.Contains ":")
            |> Array.map parse
            |> Json.Braket

        p.ShownProvider <- tryFindStrByAtt "Provider" json
        p.ShownUnitNum <- tryFindStrByAtt "Unit" json
        p.ShownAcctNum <- tryFindStrByAtt "AcctNum" json
        p.ShownAcctName <- tryFindStrByAtt "AcctName" json
        p.ShownAddr <- tryFindStrByAtt "Addr" json
        p.ShownTown <- tryFindStrByAtt "Town" json
        p.ShownState <- tryFindStrByAtt "State" json
        p.ShownZip <- tryFindStrByAtt "ZIP" json

        p.Cat <- tryFindStrByAtt "CategoryID" json |> parse_int64
        p.Provider <- tryFindStrByAtt "ProviderID" json |> parse_int64

    let rcd = 
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

        [|  ok
            "data",billx |> BillComplex__json
            "Ex",ex |> Json.Str |]
    else
        files
        |> Array.iter(fun f -> f.p.Bill <- 0L)
        er Er.Internal

let submitBill (x:X) =

    

    [|  ok |]



