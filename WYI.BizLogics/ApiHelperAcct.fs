module WYI.BizLogics.ApiHelperAcct

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

let acctxs() = 
    runtime.users.Values
    |> Array.map(fun i -> i.acctxs.Values)
    |> Array.concat

let searchAcctx acctxs (term:string) =
    acctxs
    |> Array.filter(fun i ->
        let mutable hit = false
        if i.acct.p.AcctNum.ToLower().Contains term then hit <- true
        if i.unito.IsSome then
            if i.unito.Value.p.Address.ToLower().Contains term then hit <- true
        if i.cato.IsSome then
            if i.cato.Value.p.Caption.ToLower().Contains term then hit <- true
        if i.providero.IsSome then
            if i.providero.Value.p.Caption.ToLower().Contains term then hit <- true
        hit)

