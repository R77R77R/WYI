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
open Util.Math
open Util.Stat

open PreOrm

open Util.Bin
open WYI.Shared.OrmTypes
open WYI.Shared.Types
open WYI.Shared.OrmMor

// [AcctComplex] Structure

let AcctComplex_empty(): AcctComplex =
    {
        cato = None
        providero = None
        owner = { ID = 0L; Sort = 0L; Createdat = DateTime.MinValue; Updatedat = DateTime.MinValue; p = pEU_empty() }
        unito = None
        acct = { ID = 0L; Sort = 0L; Createdat = DateTime.MinValue; Updatedat = DateTime.MinValue; p = pUACCT_empty() }
    }

let AcctComplex__bin (bb:BytesBuilder) (v:AcctComplex) =

    Option__bin (UCAT__bin) bb v.cato
    Option__bin (UPROVIDER__bin) bb v.providero
    EU__bin bb v.owner
    Option__bin (UNIT__bin) bb v.unito
    UACCT__bin bb v.acct
    ()

let bin__AcctComplex (bi:BinIndexed):AcctComplex =
    let bin,index = bi

    {
        cato = 
            bi
            |> bin__Option (bin__UCAT)
        providero = 
            bi
            |> bin__Option (bin__UPROVIDER)
        owner = 
            bi
            |> bin__EU
        unito = 
            bi
            |> bin__Option (bin__UNIT)
        acct = 
            bi
            |> bin__UACCT
    }

let AcctComplex__json (v:AcctComplex) =

    [|  ("cato",Option__json (UCAT__json) v.cato)
        ("providero",Option__json (UPROVIDER__json) v.providero)
        ("owner",EU__json v.owner)
        ("unito",Option__json (UNIT__json) v.unito)
        ("acct",UACCT__json v.acct)
         |]
    |> Json.Braket

let AcctComplex__jsonTbw (w:TextBlockWriter) (v:AcctComplex) =
    json__str w (AcctComplex__json v)

let AcctComplex__jsonStr (v:AcctComplex) =
    (AcctComplex__json v) |> json__strFinal


let json__AcctComplexo (json:Json):AcctComplex option =
    let fields = json |> json__items

    let mutable passOptions = true

    let catoo =
        match json__tryFindByName json "cato" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__Optiono (json__UCATo) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let provideroo =
        match json__tryFindByName json "providero" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__Optiono (json__UPROVIDERo) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let ownero =
        match json__tryFindByName json "owner" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__EUo with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let unitoo =
        match json__tryFindByName json "unito" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__Optiono (json__UNITo) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let accto =
        match json__tryFindByName json "acct" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__UACCTo with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    if passOptions then
        ({
            cato = catoo.Value
            providero = provideroo.Value
            owner = ownero.Value
            unito = unitoo.Value
            acct = accto.Value }:AcctComplex) |> Some
    else
        None

let AcctComplex_clone src =
    let bb = new BytesBuilder()
    AcctComplex__bin bb src
    bin__AcctComplex (bb.bytes(),ref 0)

// [BillComplex] Structure

let BillComplex_empty(): BillComplex =
    {
        cato = None
        providero = None
        owner = { ID = 0L; Sort = 0L; Createdat = DateTime.MinValue; Updatedat = DateTime.MinValue; p = pEU_empty() }
        unito = None
        accto = None
        files = [| |]
        bill = { ID = 0L; Sort = 0L; Createdat = DateTime.MinValue; Updatedat = DateTime.MinValue; p = pUBILL_empty() }
    }

let BillComplex__bin (bb:BytesBuilder) (v:BillComplex) =

    Option__bin (UCAT__bin) bb v.cato
    Option__bin (UPROVIDER__bin) bb v.providero
    EU__bin bb v.owner
    Option__bin (UNIT__bin) bb v.unito
    Option__bin (UACCT__bin) bb v.accto
    
    array__bin (FILE__bin) bb v.files
    UBILL__bin bb v.bill
    ()

let bin__BillComplex (bi:BinIndexed):BillComplex =
    let bin,index = bi

    {
        cato = 
            bi
            |> bin__Option (bin__UCAT)
        providero = 
            bi
            |> bin__Option (bin__UPROVIDER)
        owner = 
            bi
            |> bin__EU
        unito = 
            bi
            |> bin__Option (bin__UNIT)
        accto = 
            bi
            |> bin__Option (bin__UACCT)
        files = 
            bi
            |> bin__array (bin__FILE)
        bill = 
            bi
            |> bin__UBILL
    }

let BillComplex__json (v:BillComplex) =

    [|  ("cato",Option__json (UCAT__json) v.cato)
        ("providero",Option__json (UPROVIDER__json) v.providero)
        ("owner",EU__json v.owner)
        ("unito",Option__json (UNIT__json) v.unito)
        ("accto",Option__json (UACCT__json) v.accto)
        ("files",array__json (FILE__json) v.files)
        ("bill",UBILL__json v.bill)
         |]
    |> Json.Braket

let BillComplex__jsonTbw (w:TextBlockWriter) (v:BillComplex) =
    json__str w (BillComplex__json v)

let BillComplex__jsonStr (v:BillComplex) =
    (BillComplex__json v) |> json__strFinal


let json__BillComplexo (json:Json):BillComplex option =
    let fields = json |> json__items

    let mutable passOptions = true

    let catoo =
        match json__tryFindByName json "cato" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__Optiono (json__UCATo) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let provideroo =
        match json__tryFindByName json "providero" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__Optiono (json__UPROVIDERo) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let ownero =
        match json__tryFindByName json "owner" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__EUo with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let unitoo =
        match json__tryFindByName json "unito" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__Optiono (json__UNITo) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let acctoo =
        match json__tryFindByName json "accto" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__Optiono (json__UACCTo) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let fileso =
        match json__tryFindByName json "files" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__arrayo (json__FILEo) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let billo =
        match json__tryFindByName json "bill" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__UBILLo with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    if passOptions then
        ({
            cato = catoo.Value
            providero = provideroo.Value
            owner = ownero.Value
            unito = unitoo.Value
            accto = acctoo.Value
            files = fileso.Value
            bill = billo.Value }:BillComplex) |> Some
    else
        None

let BillComplex_clone src =
    let bb = new BytesBuilder()
    BillComplex__bin bb src
    bin__BillComplex (bb.bytes(),ref 0)

// [PoolComplex] Structure

let PoolComplex_empty(): PoolComplex =
    {
        providero = None
        manager = { ID = 0L; Sort = 0L; Createdat = DateTime.MinValue; Updatedat = DateTime.MinValue; p = pEU_empty() }
        billxs = ModDict_empty()
        pool = { ID = 0L; Sort = 0L; Createdat = DateTime.MinValue; Updatedat = DateTime.MinValue; p = pPOOL_empty() }
    }

let PoolComplex__bin (bb:BytesBuilder) (v:PoolComplex) =

    Option__bin (UPROVIDER__bin) bb v.providero
    EU__bin bb v.manager
    
    ModDictInt64__bin (BillComplex__bin) bb v.billxs
    POOL__bin bb v.pool
    ()

let bin__PoolComplex (bi:BinIndexed):PoolComplex =
    let bin,index = bi

    {
        providero = 
            bi
            |> bin__Option (bin__UPROVIDER)
        manager = 
            bi
            |> bin__EU
        billxs = 
            bi
            |> bin__ModDictInt64(bin__BillComplex)
        pool = 
            bi
            |> bin__POOL
    }

let PoolComplex__json (v:PoolComplex) =

    [|  ("providero",Option__json (UPROVIDER__json) v.providero)
        ("manager",EU__json v.manager)
        ("billxs",ModDictInt64__json (BillComplex__json) v.billxs)
        ("pool",POOL__json v.pool)
         |]
    |> Json.Braket

let PoolComplex__jsonTbw (w:TextBlockWriter) (v:PoolComplex) =
    json__str w (PoolComplex__json v)

let PoolComplex__jsonStr (v:PoolComplex) =
    (PoolComplex__json v) |> json__strFinal


let json__PoolComplexo (json:Json):PoolComplex option =
    let fields = json |> json__items

    let mutable passOptions = true

    let provideroo =
        match json__tryFindByName json "providero" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__Optiono (json__UPROVIDERo) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let managero =
        match json__tryFindByName json "manager" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__EUo with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let billxso =
        match json__tryFindByName json "billxs" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> (fun json ->json__ModDictInt64o (json__BillComplexo) (new Dictionary<int64,BillComplex>()) json) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let poolo =
        match json__tryFindByName json "pool" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__POOLo with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    if passOptions then
        ({
            providero = provideroo.Value
            manager = managero.Value
            billxs = billxso.Value
            pool = poolo.Value }:PoolComplex) |> Some
    else
        None

let PoolComplex_clone src =
    let bb = new BytesBuilder()
    PoolComplex__bin bb src
    bin__PoolComplex (bb.bytes(),ref 0)

// [EuComplex] Structure

let EuComplex_empty(): EuComplex =
    {
        units = ModDict_empty()
        acctxs = ModDict_empty()
        billxs = ModDict_empty()
        eu = { ID = 0L; Sort = 0L; Createdat = DateTime.MinValue; Updatedat = DateTime.MinValue; p = pEU_empty() }
    }

let EuComplex__bin (bb:BytesBuilder) (v:EuComplex) =

    
    ModDictInt64__bin (UNIT__bin) bb v.units
    
    ModDictInt64__bin (AcctComplex__bin) bb v.acctxs
    
    ModDictInt64__bin (BillComplex__bin) bb v.billxs
    EU__bin bb v.eu
    ()

let bin__EuComplex (bi:BinIndexed):EuComplex =
    let bin,index = bi

    {
        units = 
            bi
            |> bin__ModDictInt64(bin__UNIT)
        acctxs = 
            bi
            |> bin__ModDictInt64(bin__AcctComplex)
        billxs = 
            bi
            |> bin__ModDictInt64(bin__BillComplex)
        eu = 
            bi
            |> bin__EU
    }

let EuComplex__json (v:EuComplex) =

    [|  ("units",ModDictInt64__json (UNIT__json) v.units)
        ("acctxs",ModDictInt64__json (AcctComplex__json) v.acctxs)
        ("billxs",ModDictInt64__json (BillComplex__json) v.billxs)
        ("eu",EU__json v.eu)
         |]
    |> Json.Braket

let EuComplex__jsonTbw (w:TextBlockWriter) (v:EuComplex) =
    json__str w (EuComplex__json v)

let EuComplex__jsonStr (v:EuComplex) =
    (EuComplex__json v) |> json__strFinal


let json__EuComplexo (json:Json):EuComplex option =
    let fields = json |> json__items

    let mutable passOptions = true

    let unitso =
        match json__tryFindByName json "units" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> (fun json ->json__ModDictInt64o (json__UNITo) (new Dictionary<int64,UNIT>()) json) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let acctxso =
        match json__tryFindByName json "acctxs" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> (fun json ->json__ModDictInt64o (json__AcctComplexo) (new Dictionary<int64,AcctComplex>()) json) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let billxso =
        match json__tryFindByName json "billxs" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> (fun json ->json__ModDictInt64o (json__BillComplexo) (new Dictionary<int64,BillComplex>()) json) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

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
            units = unitso.Value
            acctxs = acctxso.Value
            billxs = billxso.Value
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
    ()

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
        apiKeyGemini = ""
        aiModel = ""
        cats = ModDict_empty()
        providers = ModDict_empty()
        poolxs = ModDict_empty()
        catproviders = [| |]
    }

let RuntimeData__bin (bb:BytesBuilder) (v:RuntimeData) =

    str__bin bb v.apiKeyGemini
    str__bin bb v.aiModel
    
    ModDictInt64__bin (UCAT__bin) bb v.cats
    
    ModDictInt64__bin (UPROVIDER__bin) bb v.providers
    
    ModDictInt64__bin (PoolComplex__bin) bb v.poolxs
    
    array__bin (KUCP__bin) bb v.catproviders
    ()

let bin__RuntimeData (bi:BinIndexed):RuntimeData =
    let bin,index = bi

    {
        apiKeyGemini = 
            bi
            |> bin__str
        aiModel = 
            bi
            |> bin__str
        cats = 
            bi
            |> bin__ModDictInt64(bin__UCAT)
        providers = 
            bi
            |> bin__ModDictInt64(bin__UPROVIDER)
        poolxs = 
            bi
            |> bin__ModDictInt64(bin__PoolComplex)
        catproviders = 
            bi
            |> bin__array (bin__KUCP)
    }

let RuntimeData__json (v:RuntimeData) =

    [|  ("apiKeyGemini",str__json v.apiKeyGemini)
        ("aiModel",str__json v.aiModel)
        ("cats",ModDictInt64__json (UCAT__json) v.cats)
        ("providers",ModDictInt64__json (UPROVIDER__json) v.providers)
        ("poolxs",ModDictInt64__json (PoolComplex__json) v.poolxs)
        ("catproviders",array__json (KUCP__json) v.catproviders)
         |]
    |> Json.Braket

let RuntimeData__jsonTbw (w:TextBlockWriter) (v:RuntimeData) =
    json__str w (RuntimeData__json v)

let RuntimeData__jsonStr (v:RuntimeData) =
    (RuntimeData__json v) |> json__strFinal


let json__RuntimeDatao (json:Json):RuntimeData option =
    let fields = json |> json__items

    let mutable passOptions = true

    let apiKeyGeminio =
        match json__tryFindByName json "apiKeyGemini" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__stro with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let aiModelo =
        match json__tryFindByName json "aiModel" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__stro with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let catso =
        match json__tryFindByName json "cats" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> (fun json ->json__ModDictInt64o (json__UCATo) (new Dictionary<int64,UCAT>()) json) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let providerso =
        match json__tryFindByName json "providers" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> (fun json ->json__ModDictInt64o (json__UPROVIDERo) (new Dictionary<int64,UPROVIDER>()) json) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let poolxso =
        match json__tryFindByName json "poolxs" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> (fun json ->json__ModDictInt64o (json__PoolComplexo) (new Dictionary<int64,PoolComplex>()) json) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let catproviderso =
        match json__tryFindByName json "catproviders" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__arrayo (json__KUCPo) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    if passOptions then
        ({
            apiKeyGemini = apiKeyGeminio.Value
            aiModel = aiModelo.Value
            cats = catso.Value
            providers = providerso.Value
            poolxs = poolxso.Value
            catproviders = catproviderso.Value }:RuntimeData) |> Some
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
    ()

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

// [ProviderView] Structure

let ProviderView_empty(): ProviderView =
    {
        cat = { ID = 0L; Sort = 0L; Createdat = DateTime.MinValue; Updatedat = DateTime.MinValue; p = pUCAT_empty() }
        billxs = [| |]
        pool = [| |]
        uprovider = { ID = 0L; Sort = 0L; Createdat = DateTime.MinValue; Updatedat = DateTime.MinValue; p = pUPROVIDER_empty() }
    }

let ProviderView__bin (bb:BytesBuilder) (v:ProviderView) =

    UCAT__bin bb v.cat
    
    array__bin (BillComplex__bin) bb v.billxs
    
    array__bin (PoolComplex__bin) bb v.pool
    UPROVIDER__bin bb v.uprovider
    ()

let bin__ProviderView (bi:BinIndexed):ProviderView =
    let bin,index = bi

    {
        cat = 
            bi
            |> bin__UCAT
        billxs = 
            bi
            |> bin__array (bin__BillComplex)
        pool = 
            bi
            |> bin__array (bin__PoolComplex)
        uprovider = 
            bi
            |> bin__UPROVIDER
    }

let ProviderView__json (v:ProviderView) =

    [|  ("cat",UCAT__json v.cat)
        ("billxs",array__json (BillComplex__json) v.billxs)
        ("pool",array__json (PoolComplex__json) v.pool)
        ("uprovider",UPROVIDER__json v.uprovider)
         |]
    |> Json.Braket

let ProviderView__jsonTbw (w:TextBlockWriter) (v:ProviderView) =
    json__str w (ProviderView__json v)

let ProviderView__jsonStr (v:ProviderView) =
    (ProviderView__json v) |> json__strFinal


let json__ProviderViewo (json:Json):ProviderView option =
    let fields = json |> json__items

    let mutable passOptions = true

    let cato =
        match json__tryFindByName json "cat" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__UCATo with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let billxso =
        match json__tryFindByName json "billxs" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__arrayo (json__BillComplexo) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let poolo =
        match json__tryFindByName json "pool" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__arrayo (json__PoolComplexo) with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    let uprovidero =
        match json__tryFindByName json "uprovider" with
        | None ->
            passOptions <- false
            None
        | Some v -> 
            match v |> json__UPROVIDERo with
            | Some res -> Some res
            | None ->
                passOptions <- false
                None

    if passOptions then
        ({
            cat = cato.Value
            billxs = billxso.Value
            pool = poolo.Value
            uprovider = uprovidero.Value }:ProviderView) |> Some
    else
        None

let ProviderView_clone src =
    let bb = new BytesBuilder()
    ProviderView__bin bb src
    bin__ProviderView (bb.bytes(),ref 0)

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
    ()

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
    | Er.API3rdParty ->
        int32__bin bb 5
    ()

let bin__Er (bi:BinIndexed):Er =
    let bin,index = bi

    match bin__int32 bi with
    | 5 -> Er.API3rdParty
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
    | Er.API3rdParty ->
        ("e",int32__json 5) |> items.Add

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
            | 5 -> Er.API3rdParty |> Some
            | _ -> None
        | None -> None
    | None -> None

let Er_clone src =
    let bb = new BytesBuilder()
    Er__bin bb src
    bin__Er (bb.bytes(),ref 0)