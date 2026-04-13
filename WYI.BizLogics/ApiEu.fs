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
            let kucpo = 
                let cat = tryFindNumByAtt "cat" data |> parse_int64
                let provider = tryFindNumByAtt "provider" data |> parse_int64
                runtime.data.catproviders
                |> Array.tryFind(fun kucp ->
                    kucp.p.Cat = cat && kucp.p.Provider = provider)

            let unito = 
                match
                    tryFindNumByAtt "unit" data
                    |> parse_int64
                    |> eux.units.TryGet with
                | Some unit -> 
                    if unit.p.Owner = eux.eu.ID then
                        Some unit
                    else
                        None
                | None -> None

            match 
                (fun (p:pUACCT) ->
                    match kucpo with
                    | Some kucp -> 
                        p.Cat <- kucp.p.Cat
                        p.Provider <- kucp.p.Provider
                    | None -> ()
                    
                    match unito with
                    | Some unit -> p.Unit <- unit.ID
                    | None -> ()

                    p.AcctNum <- tryFindStrByAtt "acctnum" data
                    p.AcctName <- tryFindStrByAtt "acctname" data
                    p.Owner <- eux.eu.ID) 
                |> creator UACCT_metadata with
            | Some rcd -> 
                let acctx = {
                    cato = 
                        match kucpo with
                        | Some kucp -> runtime.data.cats[kucp.p.Cat] |> Some
                        | None -> None
                    providero = 
                        match kucpo with
                        | Some kucp -> runtime.data.providers[kucp.p.Provider] |> Some
                        | None -> None
                    owner = eux.eu
                    unito = unito
                    acct = rcd }
                eux.acctxs[rcd.ID] <- acctx
                acctx
                |> AcctComplex__json
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

    let ex,(pUnit,pAcct,pBill) = Ai.reviewBillFiles eux x

    if ex.Length > 0 then
        [|  ("Er",er.ToString() |> Json.Str) 
            ("ex",ex |> Json.Str) |]
    else
        let ls = new List<string * Json>()
        match pBill.Cat |> runtime.data.cats.TryGet with
        | Some v -> ls.Add("ucat",v |> UCAT__json)
        | None -> ()
        match pBill.Provider |> runtime.data.providers.TryGet with
        | Some v -> ls.Add("uprovider",v |> UPROVIDER__json)
        | None -> ()
        match pBill.Unit |> eux.units.TryGet with
        | Some v -> ls.Add("unit",v |> UNIT__json)
        | None -> ()
        match pBill.UAcct |> eux.acctxs.TryGet with
        | Some v -> ls.Add("acctx",v |> AcctComplex__json)
        | None -> ()
        [|  ("pUnit",pUnit |> pUNIT__json)
            ("pAcct",pAcct |> pUACCT__json)
            ("pBill",pBill |> pUBILL__json)
            ok |]
        |> ls.AddRange
        ls.ToArray()

let submitBill eux (x:X) =

    let json = x.Json
    let files = json |> Ca.json__files
    
    match
        json
        |> tryFindByAtt "p" with
    | Some (s,j) -> 
        match j |> json__pUBILLo with
        | Some p ->
        
            let pretx = None |> opctx__pretx

            p.State <- ubillStateEnum.Submitted
            p.Owner <- eux.eu.ID

            let rcd = 
                p
                |> populateCreateTx pretx UBILL_metadata

            files
            |> Array.iter(fun f -> 
                f.p.Bill <- rcd.ID
                (f.ID,DateTime.UtcNow,f.p)
                |> build_update_sql FILE_metadata
                |> pretx.sqls.Add)

            if pretx |> loggedPipeline dbLoggero "submitBill" conn then
                let billx = {
                    cato = p.Cat |> id__UCATo
                    providero = p.Provider |> id__UPROVIDERo
                    owner = eux.eu
                    unito = p.Unit |> id__UNITo
                    accto = p.UAcct |> id__UACCTo
                    files = files
                    bill = rcd }
                eux.billxs[rcd.ID] <- billx

                billx 
                |> BillComplex__json
                |> wrapOk "data"
            else
                er Er.Internal
        | None -> er Er.InvalideParameter
    | None -> er InvalideParameter








