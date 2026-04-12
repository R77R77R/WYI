module WYI.BizLogics.Ca

open System
open System.IO
open System.Threading
open System.Text
open System.Collections.Generic
open System.Collections.Concurrent

open Util.Text
open Util.Json
open Util.Db
open Util.DbTx
open Util.Orm

open UtilKestrel.DbLogger
open UtilKestrel.Db
open UtilKestrel.Common

open WYI.Shared.OrmTypes
open WYI.Shared.Types
open WYI.Shared.OrmMor
open WYI.Shared.CustomMor

open WYI.BizLogics.Common

let json__files json = 
    json
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
