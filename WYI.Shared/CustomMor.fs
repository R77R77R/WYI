module WYI.Shared.CustomMor

open LanguagePrimitives

open System
open System.Collections.Generic
open System.Collections.Concurrent
open System.Text

open Util.Cat
open Util.Perf
open Util.Measures
open Util.CollectionModDict
open Util.Collection
open Util.Db
open Util.DbQuery
open Util.DbTx
open Util.Bin
open Util.Text
open Util.Json
open Util.Orm
open Util.Stat

open PreOrm

open Util.Bin
open WYI.Shared.OrmTypes
open WYI.Shared.Types
open WYI.Shared.OrmMor

// [EuComplex] Structure

let EuComplex_empty(): EuComplex =
    {
        eu = { ID = 0L; Sort = 0L; Createdat = DateTime.MinValue; Updatedat = DateTime.MinValue; p = pEU_empty() }
    }

let EuComplex__bin (bb:BytesBuilder) (v:EuComplex) =

    EU__bin bb v.eu

let bin__EuComplex (bi:BinIndexed):EuComplex =
    let bin,index = bi

    {
        eu = 
            bi
            |> bin__EU
    }

let EuComplex__json (v:EuComplex) =

    [|  ("eu",EU__json v.eu)
         |]
    |> Json.Braket

let EuComplex__jsonTbw (w:TextBlockWriter) (v:EuComplex) =
    json__str w (EuComplex__json v)

let EuComplex__jsonStr (v:EuComplex) =
    (EuComplex__json v) |> json__strFinal


let json__EuComplexo (json:Json):EuComplex option =
    let fields = json |> json__items

    let mutable passOptions = true

    let euo =
        match json__tryFindByName json "eu" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__EUo with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    if passOptions then
        ({
            eu = euo.Value }:EuComplex) |> Some
    else
        None

let EuComplex_clone src =
    let bb = new BytesBuilder()
    EuComplex__bin bb src
    bin__EuComplex (bb.bytes(),ref 0)

// [MomentComplex] Structure

let MomentComplex_empty(): MomentComplex =
    {
        m = { ID = 0L; Sort = 0L; Createdat = DateTime.MinValue; Updatedat = DateTime.MinValue; p = pMOMENT_empty() }
    }

let MomentComplex__bin (bb:BytesBuilder) (v:MomentComplex) =

    MOMENT__bin bb v.m

let bin__MomentComplex (bi:BinIndexed):MomentComplex =
    let bin,index = bi

    {
        m = 
            bi
            |> bin__MOMENT
    }

let MomentComplex__json (v:MomentComplex) =

    [|  ("m",MOMENT__json v.m)
         |]
    |> Json.Braket

let MomentComplex__jsonTbw (w:TextBlockWriter) (v:MomentComplex) =
    json__str w (MomentComplex__json v)

let MomentComplex__jsonStr (v:MomentComplex) =
    (MomentComplex__json v) |> json__strFinal


let json__MomentComplexo (json:Json):MomentComplex option =
    let fields = json |> json__items

    let mutable passOptions = true

    let mo =
        match json__tryFindByName json "m" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__MOMENTo with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    if passOptions then
        ({
            m = mo.Value }:MomentComplex) |> Some
    else
        None

let MomentComplex_clone src =
    let bb = new BytesBuilder()
    MomentComplex__bin bb src
    bin__MomentComplex (bb.bytes(),ref 0)

// [RuntimeData] Structure

let RuntimeData_empty(): RuntimeData =
    {
        books = new List<BOOK>()
    }

let RuntimeData__bin (bb:BytesBuilder) (v:RuntimeData) =

    
    List__bin (BOOK__bin) bb v.books

let bin__RuntimeData (bi:BinIndexed):RuntimeData =
    let bin,index = bi

    {
        books = 
            bi
            |> bin__List (bin__BOOK)
    }

let RuntimeData__json (v:RuntimeData) =

    [|  ("books",List__json (BOOK__json) v.books)
         |]
    |> Json.Braket

let RuntimeData__jsonTbw (w:TextBlockWriter) (v:RuntimeData) =
    json__str w (RuntimeData__json v)

let RuntimeData__jsonStr (v:RuntimeData) =
    (RuntimeData__json v) |> json__strFinal


let json__RuntimeDatao (json:Json):RuntimeData option =
    let fields = json |> json__items

    let mutable passOptions = true

    let bookso =
        match json__tryFindByName json "books" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__Listo (json__BOOKo) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    if passOptions then
        ({
            books = bookso.Value }:RuntimeData) |> Some
    else
        None

let RuntimeData_clone src =
    let bb = new BytesBuilder()
    RuntimeData__bin bb src
    bin__RuntimeData (bb.bytes(),ref 0)

// [ClientRuntime] Structure

let ClientRuntime_empty(): ClientRuntime =
    {
        version = 0
    }

let ClientRuntime__bin (bb:BytesBuilder) (v:ClientRuntime) =

    int32__bin bb v.version

let bin__ClientRuntime (bi:BinIndexed):ClientRuntime =
    let bin,index = bi

    {
        version = 
            bi
            |> bin__int32
    }

let ClientRuntime__json (v:ClientRuntime) =

    [|  ("version",int32__json v.version)
         |]
    |> Json.Braket

let ClientRuntime__jsonTbw (w:TextBlockWriter) (v:ClientRuntime) =
    json__str w (ClientRuntime__json v)

let ClientRuntime__jsonStr (v:ClientRuntime) =
    (ClientRuntime__json v) |> json__strFinal


let json__ClientRuntimeo (json:Json):ClientRuntime option =
    let fields = json |> json__items

    let mutable passOptions = true

    let versiono =
        match json__tryFindByName json "version" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__int32o with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    if passOptions then
        ({
            version = versiono.Value }:ClientRuntime) |> Some
    else
        None

let ClientRuntime_clone src =
    let bb = new BytesBuilder()
    ClientRuntime__bin bb src
    bin__ClientRuntime (bb.bytes(),ref 0)

// [Msg] Structure

let Msg_empty(): Msg =Msg.Heartbeat

let Msg__bin (bb:BytesBuilder) (v:Msg) =

    match v with
    | Msg.Heartbeat ->
        int32__bin bb 0
    | Msg.ApiRequest v ->
        int32__bin bb 1
        json__bin bb v
    | Msg.ApiResponse v ->
        int32__bin bb 2
        json__bin bb v

let bin__Msg (bi:BinIndexed):Msg =
    let bin,index = bi

    match bin__int32 bi with
    | 2 -> bin__json bi |> Msg.ApiResponse
    | 1 -> bin__json bi |> Msg.ApiRequest
    | _ -> Msg.Heartbeat

let Msg__json (v:Msg) =

    let items = new List<string * Json>()

    match v with
    | Msg.Heartbeat ->
        ("e",int32__json 0) |> items.Add
    | Msg.ApiRequest v ->
        ("e",int32__json 1) |> items.Add
        ("val", v) |> items.Add
    | Msg.ApiResponse v ->
        ("e",int32__json 2) |> items.Add
        ("val", v) |> items.Add

    items.ToArray() |> Json.Braket

let Msg__jsonTbw (w:TextBlockWriter) (v:Msg) =
    json__str w (Msg__json v)

let Msg__jsonStr (v:Msg) =
    (Msg__json v) |> json__strFinal


let json__Msgo (json:Json):Msg option =
    let fields = json |> json__items

    match json__tryFindByName json "e" with
    | Some e ->
        match json__int32o e with
        | Some i ->
            match i with
            | 0 -> Msg.Heartbeat |> Some
            | 1 -> 
                match json__tryFindByName json "val" with 
                | Some v ->
                    match Some v with
                    | Some vv -> vv |> Msg.ApiRequest |> Some
                    | None -> None
                | None -> None
            | 2 -> 
                match json__tryFindByName json "val" with 
                | Some v ->
                    match Some v with
                    | Some vv -> vv |> Msg.ApiResponse |> Some
                    | None -> None
                | None -> None
            | _ -> None
        | None -> None
    | None -> None

let Msg_clone src =
    let bb = new BytesBuilder()
    Msg__bin bb src
    bin__Msg (bb.bytes(),ref 0)

// [Er] Structure

let Er_empty(): Er =Er.ApiNotExists

let Er__bin (bb:BytesBuilder) (v:Er) =

    match v with
    | Er.ApiNotExists ->
        int32__bin bb 0
    | Er.InvalideParameter ->
        int32__bin bb 1
    | Er.Unauthorized ->
        int32__bin bb 2
    | Er.NotAvailable ->
        int32__bin bb 3
    | Er.Internal ->
        int32__bin bb 4

let bin__Er (bi:BinIndexed):Er =
    let bin,index = bi

    match bin__int32 bi with
    | 4 -> Er.Internal
    | 3 -> Er.NotAvailable
    | 2 -> Er.Unauthorized
    | 1 -> Er.InvalideParameter
    | _ -> Er.ApiNotExists

let Er__json (v:Er) =

    let items = new List<string * Json>()

    match v with
    | Er.ApiNotExists ->
        ("e",int32__json 0) |> items.Add
    | Er.InvalideParameter ->
        ("e",int32__json 1) |> items.Add
    | Er.Unauthorized ->
        ("e",int32__json 2) |> items.Add
    | Er.NotAvailable ->
        ("e",int32__json 3) |> items.Add
    | Er.Internal ->
        ("e",int32__json 4) |> items.Add

    items.ToArray() |> Json.Braket

let Er__jsonTbw (w:TextBlockWriter) (v:Er) =
    json__str w (Er__json v)

let Er__jsonStr (v:Er) =
    (Er__json v) |> json__strFinal


let json__Ero (json:Json):Er option =
    let fields = json |> json__items

    match json__tryFindByName json "e" with
    | Some e ->
        match json__int32o e with
        | Some i ->
            match i with
            | 0 -> Er.ApiNotExists |> Some
            | 1 -> Er.InvalideParameter |> Some
            | 2 -> Er.Unauthorized |> Some
            | 3 -> Er.NotAvailable |> Some
            | 4 -> Er.Internal |> Some
            | _ -> None
        | None -> None
    | None -> None

let Er_clone src =
    let bb = new BytesBuilder()
    Er__bin bb src
    bin__Er (bb.bytes(),ref 0)