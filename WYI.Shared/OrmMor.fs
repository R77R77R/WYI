module WYI.Shared.OrmMor

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

open System.Data.SqlClient
open System.Threading
open Util.Bin
open WYI.Shared.OrmTypes
open WYI.Shared.Types

// [EU] Structure


let pEU__bin (bb:BytesBuilder) (p:pEU) =

    
    let binCaption = p.Caption |> Encoding.UTF8.GetBytes
    binCaption.Length |> BitConverter.GetBytes |> bb.append
    binCaption |> bb.append
    
    let binUsername = p.Username |> Encoding.UTF8.GetBytes
    binUsername.Length |> BitConverter.GetBytes |> bb.append
    binUsername |> bb.append
    
    let binEmail = p.Email |> Encoding.UTF8.GetBytes
    binEmail.Length |> BitConverter.GetBytes |> bb.append
    binEmail |> bb.append
    
    let binAvatar = p.Avatar |> Encoding.UTF8.GetBytes
    binAvatar.Length |> BitConverter.GetBytes |> bb.append
    binAvatar |> bb.append
    
    let binOAuthProvider = p.OAuthProvider |> Encoding.UTF8.GetBytes
    binOAuthProvider.Length |> BitConverter.GetBytes |> bb.append
    binOAuthProvider |> bb.append
    
    let binClerkUserID = p.ClerkUserID |> Encoding.UTF8.GetBytes
    binClerkUserID.Length |> BitConverter.GetBytes |> bb.append
    binClerkUserID |> bb.append
    
    let binPwd = p.Pwd |> Encoding.UTF8.GetBytes
    binPwd.Length |> BitConverter.GetBytes |> bb.append
    binPwd |> bb.append
    
    p.AuthType |> EnumToValue |> BitConverter.GetBytes |> bb.append

let EU__bin (bb:BytesBuilder) (v:EU) =
    v.ID |> BitConverter.GetBytes |> bb.append
    v.Sort |> BitConverter.GetBytes |> bb.append
    DateTime__bin bb v.Createdat
    DateTime__bin bb v.Updatedat
    
    pEU__bin bb v.p
    ()

let bin__pEU (bi:BinIndexed):pEU =
    let bin,index = bi

    let p = pEU_empty()
    
    let count_Caption = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Caption <- Encoding.UTF8.GetString(bin,index.Value,count_Caption)
    index.Value <- index.Value + count_Caption
    
    let count_Username = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Username <- Encoding.UTF8.GetString(bin,index.Value,count_Username)
    index.Value <- index.Value + count_Username
    
    let count_Email = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Email <- Encoding.UTF8.GetString(bin,index.Value,count_Email)
    index.Value <- index.Value + count_Email
    
    let count_Avatar = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Avatar <- Encoding.UTF8.GetString(bin,index.Value,count_Avatar)
    index.Value <- index.Value + count_Avatar
    
    let count_OAuthProvider = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.OAuthProvider <- Encoding.UTF8.GetString(bin,index.Value,count_OAuthProvider)
    index.Value <- index.Value + count_OAuthProvider
    
    let count_ClerkUserID = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.ClerkUserID <- Encoding.UTF8.GetString(bin,index.Value,count_ClerkUserID)
    index.Value <- index.Value + count_ClerkUserID
    
    let count_Pwd = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Pwd <- Encoding.UTF8.GetString(bin,index.Value,count_Pwd)
    index.Value <- index.Value + count_Pwd
    
    p.AuthType <- BitConverter.ToInt32(bin,index.Value) |> EnumOfValue
    index.Value <- index.Value + 4
    
    p

let bin__EU (bi:BinIndexed):EU =
    let bin,index = bi

    let ID = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Sort = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Createdat = bin__DateTime bi
    
    let Updatedat = bin__DateTime bi
    
    {
        ID = ID
        Sort = Sort
        Createdat = Createdat
        Updatedat = Updatedat
        p = bin__pEU bi }

let pEU__json (p:pEU) =

    [|
        ("Caption",p.Caption |> Json.Str)
        ("Username",p.Username |> Json.Str)
        ("Email",p.Email |> Json.Str)
        ("Avatar",p.Avatar |> Json.Str)
        ("OAuthProvider",p.OAuthProvider |> Json.Str)
        ("ClerkUserID",p.ClerkUserID |> Json.Str)
        ("Pwd",p.Pwd |> Json.Str)
        ("AuthType",(p.AuthType |> EnumToValue).ToString() |> Json.Num) |]
    |> Json.Braket

let EU__json (v:EU) =

    let p = v.p
    
    [|  ("id",v.ID.ToString() |> Json.Num)
        ("sort",v.Sort.ToString() |> Json.Num)
        ("createdat",(v.Createdat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("updatedat",(v.Updatedat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("p",pEU__json v.p) |]
    |> Json.Braket

let EU__jsonTbw (w:TextBlockWriter) (v:EU) =
    json__str w (EU__json v)

let EU__jsonStr (v:EU) =
    (EU__json v) |> json__strFinal


let json__pEUo (json:Json):pEU option =
    let fields = json |> json__items

    let p = pEU_empty()
    
    p.Caption <- checkfieldz fields "Caption" 64
    
    p.Username <- checkfieldz fields "Username" 64
    
    p.Email <- checkfieldz fields "Email" 255
    
    p.Avatar <- checkfield fields "Avatar"
    
    p.OAuthProvider <- checkfieldz fields "OAuthProvider" 64
    
    p.ClerkUserID <- checkfieldz fields "ClerkUserID" 100
    
    p.Pwd <- checkfieldz fields "Pwd" 64
    
    p.AuthType <- checkfield fields "AuthType" |> parse_int32 |> EnumOfValue
    
    p |> Some
    

let json__EUo (json:Json):EU option =
    let fields = json |> json__items

    let ID = checkfield fields "id" |> parse_int64
    let Sort = checkfield fields "sort" |> parse_int64
    let Createdat = checkfield fields "createdat" |> parse_int64 |> DateTime.FromBinary
    let Updatedat = checkfield fields "updatedat" |> parse_int64 |> DateTime.FromBinary
    
    let o  =
        match
            json
            |> tryFindByAtt "p" with
        | Some (s,v) -> json__pEUo v
        | None -> None
    
    match o with
    | Some p ->
        
        {
            ID = ID
            Sort = Sort
            Createdat = Createdat
            Updatedat = Updatedat
            p = p } |> Some
        
    | None -> None

let EU_clone src =
    let bb = new BytesBuilder()
    EU__bin bb src
    bin__EU (bb.bytes(),ref 0)

// [FILE] Structure


let pFILE__bin (bb:BytesBuilder) (p:pFILE) =

    
    let binCaption = p.Caption |> Encoding.UTF8.GetBytes
    binCaption.Length |> BitConverter.GetBytes |> bb.append
    binCaption |> bb.append
    
    let binPath = p.Path |> Encoding.UTF8.GetBytes
    binPath.Length |> BitConverter.GetBytes |> bb.append
    binPath |> bb.append
    
    p.State |> EnumToValue |> BitConverter.GetBytes |> bb.append
    
    let binContentType = p.ContentType |> Encoding.UTF8.GetBytes
    binContentType.Length |> BitConverter.GetBytes |> bb.append
    binContentType |> bb.append
    
    let binSuffix = p.Suffix |> Encoding.UTF8.GetBytes
    binSuffix.Length |> BitConverter.GetBytes |> bb.append
    binSuffix |> bb.append
    
    p.Size |> BitConverter.GetBytes |> bb.append
    
    p.Thumbnail.Length |> BitConverter.GetBytes |> bb.append
    p.Thumbnail |> bb.append
    
    p.Owner |> BitConverter.GetBytes |> bb.append
    
    p.Cat |> BitConverter.GetBytes |> bb.append
    
    p.Provider |> BitConverter.GetBytes |> bb.append
    
    p.Unit |> BitConverter.GetBytes |> bb.append
    
    p.Bill |> BitConverter.GetBytes |> bb.append

let FILE__bin (bb:BytesBuilder) (v:FILE) =
    v.ID |> BitConverter.GetBytes |> bb.append
    v.Sort |> BitConverter.GetBytes |> bb.append
    DateTime__bin bb v.Createdat
    DateTime__bin bb v.Updatedat
    
    pFILE__bin bb v.p
    ()

let bin__pFILE (bi:BinIndexed):pFILE =
    let bin,index = bi

    let p = pFILE_empty()
    
    let count_Caption = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Caption <- Encoding.UTF8.GetString(bin,index.Value,count_Caption)
    index.Value <- index.Value + count_Caption
    
    let count_Path = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Path <- Encoding.UTF8.GetString(bin,index.Value,count_Path)
    index.Value <- index.Value + count_Path
    
    p.State <- BitConverter.ToInt32(bin,index.Value) |> EnumOfValue
    index.Value <- index.Value + 4
    
    let count_ContentType = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.ContentType <- Encoding.UTF8.GetString(bin,index.Value,count_ContentType)
    index.Value <- index.Value + count_ContentType
    
    let count_Suffix = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Suffix <- Encoding.UTF8.GetString(bin,index.Value,count_Suffix)
    index.Value <- index.Value + count_Suffix
    
    p.Size <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let length_Thumbnail = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Thumbnail <- Array.sub bin index.Value length_Thumbnail
    index.Value <- index.Value + length_Thumbnail
    
    p.Owner <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.Cat <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.Provider <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.Unit <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.Bill <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p

let bin__FILE (bi:BinIndexed):FILE =
    let bin,index = bi

    let ID = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Sort = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Createdat = bin__DateTime bi
    
    let Updatedat = bin__DateTime bi
    
    {
        ID = ID
        Sort = Sort
        Createdat = Createdat
        Updatedat = Updatedat
        p = bin__pFILE bi }

let pFILE__json (p:pFILE) =

    [|
        ("Caption",p.Caption |> Json.Str)
        ("Path",p.Path |> Json.Str)
        ("State",(p.State |> EnumToValue).ToString() |> Json.Num)
        ("ContentType",p.ContentType |> Json.Str)
        ("Suffix",p.Suffix |> Json.Str)
        ("Size",p.Size.ToString() |> Json.Num)
        ("Thumbnail",p.Thumbnail |> Convert.ToBase64String |> Json.Str)
        ("Owner",p.Owner.ToString() |> Json.Num)
        ("Cat",p.Cat.ToString() |> Json.Num)
        ("Provider",p.Provider.ToString() |> Json.Num)
        ("Unit",p.Unit.ToString() |> Json.Num)
        ("Bill",p.Bill.ToString() |> Json.Num) |]
    |> Json.Braket

let FILE__json (v:FILE) =

    let p = v.p
    
    [|  ("id",v.ID.ToString() |> Json.Num)
        ("sort",v.Sort.ToString() |> Json.Num)
        ("createdat",(v.Createdat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("updatedat",(v.Updatedat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("p",pFILE__json v.p) |]
    |> Json.Braket

let FILE__jsonTbw (w:TextBlockWriter) (v:FILE) =
    json__str w (FILE__json v)

let FILE__jsonStr (v:FILE) =
    (FILE__json v) |> json__strFinal


let json__pFILEo (json:Json):pFILE option =
    let fields = json |> json__items

    let p = pFILE_empty()
    
    p.Caption <- checkfield fields "Caption"
    
    p.Path <- checkfield fields "Path"
    
    p.State <- checkfield fields "State" |> parse_int32 |> EnumOfValue
    
    p.ContentType <- checkfieldz fields "ContentType" 256
    
    p.Suffix <- checkfieldz fields "Suffix" 4
    
    p.Size <- checkfield fields "Size" |> parse_int64
    
    p.Owner <- checkfield fields "Owner" |> parse_int64
    
    p.Cat <- checkfield fields "Cat" |> parse_int64
    
    p.Provider <- checkfield fields "Provider" |> parse_int64
    
    p.Unit <- checkfield fields "Unit" |> parse_int64
    
    p.Bill <- checkfield fields "Bill" |> parse_int64
    
    p |> Some
    

let json__FILEo (json:Json):FILE option =
    let fields = json |> json__items

    let ID = checkfield fields "id" |> parse_int64
    let Sort = checkfield fields "sort" |> parse_int64
    let Createdat = checkfield fields "createdat" |> parse_int64 |> DateTime.FromBinary
    let Updatedat = checkfield fields "updatedat" |> parse_int64 |> DateTime.FromBinary
    
    let o  =
        match
            json
            |> tryFindByAtt "p" with
        | Some (s,v) -> json__pFILEo v
        | None -> None
    
    match o with
    | Some p ->
        
        {
            ID = ID
            Sort = Sort
            Createdat = Createdat
            Updatedat = Updatedat
            p = p } |> Some
        
    | None -> None

let FILE_clone src =
    let bb = new BytesBuilder()
    FILE__bin bb src
    bin__FILE (bb.bytes(),ref 0)

// [POOL] Structure


let pPOOL__bin (bb:BytesBuilder) (p:pPOOL) =

    
    p.Cat |> BitConverter.GetBytes |> bb.append
    
    p.Provider |> BitConverter.GetBytes |> bb.append
    
    p.Manager |> BitConverter.GetBytes |> bb.append
    
    p.State |> EnumToValue |> BitConverter.GetBytes |> bb.append
    
    let binNotes = p.Notes |> Encoding.UTF8.GetBytes
    binNotes.Length |> BitConverter.GetBytes |> bb.append
    binNotes |> bb.append
    
    p.Amt |> BitConverter.GetBytes |> bb.append
    
    p.AmtReduction |> BitConverter.GetBytes |> bb.append
    
    p.AmtReturn |> BitConverter.GetBytes |> bb.append

let POOL__bin (bb:BytesBuilder) (v:POOL) =
    v.ID |> BitConverter.GetBytes |> bb.append
    v.Sort |> BitConverter.GetBytes |> bb.append
    DateTime__bin bb v.Createdat
    DateTime__bin bb v.Updatedat
    
    pPOOL__bin bb v.p
    ()

let bin__pPOOL (bi:BinIndexed):pPOOL =
    let bin,index = bi

    let p = pPOOL_empty()
    
    p.Cat <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.Provider <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.Manager <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.State <- BitConverter.ToInt32(bin,index.Value) |> EnumOfValue
    index.Value <- index.Value + 4
    
    let count_Notes = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Notes <- Encoding.UTF8.GetString(bin,index.Value,count_Notes)
    index.Value <- index.Value + count_Notes
    
    p.Amt <- BitConverter.ToDouble(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.AmtReduction <- BitConverter.ToDouble(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.AmtReturn <- BitConverter.ToDouble(bin,index.Value)
    index.Value <- index.Value + 8
    
    p

let bin__POOL (bi:BinIndexed):POOL =
    let bin,index = bi

    let ID = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Sort = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Createdat = bin__DateTime bi
    
    let Updatedat = bin__DateTime bi
    
    {
        ID = ID
        Sort = Sort
        Createdat = Createdat
        Updatedat = Updatedat
        p = bin__pPOOL bi }

let pPOOL__json (p:pPOOL) =

    [|
        ("Cat",p.Cat.ToString() |> Json.Num)
        ("Provider",p.Provider.ToString() |> Json.Num)
        ("Manager",p.Manager.ToString() |> Json.Num)
        ("State",(p.State |> EnumToValue).ToString() |> Json.Num)
        ("Notes",p.Notes |> Json.Str)
        ("Amt",p.Amt.ToString() |> Json.Num)
        ("AmtReduction",p.AmtReduction.ToString() |> Json.Num)
        ("AmtReturn",p.AmtReturn.ToString() |> Json.Num) |]
    |> Json.Braket

let POOL__json (v:POOL) =

    let p = v.p
    
    [|  ("id",v.ID.ToString() |> Json.Num)
        ("sort",v.Sort.ToString() |> Json.Num)
        ("createdat",(v.Createdat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("updatedat",(v.Updatedat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("p",pPOOL__json v.p) |]
    |> Json.Braket

let POOL__jsonTbw (w:TextBlockWriter) (v:POOL) =
    json__str w (POOL__json v)

let POOL__jsonStr (v:POOL) =
    (POOL__json v) |> json__strFinal


let json__pPOOLo (json:Json):pPOOL option =
    let fields = json |> json__items

    let p = pPOOL_empty()
    
    p.Cat <- checkfield fields "Cat" |> parse_int64
    
    p.Provider <- checkfield fields "Provider" |> parse_int64
    
    p.Manager <- checkfield fields "Manager" |> parse_int64
    
    p.State <- checkfield fields "State" |> parse_int32 |> EnumOfValue
    
    p.Notes <- checkfield fields "Notes"
    
    p.Amt <- checkfield fields "Amt" |> parse_float
    
    p.AmtReduction <- checkfield fields "AmtReduction" |> parse_float
    
    p.AmtReturn <- checkfield fields "AmtReturn" |> parse_float
    
    p |> Some
    

let json__POOLo (json:Json):POOL option =
    let fields = json |> json__items

    let ID = checkfield fields "id" |> parse_int64
    let Sort = checkfield fields "sort" |> parse_int64
    let Createdat = checkfield fields "createdat" |> parse_int64 |> DateTime.FromBinary
    let Updatedat = checkfield fields "updatedat" |> parse_int64 |> DateTime.FromBinary
    
    let o  =
        match
            json
            |> tryFindByAtt "p" with
        | Some (s,v) -> json__pPOOLo v
        | None -> None
    
    match o with
    | Some p ->
        
        {
            ID = ID
            Sort = Sort
            Createdat = Createdat
            Updatedat = Updatedat
            p = p } |> Some
        
    | None -> None

let POOL_clone src =
    let bb = new BytesBuilder()
    POOL__bin bb src
    bin__POOL (bb.bytes(),ref 0)

// [UNIT] Structure


let pUNIT__bin (bb:BytesBuilder) (p:pUNIT) =

    
    let binCaption = p.Caption |> Encoding.UTF8.GetBytes
    binCaption.Length |> BitConverter.GetBytes |> bb.append
    binCaption |> bb.append
    
    p.Owner |> BitConverter.GetBytes |> bb.append
    
    let binUnitNum = p.UnitNum |> Encoding.UTF8.GetBytes
    binUnitNum.Length |> BitConverter.GetBytes |> bb.append
    binUnitNum |> bb.append
    
    let binAcctNum = p.AcctNum |> Encoding.UTF8.GetBytes
    binAcctNum.Length |> BitConverter.GetBytes |> bb.append
    binAcctNum |> bb.append
    
    let binAddress = p.Address |> Encoding.UTF8.GetBytes
    binAddress.Length |> BitConverter.GetBytes |> bb.append
    binAddress |> bb.append
    
    let binTown = p.Town |> Encoding.UTF8.GetBytes
    binTown.Length |> BitConverter.GetBytes |> bb.append
    binTown |> bb.append
    
    let binState = p.State |> Encoding.UTF8.GetBytes
    binState.Length |> BitConverter.GetBytes |> bb.append
    binState |> bb.append
    
    let binZip = p.Zip |> Encoding.UTF8.GetBytes
    binZip.Length |> BitConverter.GetBytes |> bb.append
    binZip |> bb.append

let UNIT__bin (bb:BytesBuilder) (v:UNIT) =
    v.ID |> BitConverter.GetBytes |> bb.append
    v.Sort |> BitConverter.GetBytes |> bb.append
    DateTime__bin bb v.Createdat
    DateTime__bin bb v.Updatedat
    
    pUNIT__bin bb v.p
    ()

let bin__pUNIT (bi:BinIndexed):pUNIT =
    let bin,index = bi

    let p = pUNIT_empty()
    
    let count_Caption = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Caption <- Encoding.UTF8.GetString(bin,index.Value,count_Caption)
    index.Value <- index.Value + count_Caption
    
    p.Owner <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let count_UnitNum = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.UnitNum <- Encoding.UTF8.GetString(bin,index.Value,count_UnitNum)
    index.Value <- index.Value + count_UnitNum
    
    let count_AcctNum = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.AcctNum <- Encoding.UTF8.GetString(bin,index.Value,count_AcctNum)
    index.Value <- index.Value + count_AcctNum
    
    let count_Address = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Address <- Encoding.UTF8.GetString(bin,index.Value,count_Address)
    index.Value <- index.Value + count_Address
    
    let count_Town = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Town <- Encoding.UTF8.GetString(bin,index.Value,count_Town)
    index.Value <- index.Value + count_Town
    
    let count_State = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.State <- Encoding.UTF8.GetString(bin,index.Value,count_State)
    index.Value <- index.Value + count_State
    
    let count_Zip = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Zip <- Encoding.UTF8.GetString(bin,index.Value,count_Zip)
    index.Value <- index.Value + count_Zip
    
    p

let bin__UNIT (bi:BinIndexed):UNIT =
    let bin,index = bi

    let ID = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Sort = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Createdat = bin__DateTime bi
    
    let Updatedat = bin__DateTime bi
    
    {
        ID = ID
        Sort = Sort
        Createdat = Createdat
        Updatedat = Updatedat
        p = bin__pUNIT bi }

let pUNIT__json (p:pUNIT) =

    [|
        ("Caption",p.Caption |> Json.Str)
        ("Owner",p.Owner.ToString() |> Json.Num)
        ("UnitNum",p.UnitNum |> Json.Str)
        ("AcctNum",p.AcctNum |> Json.Str)
        ("Address",p.Address |> Json.Str)
        ("Town",p.Town |> Json.Str)
        ("State",p.State |> Json.Str)
        ("Zip",p.Zip |> Json.Str) |]
    |> Json.Braket

let UNIT__json (v:UNIT) =

    let p = v.p
    
    [|  ("id",v.ID.ToString() |> Json.Num)
        ("sort",v.Sort.ToString() |> Json.Num)
        ("createdat",(v.Createdat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("updatedat",(v.Updatedat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("p",pUNIT__json v.p) |]
    |> Json.Braket

let UNIT__jsonTbw (w:TextBlockWriter) (v:UNIT) =
    json__str w (UNIT__json v)

let UNIT__jsonStr (v:UNIT) =
    (UNIT__json v) |> json__strFinal


let json__pUNITo (json:Json):pUNIT option =
    let fields = json |> json__items

    let p = pUNIT_empty()
    
    p.Caption <- checkfield fields "Caption"
    
    p.Owner <- checkfield fields "Owner" |> parse_int64
    
    p.UnitNum <- checkfieldz fields "UnitNum" 5
    
    p.AcctNum <- checkfield fields "AcctNum"
    
    p.Address <- checkfield fields "Address"
    
    p.Town <- checkfield fields "Town"
    
    p.State <- checkfieldz fields "State" 2
    
    p.Zip <- checkfieldz fields "Zip" 10
    
    p |> Some
    

let json__UNITo (json:Json):UNIT option =
    let fields = json |> json__items

    let ID = checkfield fields "id" |> parse_int64
    let Sort = checkfield fields "sort" |> parse_int64
    let Createdat = checkfield fields "createdat" |> parse_int64 |> DateTime.FromBinary
    let Updatedat = checkfield fields "updatedat" |> parse_int64 |> DateTime.FromBinary
    
    let o  =
        match
            json
            |> tryFindByAtt "p" with
        | Some (s,v) -> json__pUNITo v
        | None -> None
    
    match o with
    | Some p ->
        
        {
            ID = ID
            Sort = Sort
            Createdat = Createdat
            Updatedat = Updatedat
            p = p } |> Some
        
    | None -> None

let UNIT_clone src =
    let bb = new BytesBuilder()
    UNIT__bin bb src
    bin__UNIT (bb.bytes(),ref 0)

// [UACCT] Structure


let pUACCT__bin (bb:BytesBuilder) (p:pUACCT) =

    
    p.Cat |> BitConverter.GetBytes |> bb.append
    
    p.Provider |> BitConverter.GetBytes |> bb.append
    
    p.Owner |> BitConverter.GetBytes |> bb.append
    
    p.Unit |> BitConverter.GetBytes |> bb.append
    
    let binAcctName = p.AcctName |> Encoding.UTF8.GetBytes
    binAcctName.Length |> BitConverter.GetBytes |> bb.append
    binAcctName |> bb.append
    
    let binAcctNum = p.AcctNum |> Encoding.UTF8.GetBytes
    binAcctNum.Length |> BitConverter.GetBytes |> bb.append
    binAcctNum |> bb.append

let UACCT__bin (bb:BytesBuilder) (v:UACCT) =
    v.ID |> BitConverter.GetBytes |> bb.append
    v.Sort |> BitConverter.GetBytes |> bb.append
    DateTime__bin bb v.Createdat
    DateTime__bin bb v.Updatedat
    
    pUACCT__bin bb v.p
    ()

let bin__pUACCT (bi:BinIndexed):pUACCT =
    let bin,index = bi

    let p = pUACCT_empty()
    
    p.Cat <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.Provider <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.Owner <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.Unit <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let count_AcctName = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.AcctName <- Encoding.UTF8.GetString(bin,index.Value,count_AcctName)
    index.Value <- index.Value + count_AcctName
    
    let count_AcctNum = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.AcctNum <- Encoding.UTF8.GetString(bin,index.Value,count_AcctNum)
    index.Value <- index.Value + count_AcctNum
    
    p

let bin__UACCT (bi:BinIndexed):UACCT =
    let bin,index = bi

    let ID = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Sort = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Createdat = bin__DateTime bi
    
    let Updatedat = bin__DateTime bi
    
    {
        ID = ID
        Sort = Sort
        Createdat = Createdat
        Updatedat = Updatedat
        p = bin__pUACCT bi }

let pUACCT__json (p:pUACCT) =

    [|
        ("Cat",p.Cat.ToString() |> Json.Num)
        ("Provider",p.Provider.ToString() |> Json.Num)
        ("Owner",p.Owner.ToString() |> Json.Num)
        ("Unit",p.Unit.ToString() |> Json.Num)
        ("AcctName",p.AcctName |> Json.Str)
        ("AcctNum",p.AcctNum |> Json.Str) |]
    |> Json.Braket

let UACCT__json (v:UACCT) =

    let p = v.p
    
    [|  ("id",v.ID.ToString() |> Json.Num)
        ("sort",v.Sort.ToString() |> Json.Num)
        ("createdat",(v.Createdat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("updatedat",(v.Updatedat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("p",pUACCT__json v.p) |]
    |> Json.Braket

let UACCT__jsonTbw (w:TextBlockWriter) (v:UACCT) =
    json__str w (UACCT__json v)

let UACCT__jsonStr (v:UACCT) =
    (UACCT__json v) |> json__strFinal


let json__pUACCTo (json:Json):pUACCT option =
    let fields = json |> json__items

    let p = pUACCT_empty()
    
    p.Cat <- checkfield fields "Cat" |> parse_int64
    
    p.Provider <- checkfield fields "Provider" |> parse_int64
    
    p.Owner <- checkfield fields "Owner" |> parse_int64
    
    p.Unit <- checkfield fields "Unit" |> parse_int64
    
    p.AcctName <- checkfield fields "AcctName"
    
    p.AcctNum <- checkfield fields "AcctNum"
    
    p |> Some
    

let json__UACCTo (json:Json):UACCT option =
    let fields = json |> json__items

    let ID = checkfield fields "id" |> parse_int64
    let Sort = checkfield fields "sort" |> parse_int64
    let Createdat = checkfield fields "createdat" |> parse_int64 |> DateTime.FromBinary
    let Updatedat = checkfield fields "updatedat" |> parse_int64 |> DateTime.FromBinary
    
    let o  =
        match
            json
            |> tryFindByAtt "p" with
        | Some (s,v) -> json__pUACCTo v
        | None -> None
    
    match o with
    | Some p ->
        
        {
            ID = ID
            Sort = Sort
            Createdat = Createdat
            Updatedat = Updatedat
            p = p } |> Some
        
    | None -> None

let UACCT_clone src =
    let bb = new BytesBuilder()
    UACCT__bin bb src
    bin__UACCT (bb.bytes(),ref 0)

// [UBILL] Structure


let pUBILL__bin (bb:BytesBuilder) (p:pUBILL) =

    
    p.Cat |> BitConverter.GetBytes |> bb.append
    
    p.Provider |> BitConverter.GetBytes |> bb.append
    
    p.Owner |> BitConverter.GetBytes |> bb.append
    
    p.Representative |> BitConverter.GetBytes |> bb.append
    
    p.Unit |> BitConverter.GetBytes |> bb.append
    
    p.State |> EnumToValue |> BitConverter.GetBytes |> bb.append
    
    p.UAcct |> BitConverter.GetBytes |> bb.append
    
    p.Pool |> BitConverter.GetBytes |> bb.append
    
    let binYYYYMMDD = p.YYYYMMDD |> Encoding.UTF8.GetBytes
    binYYYYMMDD.Length |> BitConverter.GetBytes |> bb.append
    binYYYYMMDD |> bb.append
    
    p.Amt |> BitConverter.GetBytes |> bb.append
    
    p.AmtReduction |> BitConverter.GetBytes |> bb.append
    
    p.AmtReturn |> BitConverter.GetBytes |> bb.append

let UBILL__bin (bb:BytesBuilder) (v:UBILL) =
    v.ID |> BitConverter.GetBytes |> bb.append
    v.Sort |> BitConverter.GetBytes |> bb.append
    DateTime__bin bb v.Createdat
    DateTime__bin bb v.Updatedat
    
    pUBILL__bin bb v.p
    ()

let bin__pUBILL (bi:BinIndexed):pUBILL =
    let bin,index = bi

    let p = pUBILL_empty()
    
    p.Cat <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.Provider <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.Owner <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.Representative <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.Unit <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.State <- BitConverter.ToInt32(bin,index.Value) |> EnumOfValue
    index.Value <- index.Value + 4
    
    p.UAcct <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.Pool <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let count_YYYYMMDD = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.YYYYMMDD <- Encoding.UTF8.GetString(bin,index.Value,count_YYYYMMDD)
    index.Value <- index.Value + count_YYYYMMDD
    
    p.Amt <- BitConverter.ToDouble(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.AmtReduction <- BitConverter.ToDouble(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.AmtReturn <- BitConverter.ToDouble(bin,index.Value)
    index.Value <- index.Value + 8
    
    p

let bin__UBILL (bi:BinIndexed):UBILL =
    let bin,index = bi

    let ID = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Sort = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Createdat = bin__DateTime bi
    
    let Updatedat = bin__DateTime bi
    
    {
        ID = ID
        Sort = Sort
        Createdat = Createdat
        Updatedat = Updatedat
        p = bin__pUBILL bi }

let pUBILL__json (p:pUBILL) =

    [|
        ("Cat",p.Cat.ToString() |> Json.Num)
        ("Provider",p.Provider.ToString() |> Json.Num)
        ("Owner",p.Owner.ToString() |> Json.Num)
        ("Representative",p.Representative.ToString() |> Json.Num)
        ("Unit",p.Unit.ToString() |> Json.Num)
        ("State",(p.State |> EnumToValue).ToString() |> Json.Num)
        ("UAcct",p.UAcct.ToString() |> Json.Num)
        ("Pool",p.Pool.ToString() |> Json.Num)
        ("YYYYMMDD",p.YYYYMMDD |> Json.Str)
        ("Amt",p.Amt.ToString() |> Json.Num)
        ("AmtReduction",p.AmtReduction.ToString() |> Json.Num)
        ("AmtReturn",p.AmtReturn.ToString() |> Json.Num) |]
    |> Json.Braket

let UBILL__json (v:UBILL) =

    let p = v.p
    
    [|  ("id",v.ID.ToString() |> Json.Num)
        ("sort",v.Sort.ToString() |> Json.Num)
        ("createdat",(v.Createdat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("updatedat",(v.Updatedat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("p",pUBILL__json v.p) |]
    |> Json.Braket

let UBILL__jsonTbw (w:TextBlockWriter) (v:UBILL) =
    json__str w (UBILL__json v)

let UBILL__jsonStr (v:UBILL) =
    (UBILL__json v) |> json__strFinal


let json__pUBILLo (json:Json):pUBILL option =
    let fields = json |> json__items

    let p = pUBILL_empty()
    
    p.Cat <- checkfield fields "Cat" |> parse_int64
    
    p.Provider <- checkfield fields "Provider" |> parse_int64
    
    p.Owner <- checkfield fields "Owner" |> parse_int64
    
    p.Representative <- checkfield fields "Representative" |> parse_int64
    
    p.Unit <- checkfield fields "Unit" |> parse_int64
    
    p.State <- checkfield fields "State" |> parse_int32 |> EnumOfValue
    
    p.UAcct <- checkfield fields "UAcct" |> parse_int64
    
    p.Pool <- checkfield fields "Pool" |> parse_int64
    
    p.YYYYMMDD <- checkfieldz fields "YYYYMMDD" 8
    
    p.Amt <- checkfield fields "Amt" |> parse_float
    
    p.AmtReduction <- checkfield fields "AmtReduction" |> parse_float
    
    p.AmtReturn <- checkfield fields "AmtReturn" |> parse_float
    
    p |> Some
    

let json__UBILLo (json:Json):UBILL option =
    let fields = json |> json__items

    let ID = checkfield fields "id" |> parse_int64
    let Sort = checkfield fields "sort" |> parse_int64
    let Createdat = checkfield fields "createdat" |> parse_int64 |> DateTime.FromBinary
    let Updatedat = checkfield fields "updatedat" |> parse_int64 |> DateTime.FromBinary
    
    let o  =
        match
            json
            |> tryFindByAtt "p" with
        | Some (s,v) -> json__pUBILLo v
        | None -> None
    
    match o with
    | Some p ->
        
        {
            ID = ID
            Sort = Sort
            Createdat = Createdat
            Updatedat = Updatedat
            p = p } |> Some
        
    | None -> None

let UBILL_clone src =
    let bb = new BytesBuilder()
    UBILL__bin bb src
    bin__UBILL (bb.bytes(),ref 0)

// [UCAT] Structure


let pUCAT__bin (bb:BytesBuilder) (p:pUCAT) =

    
    let binCaption = p.Caption |> Encoding.UTF8.GetBytes
    binCaption.Length |> BitConverter.GetBytes |> bb.append
    binCaption |> bb.append

let UCAT__bin (bb:BytesBuilder) (v:UCAT) =
    v.ID |> BitConverter.GetBytes |> bb.append
    v.Sort |> BitConverter.GetBytes |> bb.append
    DateTime__bin bb v.Createdat
    DateTime__bin bb v.Updatedat
    
    pUCAT__bin bb v.p
    ()

let bin__pUCAT (bi:BinIndexed):pUCAT =
    let bin,index = bi

    let p = pUCAT_empty()
    
    let count_Caption = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Caption <- Encoding.UTF8.GetString(bin,index.Value,count_Caption)
    index.Value <- index.Value + count_Caption
    
    p

let bin__UCAT (bi:BinIndexed):UCAT =
    let bin,index = bi

    let ID = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Sort = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Createdat = bin__DateTime bi
    
    let Updatedat = bin__DateTime bi
    
    {
        ID = ID
        Sort = Sort
        Createdat = Createdat
        Updatedat = Updatedat
        p = bin__pUCAT bi }

let pUCAT__json (p:pUCAT) =

    [|
        ("Caption",p.Caption |> Json.Str) |]
    |> Json.Braket

let UCAT__json (v:UCAT) =

    let p = v.p
    
    [|  ("id",v.ID.ToString() |> Json.Num)
        ("sort",v.Sort.ToString() |> Json.Num)
        ("createdat",(v.Createdat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("updatedat",(v.Updatedat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("p",pUCAT__json v.p) |]
    |> Json.Braket

let UCAT__jsonTbw (w:TextBlockWriter) (v:UCAT) =
    json__str w (UCAT__json v)

let UCAT__jsonStr (v:UCAT) =
    (UCAT__json v) |> json__strFinal


let json__pUCATo (json:Json):pUCAT option =
    let fields = json |> json__items

    let p = pUCAT_empty()
    
    p.Caption <- checkfield fields "Caption"
    
    p |> Some
    

let json__UCATo (json:Json):UCAT option =
    let fields = json |> json__items

    let ID = checkfield fields "id" |> parse_int64
    let Sort = checkfield fields "sort" |> parse_int64
    let Createdat = checkfield fields "createdat" |> parse_int64 |> DateTime.FromBinary
    let Updatedat = checkfield fields "updatedat" |> parse_int64 |> DateTime.FromBinary
    
    let o  =
        match
            json
            |> tryFindByAtt "p" with
        | Some (s,v) -> json__pUCATo v
        | None -> None
    
    match o with
    | Some p ->
        
        {
            ID = ID
            Sort = Sort
            Createdat = Createdat
            Updatedat = Updatedat
            p = p } |> Some
        
    | None -> None

let UCAT_clone src =
    let bb = new BytesBuilder()
    UCAT__bin bb src
    bin__UCAT (bb.bytes(),ref 0)

// [KUCP] Structure


let pKUCP__bin (bb:BytesBuilder) (p:pKUCP) =

    
    p.Cat |> BitConverter.GetBytes |> bb.append
    
    p.Provider |> BitConverter.GetBytes |> bb.append

let KUCP__bin (bb:BytesBuilder) (v:KUCP) =
    v.ID |> BitConverter.GetBytes |> bb.append
    v.Sort |> BitConverter.GetBytes |> bb.append
    DateTime__bin bb v.Createdat
    DateTime__bin bb v.Updatedat
    
    pKUCP__bin bb v.p
    ()

let bin__pKUCP (bi:BinIndexed):pKUCP =
    let bin,index = bi

    let p = pKUCP_empty()
    
    p.Cat <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.Provider <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p

let bin__KUCP (bi:BinIndexed):KUCP =
    let bin,index = bi

    let ID = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Sort = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Createdat = bin__DateTime bi
    
    let Updatedat = bin__DateTime bi
    
    {
        ID = ID
        Sort = Sort
        Createdat = Createdat
        Updatedat = Updatedat
        p = bin__pKUCP bi }

let pKUCP__json (p:pKUCP) =

    [|
        ("Cat",p.Cat.ToString() |> Json.Num)
        ("Provider",p.Provider.ToString() |> Json.Num) |]
    |> Json.Braket

let KUCP__json (v:KUCP) =

    let p = v.p
    
    [|  ("id",v.ID.ToString() |> Json.Num)
        ("sort",v.Sort.ToString() |> Json.Num)
        ("createdat",(v.Createdat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("updatedat",(v.Updatedat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("p",pKUCP__json v.p) |]
    |> Json.Braket

let KUCP__jsonTbw (w:TextBlockWriter) (v:KUCP) =
    json__str w (KUCP__json v)

let KUCP__jsonStr (v:KUCP) =
    (KUCP__json v) |> json__strFinal


let json__pKUCPo (json:Json):pKUCP option =
    let fields = json |> json__items

    let p = pKUCP_empty()
    
    p.Cat <- checkfield fields "Cat" |> parse_int64
    
    p.Provider <- checkfield fields "Provider" |> parse_int64
    
    p |> Some
    

let json__KUCPo (json:Json):KUCP option =
    let fields = json |> json__items

    let ID = checkfield fields "id" |> parse_int64
    let Sort = checkfield fields "sort" |> parse_int64
    let Createdat = checkfield fields "createdat" |> parse_int64 |> DateTime.FromBinary
    let Updatedat = checkfield fields "updatedat" |> parse_int64 |> DateTime.FromBinary
    
    let o  =
        match
            json
            |> tryFindByAtt "p" with
        | Some (s,v) -> json__pKUCPo v
        | None -> None
    
    match o with
    | Some p ->
        
        {
            ID = ID
            Sort = Sort
            Createdat = Createdat
            Updatedat = Updatedat
            p = p } |> Some
        
    | None -> None

let KUCP_clone src =
    let bb = new BytesBuilder()
    KUCP__bin bb src
    bin__KUCP (bb.bytes(),ref 0)

// [UPROVIDER] Structure


let pUPROVIDER__bin (bb:BytesBuilder) (p:pUPROVIDER) =

    
    let binCaption = p.Caption |> Encoding.UTF8.GetBytes
    binCaption.Length |> BitConverter.GetBytes |> bb.append
    binCaption |> bb.append
    
    let binLogo = p.Logo |> Encoding.UTF8.GetBytes
    binLogo.Length |> BitConverter.GetBytes |> bb.append
    binLogo |> bb.append
    
    let binIcon = p.Icon |> Encoding.UTF8.GetBytes
    binIcon.Length |> BitConverter.GetBytes |> bb.append
    binIcon |> bb.append
    
    p.Cat |> BitConverter.GetBytes |> bb.append

let UPROVIDER__bin (bb:BytesBuilder) (v:UPROVIDER) =
    v.ID |> BitConverter.GetBytes |> bb.append
    v.Sort |> BitConverter.GetBytes |> bb.append
    DateTime__bin bb v.Createdat
    DateTime__bin bb v.Updatedat
    
    pUPROVIDER__bin bb v.p
    ()

let bin__pUPROVIDER (bi:BinIndexed):pUPROVIDER =
    let bin,index = bi

    let p = pUPROVIDER_empty()
    
    let count_Caption = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Caption <- Encoding.UTF8.GetString(bin,index.Value,count_Caption)
    index.Value <- index.Value + count_Caption
    
    let count_Logo = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Logo <- Encoding.UTF8.GetString(bin,index.Value,count_Logo)
    index.Value <- index.Value + count_Logo
    
    let count_Icon = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Icon <- Encoding.UTF8.GetString(bin,index.Value,count_Icon)
    index.Value <- index.Value + count_Icon
    
    p.Cat <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p

let bin__UPROVIDER (bi:BinIndexed):UPROVIDER =
    let bin,index = bi

    let ID = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Sort = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Createdat = bin__DateTime bi
    
    let Updatedat = bin__DateTime bi
    
    {
        ID = ID
        Sort = Sort
        Createdat = Createdat
        Updatedat = Updatedat
        p = bin__pUPROVIDER bi }

let pUPROVIDER__json (p:pUPROVIDER) =

    [|
        ("Caption",p.Caption |> Json.Str)
        ("Logo",p.Logo |> Json.Str)
        ("Icon",p.Icon |> Json.Str)
        ("Cat",p.Cat.ToString() |> Json.Num) |]
    |> Json.Braket

let UPROVIDER__json (v:UPROVIDER) =

    let p = v.p
    
    [|  ("id",v.ID.ToString() |> Json.Num)
        ("sort",v.Sort.ToString() |> Json.Num)
        ("createdat",(v.Createdat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("updatedat",(v.Updatedat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("p",pUPROVIDER__json v.p) |]
    |> Json.Braket

let UPROVIDER__jsonTbw (w:TextBlockWriter) (v:UPROVIDER) =
    json__str w (UPROVIDER__json v)

let UPROVIDER__jsonStr (v:UPROVIDER) =
    (UPROVIDER__json v) |> json__strFinal


let json__pUPROVIDERo (json:Json):pUPROVIDER option =
    let fields = json |> json__items

    let p = pUPROVIDER_empty()
    
    p.Caption <- checkfield fields "Caption"
    
    p.Logo <- checkfield fields "Logo"
    
    p.Icon <- checkfield fields "Icon"
    
    p.Cat <- checkfield fields "Cat" |> parse_int64
    
    p |> Some
    

let json__UPROVIDERo (json:Json):UPROVIDER option =
    let fields = json |> json__items

    let ID = checkfield fields "id" |> parse_int64
    let Sort = checkfield fields "sort" |> parse_int64
    let Createdat = checkfield fields "createdat" |> parse_int64 |> DateTime.FromBinary
    let Updatedat = checkfield fields "updatedat" |> parse_int64 |> DateTime.FromBinary
    
    let o  =
        match
            json
            |> tryFindByAtt "p" with
        | Some (s,v) -> json__pUPROVIDERo v
        | None -> None
    
    match o with
    | Some p ->
        
        {
            ID = ID
            Sort = Sort
            Createdat = Createdat
            Updatedat = Updatedat
            p = p } |> Some
        
    | None -> None

let UPROVIDER_clone src =
    let bb = new BytesBuilder()
    UPROVIDER__bin bb src
    bin__UPROVIDER (bb.bytes(),ref 0)

// [FBIND] Structure


let pFBIND__bin (bb:BytesBuilder) (p:pFBIND) =

    
    p.File |> BitConverter.GetBytes |> bb.append
    
    p.Moment |> BitConverter.GetBytes |> bb.append
    
    let binDesc = p.Desc |> Encoding.UTF8.GetBytes
    binDesc.Length |> BitConverter.GetBytes |> bb.append
    binDesc |> bb.append

let FBIND__bin (bb:BytesBuilder) (v:FBIND) =
    v.ID |> BitConverter.GetBytes |> bb.append
    v.Sort |> BitConverter.GetBytes |> bb.append
    DateTime__bin bb v.Createdat
    DateTime__bin bb v.Updatedat
    
    pFBIND__bin bb v.p
    ()

let bin__pFBIND (bi:BinIndexed):pFBIND =
    let bin,index = bi

    let p = pFBIND_empty()
    
    p.File <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    p.Moment <- BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let count_Desc = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Desc <- Encoding.UTF8.GetString(bin,index.Value,count_Desc)
    index.Value <- index.Value + count_Desc
    
    p

let bin__FBIND (bi:BinIndexed):FBIND =
    let bin,index = bi

    let ID = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Sort = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Createdat = bin__DateTime bi
    
    let Updatedat = bin__DateTime bi
    
    {
        ID = ID
        Sort = Sort
        Createdat = Createdat
        Updatedat = Updatedat
        p = bin__pFBIND bi }

let pFBIND__json (p:pFBIND) =

    [|
        ("File",p.File.ToString() |> Json.Num)
        ("Moment",p.Moment.ToString() |> Json.Num)
        ("Desc",p.Desc |> Json.Str) |]
    |> Json.Braket

let FBIND__json (v:FBIND) =

    let p = v.p
    
    [|  ("id",v.ID.ToString() |> Json.Num)
        ("sort",v.Sort.ToString() |> Json.Num)
        ("createdat",(v.Createdat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("updatedat",(v.Updatedat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("p",pFBIND__json v.p) |]
    |> Json.Braket

let FBIND__jsonTbw (w:TextBlockWriter) (v:FBIND) =
    json__str w (FBIND__json v)

let FBIND__jsonStr (v:FBIND) =
    (FBIND__json v) |> json__strFinal


let json__pFBINDo (json:Json):pFBIND option =
    let fields = json |> json__items

    let p = pFBIND_empty()
    
    p.File <- checkfield fields "File" |> parse_int64
    
    p.Moment <- checkfield fields "Moment" |> parse_int64
    
    p.Desc <- checkfield fields "Desc"
    
    p |> Some
    

let json__FBINDo (json:Json):FBIND option =
    let fields = json |> json__items

    let ID = checkfield fields "id" |> parse_int64
    let Sort = checkfield fields "sort" |> parse_int64
    let Createdat = checkfield fields "createdat" |> parse_int64 |> DateTime.FromBinary
    let Updatedat = checkfield fields "updatedat" |> parse_int64 |> DateTime.FromBinary
    
    let o  =
        match
            json
            |> tryFindByAtt "p" with
        | Some (s,v) -> json__pFBINDo v
        | None -> None
    
    match o with
    | Some p ->
        
        {
            ID = ID
            Sort = Sort
            Createdat = Createdat
            Updatedat = Updatedat
            p = p } |> Some
        
    | None -> None

let FBIND_clone src =
    let bb = new BytesBuilder()
    FBIND__bin bb src
    bin__FBIND (bb.bytes(),ref 0)

// [MOMENT] Structure


let pMOMENT__bin (bb:BytesBuilder) (p:pMOMENT) =

    
    let binTitle = p.Title |> Encoding.UTF8.GetBytes
    binTitle.Length |> BitConverter.GetBytes |> bb.append
    binTitle |> bb.append
    
    let binSummary = p.Summary |> Encoding.UTF8.GetBytes
    binSummary.Length |> BitConverter.GetBytes |> bb.append
    binSummary |> bb.append
    
    let binFullText = p.FullText |> Encoding.UTF8.GetBytes
    binFullText.Length |> BitConverter.GetBytes |> bb.append
    binFullText |> bb.append
    
    let binPreviewImgUrl = p.PreviewImgUrl |> Encoding.UTF8.GetBytes
    binPreviewImgUrl.Length |> BitConverter.GetBytes |> bb.append
    binPreviewImgUrl |> bb.append
    
    let binLink = p.Link |> Encoding.UTF8.GetBytes
    binLink.Length |> BitConverter.GetBytes |> bb.append
    binLink |> bb.append
    
    p.Type |> EnumToValue |> BitConverter.GetBytes |> bb.append
    
    p.State |> EnumToValue |> BitConverter.GetBytes |> bb.append
    
    p.MediaType |> EnumToValue |> BitConverter.GetBytes |> bb.append

let MOMENT__bin (bb:BytesBuilder) (v:MOMENT) =
    v.ID |> BitConverter.GetBytes |> bb.append
    v.Sort |> BitConverter.GetBytes |> bb.append
    DateTime__bin bb v.Createdat
    DateTime__bin bb v.Updatedat
    
    pMOMENT__bin bb v.p
    ()

let bin__pMOMENT (bi:BinIndexed):pMOMENT =
    let bin,index = bi

    let p = pMOMENT_empty()
    
    let count_Title = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Title <- Encoding.UTF8.GetString(bin,index.Value,count_Title)
    index.Value <- index.Value + count_Title
    
    let count_Summary = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Summary <- Encoding.UTF8.GetString(bin,index.Value,count_Summary)
    index.Value <- index.Value + count_Summary
    
    let count_FullText = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.FullText <- Encoding.UTF8.GetString(bin,index.Value,count_FullText)
    index.Value <- index.Value + count_FullText
    
    let count_PreviewImgUrl = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.PreviewImgUrl <- Encoding.UTF8.GetString(bin,index.Value,count_PreviewImgUrl)
    index.Value <- index.Value + count_PreviewImgUrl
    
    let count_Link = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Link <- Encoding.UTF8.GetString(bin,index.Value,count_Link)
    index.Value <- index.Value + count_Link
    
    p.Type <- BitConverter.ToInt32(bin,index.Value) |> EnumOfValue
    index.Value <- index.Value + 4
    
    p.State <- BitConverter.ToInt32(bin,index.Value) |> EnumOfValue
    index.Value <- index.Value + 4
    
    p.MediaType <- BitConverter.ToInt32(bin,index.Value) |> EnumOfValue
    index.Value <- index.Value + 4
    
    p

let bin__MOMENT (bi:BinIndexed):MOMENT =
    let bin,index = bi

    let ID = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Sort = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Createdat = bin__DateTime bi
    
    let Updatedat = bin__DateTime bi
    
    {
        ID = ID
        Sort = Sort
        Createdat = Createdat
        Updatedat = Updatedat
        p = bin__pMOMENT bi }

let pMOMENT__json (p:pMOMENT) =

    [|
        ("Title",p.Title |> Json.Str)
        ("Summary",p.Summary |> Json.Str)
        ("FullText",p.FullText |> Json.Str)
        ("PreviewImgUrl",p.PreviewImgUrl |> Json.Str)
        ("Link",p.Link |> Json.Str)
        ("Type",(p.Type |> EnumToValue).ToString() |> Json.Num)
        ("State",(p.State |> EnumToValue).ToString() |> Json.Num)
        ("MediaType",(p.MediaType |> EnumToValue).ToString() |> Json.Num) |]
    |> Json.Braket

let MOMENT__json (v:MOMENT) =

    let p = v.p
    
    [|  ("id",v.ID.ToString() |> Json.Num)
        ("sort",v.Sort.ToString() |> Json.Num)
        ("createdat",(v.Createdat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("updatedat",(v.Updatedat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("p",pMOMENT__json v.p) |]
    |> Json.Braket

let MOMENT__jsonTbw (w:TextBlockWriter) (v:MOMENT) =
    json__str w (MOMENT__json v)

let MOMENT__jsonStr (v:MOMENT) =
    (MOMENT__json v) |> json__strFinal


let json__pMOMENTo (json:Json):pMOMENT option =
    let fields = json |> json__items

    let p = pMOMENT_empty()
    
    p.Title <- checkfield fields "Title"
    
    p.Summary <- checkfield fields "Summary"
    
    p.FullText <- checkfield fields "FullText"
    
    p.PreviewImgUrl <- checkfield fields "PreviewImgUrl"
    
    p.Link <- checkfield fields "Link"
    
    p.Type <- checkfield fields "Type" |> parse_int32 |> EnumOfValue
    
    p.State <- checkfield fields "State" |> parse_int32 |> EnumOfValue
    
    p.MediaType <- checkfield fields "MediaType" |> parse_int32 |> EnumOfValue
    
    p |> Some
    

let json__MOMENTo (json:Json):MOMENT option =
    let fields = json |> json__items

    let ID = checkfield fields "id" |> parse_int64
    let Sort = checkfield fields "sort" |> parse_int64
    let Createdat = checkfield fields "createdat" |> parse_int64 |> DateTime.FromBinary
    let Updatedat = checkfield fields "updatedat" |> parse_int64 |> DateTime.FromBinary
    
    let o  =
        match
            json
            |> tryFindByAtt "p" with
        | Some (s,v) -> json__pMOMENTo v
        | None -> None
    
    match o with
    | Some p ->
        
        {
            ID = ID
            Sort = Sort
            Createdat = Createdat
            Updatedat = Updatedat
            p = p } |> Some
        
    | None -> None

let MOMENT_clone src =
    let bb = new BytesBuilder()
    MOMENT__bin bb src
    bin__MOMENT (bb.bytes(),ref 0)

// [CONFIG] Structure


let pCONFIG__bin (bb:BytesBuilder) (p:pCONFIG) =

    
    let binKey = p.Key |> Encoding.UTF8.GetBytes
    binKey.Length |> BitConverter.GetBytes |> bb.append
    binKey |> bb.append
    
    let binVal = p.Val |> Encoding.UTF8.GetBytes
    binVal.Length |> BitConverter.GetBytes |> bb.append
    binVal |> bb.append

let CONFIG__bin (bb:BytesBuilder) (v:CONFIG) =
    v.ID |> BitConverter.GetBytes |> bb.append
    v.Sort |> BitConverter.GetBytes |> bb.append
    DateTime__bin bb v.Createdat
    DateTime__bin bb v.Updatedat
    
    pCONFIG__bin bb v.p
    ()

let bin__pCONFIG (bi:BinIndexed):pCONFIG =
    let bin,index = bi

    let p = pCONFIG_empty()
    
    let count_Key = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Key <- Encoding.UTF8.GetString(bin,index.Value,count_Key)
    index.Value <- index.Value + count_Key
    
    let count_Val = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Val <- Encoding.UTF8.GetString(bin,index.Value,count_Val)
    index.Value <- index.Value + count_Val
    
    p

let bin__CONFIG (bi:BinIndexed):CONFIG =
    let bin,index = bi

    let ID = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Sort = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Createdat = bin__DateTime bi
    
    let Updatedat = bin__DateTime bi
    
    {
        ID = ID
        Sort = Sort
        Createdat = Createdat
        Updatedat = Updatedat
        p = bin__pCONFIG bi }

let pCONFIG__json (p:pCONFIG) =

    [|
        ("Key",p.Key |> Json.Str)
        ("Val",p.Val |> Json.Str) |]
    |> Json.Braket

let CONFIG__json (v:CONFIG) =

    let p = v.p
    
    [|  ("id",v.ID.ToString() |> Json.Num)
        ("sort",v.Sort.ToString() |> Json.Num)
        ("createdat",(v.Createdat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("updatedat",(v.Updatedat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("p",pCONFIG__json v.p) |]
    |> Json.Braket

let CONFIG__jsonTbw (w:TextBlockWriter) (v:CONFIG) =
    json__str w (CONFIG__json v)

let CONFIG__jsonStr (v:CONFIG) =
    (CONFIG__json v) |> json__strFinal


let json__pCONFIGo (json:Json):pCONFIG option =
    let fields = json |> json__items

    let p = pCONFIG_empty()
    
    p.Key <- checkfieldz fields "Key" 64
    
    p.Val <- checkfield fields "Val"
    
    p |> Some
    

let json__CONFIGo (json:Json):CONFIG option =
    let fields = json |> json__items

    let ID = checkfield fields "id" |> parse_int64
    let Sort = checkfield fields "sort" |> parse_int64
    let Createdat = checkfield fields "createdat" |> parse_int64 |> DateTime.FromBinary
    let Updatedat = checkfield fields "updatedat" |> parse_int64 |> DateTime.FromBinary
    
    let o  =
        match
            json
            |> tryFindByAtt "p" with
        | Some (s,v) -> json__pCONFIGo v
        | None -> None
    
    match o with
    | Some p ->
        
        {
            ID = ID
            Sort = Sort
            Createdat = Createdat
            Updatedat = Updatedat
            p = p } |> Some
        
    | None -> None

let CONFIG_clone src =
    let bb = new BytesBuilder()
    CONFIG__bin bb src
    bin__CONFIG (bb.bytes(),ref 0)

// [LOG] Structure


let pLOG__bin (bb:BytesBuilder) (p:pLOG) =

    
    let binLocation = p.Location |> Encoding.UTF8.GetBytes
    binLocation.Length |> BitConverter.GetBytes |> bb.append
    binLocation |> bb.append
    
    let binContent = p.Content |> Encoding.UTF8.GetBytes
    binContent.Length |> BitConverter.GetBytes |> bb.append
    binContent |> bb.append
    
    let binSql = p.Sql |> Encoding.UTF8.GetBytes
    binSql.Length |> BitConverter.GetBytes |> bb.append
    binSql |> bb.append

let LOG__bin (bb:BytesBuilder) (v:LOG) =
    v.ID |> BitConverter.GetBytes |> bb.append
    v.Sort |> BitConverter.GetBytes |> bb.append
    DateTime__bin bb v.Createdat
    DateTime__bin bb v.Updatedat
    
    pLOG__bin bb v.p
    ()

let bin__pLOG (bi:BinIndexed):pLOG =
    let bin,index = bi

    let p = pLOG_empty()
    
    let count_Location = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Location <- Encoding.UTF8.GetString(bin,index.Value,count_Location)
    index.Value <- index.Value + count_Location
    
    let count_Content = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Content <- Encoding.UTF8.GetString(bin,index.Value,count_Content)
    index.Value <- index.Value + count_Content
    
    let count_Sql = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Sql <- Encoding.UTF8.GetString(bin,index.Value,count_Sql)
    index.Value <- index.Value + count_Sql
    
    p

let bin__LOG (bi:BinIndexed):LOG =
    let bin,index = bi

    let ID = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Sort = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Createdat = bin__DateTime bi
    
    let Updatedat = bin__DateTime bi
    
    {
        ID = ID
        Sort = Sort
        Createdat = Createdat
        Updatedat = Updatedat
        p = bin__pLOG bi }

let pLOG__json (p:pLOG) =

    [|
        ("Location",p.Location |> Json.Str)
        ("Content",p.Content |> Json.Str)
        ("Sql",p.Sql |> Json.Str) |]
    |> Json.Braket

let LOG__json (v:LOG) =

    let p = v.p
    
    [|  ("id",v.ID.ToString() |> Json.Num)
        ("sort",v.Sort.ToString() |> Json.Num)
        ("createdat",(v.Createdat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("updatedat",(v.Updatedat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("p",pLOG__json v.p) |]
    |> Json.Braket

let LOG__jsonTbw (w:TextBlockWriter) (v:LOG) =
    json__str w (LOG__json v)

let LOG__jsonStr (v:LOG) =
    (LOG__json v) |> json__strFinal


let json__pLOGo (json:Json):pLOG option =
    let fields = json |> json__items

    let p = pLOG_empty()
    
    p.Location <- checkfield fields "Location"
    
    p.Content <- checkfield fields "Content"
    
    p.Sql <- checkfield fields "Sql"
    
    p |> Some
    

let json__LOGo (json:Json):LOG option =
    let fields = json |> json__items

    let ID = checkfield fields "id" |> parse_int64
    let Sort = checkfield fields "sort" |> parse_int64
    let Createdat = checkfield fields "createdat" |> parse_int64 |> DateTime.FromBinary
    let Updatedat = checkfield fields "updatedat" |> parse_int64 |> DateTime.FromBinary
    
    let o  =
        match
            json
            |> tryFindByAtt "p" with
        | Some (s,v) -> json__pLOGo v
        | None -> None
    
    match o with
    | Some p ->
        
        {
            ID = ID
            Sort = Sort
            Createdat = Createdat
            Updatedat = Updatedat
            p = p } |> Some
        
    | None -> None

let LOG_clone src =
    let bb = new BytesBuilder()
    LOG__bin bb src
    bin__LOG (bb.bytes(),ref 0)

// [PLOG] Structure


let pPLOG__bin (bb:BytesBuilder) (p:pPLOG) =

    
    let binIp = p.Ip |> Encoding.UTF8.GetBytes
    binIp.Length |> BitConverter.GetBytes |> bb.append
    binIp |> bb.append
    
    let binRequest = p.Request |> Encoding.UTF8.GetBytes
    binRequest.Length |> BitConverter.GetBytes |> bb.append
    binRequest |> bb.append

let PLOG__bin (bb:BytesBuilder) (v:PLOG) =
    v.ID |> BitConverter.GetBytes |> bb.append
    v.Sort |> BitConverter.GetBytes |> bb.append
    DateTime__bin bb v.Createdat
    DateTime__bin bb v.Updatedat
    
    pPLOG__bin bb v.p
    ()

let bin__pPLOG (bi:BinIndexed):pPLOG =
    let bin,index = bi

    let p = pPLOG_empty()
    
    let count_Ip = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Ip <- Encoding.UTF8.GetString(bin,index.Value,count_Ip)
    index.Value <- index.Value + count_Ip
    
    let count_Request = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Request <- Encoding.UTF8.GetString(bin,index.Value,count_Request)
    index.Value <- index.Value + count_Request
    
    p

let bin__PLOG (bi:BinIndexed):PLOG =
    let bin,index = bi

    let ID = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Sort = BitConverter.ToInt64(bin,index.Value)
    index.Value <- index.Value + 8
    
    let Createdat = bin__DateTime bi
    
    let Updatedat = bin__DateTime bi
    
    {
        ID = ID
        Sort = Sort
        Createdat = Createdat
        Updatedat = Updatedat
        p = bin__pPLOG bi }

let pPLOG__json (p:pPLOG) =

    [|
        ("Ip",p.Ip |> Json.Str)
        ("Request",p.Request |> Json.Str) |]
    |> Json.Braket

let PLOG__json (v:PLOG) =

    let p = v.p
    
    [|  ("id",v.ID.ToString() |> Json.Num)
        ("sort",v.Sort.ToString() |> Json.Num)
        ("createdat",(v.Createdat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("updatedat",(v.Updatedat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("p",pPLOG__json v.p) |]
    |> Json.Braket

let PLOG__jsonTbw (w:TextBlockWriter) (v:PLOG) =
    json__str w (PLOG__json v)

let PLOG__jsonStr (v:PLOG) =
    (PLOG__json v) |> json__strFinal


let json__pPLOGo (json:Json):pPLOG option =
    let fields = json |> json__items

    let p = pPLOG_empty()
    
    p.Ip <- checkfieldz fields "Ip" 64
    
    p.Request <- checkfield fields "Request"
    
    p |> Some
    

let json__PLOGo (json:Json):PLOG option =
    let fields = json |> json__items

    let ID = checkfield fields "id" |> parse_int64
    let Sort = checkfield fields "sort" |> parse_int64
    let Createdat = checkfield fields "createdat" |> parse_int64 |> DateTime.FromBinary
    let Updatedat = checkfield fields "updatedat" |> parse_int64 |> DateTime.FromBinary
    
    let o  =
        match
            json
            |> tryFindByAtt "p" with
        | Some (s,v) -> json__pPLOGo v
        | None -> None
    
    match o with
    | Some p ->
        
        {
            ID = ID
            Sort = Sort
            Createdat = Createdat
            Updatedat = Updatedat
            p = p } |> Some
        
    | None -> None

let PLOG_clone src =
    let bb = new BytesBuilder()
    PLOG__bin bb src
    bin__PLOG (bb.bytes(),ref 0)

let mutable conn = ""

let db__pEU(line:Object[]): pEU =
    let p = pEU_empty()

    p.Caption <- string(line[4]).TrimEnd()
    p.Username <- string(line[5]).TrimEnd()
    p.Email <- string(line[6]).TrimEnd()
    p.Avatar <- string(line[7]).TrimEnd()
    p.OAuthProvider <- string(line[8]).TrimEnd()
    p.ClerkUserID <- string(line[9]).TrimEnd()
    p.Pwd <- string(line[10]).TrimEnd()
    p.AuthType <- EnumOfValue(if Convert.IsDBNull(line[11]) then 0 else line[11] :?> int)

    p

let pEU__sps (p:pEU) =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            ("Caption", p.Caption) |> kvp__sqlparam
            ("Username", p.Username) |> kvp__sqlparam
            ("Email", p.Email) |> kvp__sqlparam
            ("Avatar", p.Avatar) |> kvp__sqlparam
            ("OAuthProvider", p.OAuthProvider) |> kvp__sqlparam
            ("ClerkUserID", p.ClerkUserID) |> kvp__sqlparam
            ("Pwd", p.Pwd) |> kvp__sqlparam
            ("AuthType", EnumToValue p.AuthType) |> kvp__sqlparam |]
    | Rdbms.PostgreSql ->
        [|
            ("caption", p.Caption) |> kvp__sqlparam
            ("username", p.Username) |> kvp__sqlparam
            ("email", p.Email) |> kvp__sqlparam
            ("avatar", p.Avatar) |> kvp__sqlparam
            ("oauthprovider", p.OAuthProvider) |> kvp__sqlparam
            ("clerkuserid", p.ClerkUserID) |> kvp__sqlparam
            ("pwd", p.Pwd) |> kvp__sqlparam
            ("authtype", EnumToValue p.AuthType) |> kvp__sqlparam |]

let db__EU = db__Rcd db__pEU

let EU_wrapper item: EU =
    let (i,c,u,s),p = item
    { ID = i; Createdat = c; Updatedat = u; Sort = s; p = p }

let pEU_clone (p:pEU): pEU = {
    Caption = p.Caption
    Username = p.Username
    Email = p.Email
    Avatar = p.Avatar
    OAuthProvider = p.OAuthProvider
    ClerkUserID = p.ClerkUserID
    Pwd = p.Pwd
    AuthType = p.AuthType }

let EU_update_transaction output (updater,suc,fail) (rcd:EU) =
    let rollback_p = rcd.p |> pEU_clone
    let rollback_updatedat = rcd.Updatedat
    updater rcd.p
    let ctime,res =
        (rcd.ID,rcd.p,rollback_p,rollback_updatedat)
        |> update (conn,output,EU_table,EU_sql_update(),pEU__sps,suc,fail)
    match res with
    | Suc ctx ->
        rcd.Updatedat <- ctime
        suc(ctime,ctx)
    | Fail(eso,ctx) ->
        rcd.p <- rollback_p
        rcd.Updatedat <- rollback_updatedat
        fail eso

let EU_update output (rcd:EU) =
    rcd
    |> EU_update_transaction output ((fun p -> ()),(fun (ctime,ctx) -> ()),(fun dte -> ()))

let EU_create_incremental_transaction output (suc,fail) p =
    let cid = Interlocked.Increment EU_id
    let ctime = DateTime.UtcNow
    match create (conn,output,EU_table,pEU__sps) (cid,ctime,p) with
    | Suc ctx -> ((cid,ctime,ctime,cid),p) |> EU_wrapper |> suc
    | Fail(eso,ctx) -> fail(eso,ctx)

let EU_create output p =
    EU_create_incremental_transaction output ((fun rcd -> ()),(fun (eso,ctx) -> ())) p
    

let id__EUo id: EU option = id__rcd(conn,EU_fieldorders(),EU_table,db__EU) id

let EU_metadata = {
    fieldorders = EU_fieldorders
    db__rcd = db__EU 
    wrapper = EU_wrapper
    sps = pEU__sps
    id = EU_id
    id__rcdo = id__EUo
    clone = pEU_clone
    empty__p = pEU_empty
    rcd__bin = EU__bin
    bin__rcd = bin__EU
    p__json = pEU__json
    json__po = json__pEUo
    rcd__json = EU__json
    json__rcdo = json__EUo
    sql_update = EU_sql_update
    rcd_update = EU_update
    table = EU_table
    shorthand = "eu" }

let EUTxSqlServer =
    """
    IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Ca_EndUser' AND xtype='U')
    BEGIN

        CREATE TABLE Ca_EndUser ([ID] BIGINT NOT NULL
    ,[Createdat] BIGINT NOT NULL
    ,[Updatedat] BIGINT NOT NULL
    ,[Sort] BIGINT NOT NULL,
    ,[Caption]
    ,[Username]
    ,[Email]
    ,[Avatar]
    ,[OAuthProvider]
    ,[ClerkUserID]
    ,[Pwd]
    ,[AuthType])
    END
    """


let db__pFILE(line:Object[]): pFILE =
    let p = pFILE_empty()

    p.Caption <- string(line[4]).TrimEnd()
    p.Path <- string(line[5]).TrimEnd()
    p.State <- EnumOfValue(if Convert.IsDBNull(line[6]) then 0 else line[6] :?> int)
    p.ContentType <- string(line[7]).TrimEnd()
    p.Suffix <- string(line[8]).TrimEnd()
    p.Size <- if Convert.IsDBNull(line[9]) then 0L else line[9] :?> int64
    p.Thumbnail <- if Convert.IsDBNull(line[10]) then [| |] else line[10] :?> byte[]
    p.Owner <- if Convert.IsDBNull(line[11]) then 0L else line[11] :?> int64
    p.Cat <- if Convert.IsDBNull(line[12]) then 0L else line[12] :?> int64
    p.Provider <- if Convert.IsDBNull(line[13]) then 0L else line[13] :?> int64
    p.Unit <- if Convert.IsDBNull(line[14]) then 0L else line[14] :?> int64
    p.Bill <- if Convert.IsDBNull(line[15]) then 0L else line[15] :?> int64

    p

let pFILE__sps (p:pFILE) =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            ("Caption", p.Caption) |> kvp__sqlparam
            ("Path", p.Path) |> kvp__sqlparam
            ("State", EnumToValue p.State) |> kvp__sqlparam
            ("ContentType", p.ContentType) |> kvp__sqlparam
            ("Suffix", p.Suffix) |> kvp__sqlparam
            ("Size", p.Size) |> kvp__sqlparam
            ("Thumbnail", p.Thumbnail) |> kvp__sqlparam
            ("Owner", p.Owner) |> kvp__sqlparam
            ("Cat", p.Cat) |> kvp__sqlparam
            ("Provider", p.Provider) |> kvp__sqlparam
            ("Unit", p.Unit) |> kvp__sqlparam
            ("Bill", p.Bill) |> kvp__sqlparam |]
    | Rdbms.PostgreSql ->
        [|
            ("caption", p.Caption) |> kvp__sqlparam
            ("path", p.Path) |> kvp__sqlparam
            ("state", EnumToValue p.State) |> kvp__sqlparam
            ("contenttype", p.ContentType) |> kvp__sqlparam
            ("suffix", p.Suffix) |> kvp__sqlparam
            ("size", p.Size) |> kvp__sqlparam
            ("thumbnail", p.Thumbnail) |> kvp__sqlparam
            ("owner", p.Owner) |> kvp__sqlparam
            ("cat", p.Cat) |> kvp__sqlparam
            ("provider", p.Provider) |> kvp__sqlparam
            ("unit", p.Unit) |> kvp__sqlparam
            ("bill", p.Bill) |> kvp__sqlparam |]

let db__FILE = db__Rcd db__pFILE

let FILE_wrapper item: FILE =
    let (i,c,u,s),p = item
    { ID = i; Createdat = c; Updatedat = u; Sort = s; p = p }

let pFILE_clone (p:pFILE): pFILE = {
    Caption = p.Caption
    Path = p.Path
    State = p.State
    ContentType = p.ContentType
    Suffix = p.Suffix
    Size = p.Size
    Thumbnail = p.Thumbnail
    Owner = p.Owner
    Cat = p.Cat
    Provider = p.Provider
    Unit = p.Unit
    Bill = p.Bill }

let FILE_update_transaction output (updater,suc,fail) (rcd:FILE) =
    let rollback_p = rcd.p |> pFILE_clone
    let rollback_updatedat = rcd.Updatedat
    updater rcd.p
    let ctime,res =
        (rcd.ID,rcd.p,rollback_p,rollback_updatedat)
        |> update (conn,output,FILE_table,FILE_sql_update(),pFILE__sps,suc,fail)
    match res with
    | Suc ctx ->
        rcd.Updatedat <- ctime
        suc(ctime,ctx)
    | Fail(eso,ctx) ->
        rcd.p <- rollback_p
        rcd.Updatedat <- rollback_updatedat
        fail eso

let FILE_update output (rcd:FILE) =
    rcd
    |> FILE_update_transaction output ((fun p -> ()),(fun (ctime,ctx) -> ()),(fun dte -> ()))

let FILE_create_incremental_transaction output (suc,fail) p =
    let cid = Interlocked.Increment FILE_id
    let ctime = DateTime.UtcNow
    match create (conn,output,FILE_table,pFILE__sps) (cid,ctime,p) with
    | Suc ctx -> ((cid,ctime,ctime,cid),p) |> FILE_wrapper |> suc
    | Fail(eso,ctx) -> fail(eso,ctx)

let FILE_create output p =
    FILE_create_incremental_transaction output ((fun rcd -> ()),(fun (eso,ctx) -> ())) p
    

let id__FILEo id: FILE option = id__rcd(conn,FILE_fieldorders(),FILE_table,db__FILE) id

let FILE_metadata = {
    fieldorders = FILE_fieldorders
    db__rcd = db__FILE 
    wrapper = FILE_wrapper
    sps = pFILE__sps
    id = FILE_id
    id__rcdo = id__FILEo
    clone = pFILE_clone
    empty__p = pFILE_empty
    rcd__bin = FILE__bin
    bin__rcd = bin__FILE
    p__json = pFILE__json
    json__po = json__pFILEo
    rcd__json = FILE__json
    json__rcdo = json__FILEo
    sql_update = FILE_sql_update
    rcd_update = FILE_update
    table = FILE_table
    shorthand = "file" }

let FILETxSqlServer =
    """
    IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Ca_File' AND xtype='U')
    BEGIN

        CREATE TABLE Ca_File ([ID] BIGINT NOT NULL
    ,[Createdat] BIGINT NOT NULL
    ,[Updatedat] BIGINT NOT NULL
    ,[Sort] BIGINT NOT NULL,
    ,[Caption]
    ,[Path]
    ,[State]
    ,[ContentType]
    ,[Suffix]
    ,[Size]
    ,[Thumbnail]
    ,[Owner]
    ,[Cat]
    ,[Provider]
    ,[Unit]
    ,[Bill])
    END
    """


let db__pPOOL(line:Object[]): pPOOL =
    let p = pPOOL_empty()

    p.Cat <- if Convert.IsDBNull(line[4]) then 0L else line[4] :?> int64
    p.Provider <- if Convert.IsDBNull(line[5]) then 0L else line[5] :?> int64
    p.Manager <- if Convert.IsDBNull(line[6]) then 0L else line[6] :?> int64
    p.State <- EnumOfValue(if Convert.IsDBNull(line[7]) then 0 else line[7] :?> int)
    p.Notes <- string(line[8]).TrimEnd()
    p.Amt <- if Convert.IsDBNull(line[9]) then 0.0 else line[9] :?> float
    p.AmtReduction <- if Convert.IsDBNull(line[10]) then 0.0 else line[10] :?> float
    p.AmtReturn <- if Convert.IsDBNull(line[11]) then 0.0 else line[11] :?> float

    p

let pPOOL__sps (p:pPOOL) =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            ("Cat", p.Cat) |> kvp__sqlparam
            ("Provider", p.Provider) |> kvp__sqlparam
            ("Manager", p.Manager) |> kvp__sqlparam
            ("State", EnumToValue p.State) |> kvp__sqlparam
            ("Notes", p.Notes) |> kvp__sqlparam
            ("Amt", p.Amt) |> kvp__sqlparam
            ("AmtReduction", p.AmtReduction) |> kvp__sqlparam
            ("AmtReturn", p.AmtReturn) |> kvp__sqlparam |]
    | Rdbms.PostgreSql ->
        [|
            ("cat", p.Cat) |> kvp__sqlparam
            ("provider", p.Provider) |> kvp__sqlparam
            ("manager", p.Manager) |> kvp__sqlparam
            ("state", EnumToValue p.State) |> kvp__sqlparam
            ("notes", p.Notes) |> kvp__sqlparam
            ("amt", p.Amt) |> kvp__sqlparam
            ("amtreduction", p.AmtReduction) |> kvp__sqlparam
            ("amtreturn", p.AmtReturn) |> kvp__sqlparam |]

let db__POOL = db__Rcd db__pPOOL

let POOL_wrapper item: POOL =
    let (i,c,u,s),p = item
    { ID = i; Createdat = c; Updatedat = u; Sort = s; p = p }

let pPOOL_clone (p:pPOOL): pPOOL = {
    Cat = p.Cat
    Provider = p.Provider
    Manager = p.Manager
    State = p.State
    Notes = p.Notes
    Amt = p.Amt
    AmtReduction = p.AmtReduction
    AmtReturn = p.AmtReturn }

let POOL_update_transaction output (updater,suc,fail) (rcd:POOL) =
    let rollback_p = rcd.p |> pPOOL_clone
    let rollback_updatedat = rcd.Updatedat
    updater rcd.p
    let ctime,res =
        (rcd.ID,rcd.p,rollback_p,rollback_updatedat)
        |> update (conn,output,POOL_table,POOL_sql_update(),pPOOL__sps,suc,fail)
    match res with
    | Suc ctx ->
        rcd.Updatedat <- ctime
        suc(ctime,ctx)
    | Fail(eso,ctx) ->
        rcd.p <- rollback_p
        rcd.Updatedat <- rollback_updatedat
        fail eso

let POOL_update output (rcd:POOL) =
    rcd
    |> POOL_update_transaction output ((fun p -> ()),(fun (ctime,ctx) -> ()),(fun dte -> ()))

let POOL_create_incremental_transaction output (suc,fail) p =
    let cid = Interlocked.Increment POOL_id
    let ctime = DateTime.UtcNow
    match create (conn,output,POOL_table,pPOOL__sps) (cid,ctime,p) with
    | Suc ctx -> ((cid,ctime,ctime,cid),p) |> POOL_wrapper |> suc
    | Fail(eso,ctx) -> fail(eso,ctx)

let POOL_create output p =
    POOL_create_incremental_transaction output ((fun rcd -> ()),(fun (eso,ctx) -> ())) p
    

let id__POOLo id: POOL option = id__rcd(conn,POOL_fieldorders(),POOL_table,db__POOL) id

let POOL_metadata = {
    fieldorders = POOL_fieldorders
    db__rcd = db__POOL 
    wrapper = POOL_wrapper
    sps = pPOOL__sps
    id = POOL_id
    id__rcdo = id__POOLo
    clone = pPOOL_clone
    empty__p = pPOOL_empty
    rcd__bin = POOL__bin
    bin__rcd = bin__POOL
    p__json = pPOOL__json
    json__po = json__pPOOLo
    rcd__json = POOL__json
    json__rcdo = json__POOLo
    sql_update = POOL_sql_update
    rcd_update = POOL_update
    table = POOL_table
    shorthand = "pool" }

let POOLTxSqlServer =
    """
    IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Kernel_Pool' AND xtype='U')
    BEGIN

        CREATE TABLE Kernel_Pool ([ID] BIGINT NOT NULL
    ,[Createdat] BIGINT NOT NULL
    ,[Updatedat] BIGINT NOT NULL
    ,[Sort] BIGINT NOT NULL,
    ,[Cat]
    ,[Provider]
    ,[Manager]
    ,[State]
    ,[Notes]
    ,[Amt]
    ,[AmtReduction]
    ,[AmtReturn])
    END
    """


let db__pUNIT(line:Object[]): pUNIT =
    let p = pUNIT_empty()

    p.Caption <- string(line[4]).TrimEnd()
    p.Owner <- if Convert.IsDBNull(line[5]) then 0L else line[5] :?> int64
    p.UnitNum <- string(line[6]).TrimEnd()
    p.AcctNum <- string(line[7]).TrimEnd()
    p.Address <- string(line[8]).TrimEnd()
    p.Town <- string(line[9]).TrimEnd()
    p.State <- string(line[10]).TrimEnd()
    p.Zip <- string(line[11]).TrimEnd()

    p

let pUNIT__sps (p:pUNIT) =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            ("Caption", p.Caption) |> kvp__sqlparam
            ("Owner", p.Owner) |> kvp__sqlparam
            ("UnitNum", p.UnitNum) |> kvp__sqlparam
            ("AcctNum", p.AcctNum) |> kvp__sqlparam
            ("Address", p.Address) |> kvp__sqlparam
            ("Town", p.Town) |> kvp__sqlparam
            ("State", p.State) |> kvp__sqlparam
            ("Zip", p.Zip) |> kvp__sqlparam |]
    | Rdbms.PostgreSql ->
        [|
            ("caption", p.Caption) |> kvp__sqlparam
            ("owner", p.Owner) |> kvp__sqlparam
            ("unitnum", p.UnitNum) |> kvp__sqlparam
            ("acctnum", p.AcctNum) |> kvp__sqlparam
            ("address", p.Address) |> kvp__sqlparam
            ("town", p.Town) |> kvp__sqlparam
            ("state", p.State) |> kvp__sqlparam
            ("zip", p.Zip) |> kvp__sqlparam |]

let db__UNIT = db__Rcd db__pUNIT

let UNIT_wrapper item: UNIT =
    let (i,c,u,s),p = item
    { ID = i; Createdat = c; Updatedat = u; Sort = s; p = p }

let pUNIT_clone (p:pUNIT): pUNIT = {
    Caption = p.Caption
    Owner = p.Owner
    UnitNum = p.UnitNum
    AcctNum = p.AcctNum
    Address = p.Address
    Town = p.Town
    State = p.State
    Zip = p.Zip }

let UNIT_update_transaction output (updater,suc,fail) (rcd:UNIT) =
    let rollback_p = rcd.p |> pUNIT_clone
    let rollback_updatedat = rcd.Updatedat
    updater rcd.p
    let ctime,res =
        (rcd.ID,rcd.p,rollback_p,rollback_updatedat)
        |> update (conn,output,UNIT_table,UNIT_sql_update(),pUNIT__sps,suc,fail)
    match res with
    | Suc ctx ->
        rcd.Updatedat <- ctime
        suc(ctime,ctx)
    | Fail(eso,ctx) ->
        rcd.p <- rollback_p
        rcd.Updatedat <- rollback_updatedat
        fail eso

let UNIT_update output (rcd:UNIT) =
    rcd
    |> UNIT_update_transaction output ((fun p -> ()),(fun (ctime,ctx) -> ()),(fun dte -> ()))

let UNIT_create_incremental_transaction output (suc,fail) p =
    let cid = Interlocked.Increment UNIT_id
    let ctime = DateTime.UtcNow
    match create (conn,output,UNIT_table,pUNIT__sps) (cid,ctime,p) with
    | Suc ctx -> ((cid,ctime,ctime,cid),p) |> UNIT_wrapper |> suc
    | Fail(eso,ctx) -> fail(eso,ctx)

let UNIT_create output p =
    UNIT_create_incremental_transaction output ((fun rcd -> ()),(fun (eso,ctx) -> ())) p
    

let id__UNITo id: UNIT option = id__rcd(conn,UNIT_fieldorders(),UNIT_table,db__UNIT) id

let UNIT_metadata = {
    fieldorders = UNIT_fieldorders
    db__rcd = db__UNIT 
    wrapper = UNIT_wrapper
    sps = pUNIT__sps
    id = UNIT_id
    id__rcdo = id__UNITo
    clone = pUNIT_clone
    empty__p = pUNIT_empty
    rcd__bin = UNIT__bin
    bin__rcd = bin__UNIT
    p__json = pUNIT__json
    json__po = json__pUNITo
    rcd__json = UNIT__json
    json__rcdo = json__UNITo
    sql_update = UNIT_sql_update
    rcd_update = UNIT_update
    table = UNIT_table
    shorthand = "unit" }

let UNITTxSqlServer =
    """
    IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Kernel_Unit' AND xtype='U')
    BEGIN

        CREATE TABLE Kernel_Unit ([ID] BIGINT NOT NULL
    ,[Createdat] BIGINT NOT NULL
    ,[Updatedat] BIGINT NOT NULL
    ,[Sort] BIGINT NOT NULL,
    ,[Caption]
    ,[Owner]
    ,[UnitNum]
    ,[AcctNum]
    ,[Address]
    ,[Town]
    ,[State]
    ,[Zip])
    END
    """


let db__pUACCT(line:Object[]): pUACCT =
    let p = pUACCT_empty()

    p.Cat <- if Convert.IsDBNull(line[4]) then 0L else line[4] :?> int64
    p.Provider <- if Convert.IsDBNull(line[5]) then 0L else line[5] :?> int64
    p.Owner <- if Convert.IsDBNull(line[6]) then 0L else line[6] :?> int64
    p.Unit <- if Convert.IsDBNull(line[7]) then 0L else line[7] :?> int64
    p.AcctName <- string(line[8]).TrimEnd()
    p.AcctNum <- string(line[9]).TrimEnd()

    p

let pUACCT__sps (p:pUACCT) =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            ("Cat", p.Cat) |> kvp__sqlparam
            ("Provider", p.Provider) |> kvp__sqlparam
            ("Owner", p.Owner) |> kvp__sqlparam
            ("Unit", p.Unit) |> kvp__sqlparam
            ("AcctName", p.AcctName) |> kvp__sqlparam
            ("AcctNum", p.AcctNum) |> kvp__sqlparam |]
    | Rdbms.PostgreSql ->
        [|
            ("cat", p.Cat) |> kvp__sqlparam
            ("provider", p.Provider) |> kvp__sqlparam
            ("owner", p.Owner) |> kvp__sqlparam
            ("unit", p.Unit) |> kvp__sqlparam
            ("acctname", p.AcctName) |> kvp__sqlparam
            ("acctnum", p.AcctNum) |> kvp__sqlparam |]

let db__UACCT = db__Rcd db__pUACCT

let UACCT_wrapper item: UACCT =
    let (i,c,u,s),p = item
    { ID = i; Createdat = c; Updatedat = u; Sort = s; p = p }

let pUACCT_clone (p:pUACCT): pUACCT = {
    Cat = p.Cat
    Provider = p.Provider
    Owner = p.Owner
    Unit = p.Unit
    AcctName = p.AcctName
    AcctNum = p.AcctNum }

let UACCT_update_transaction output (updater,suc,fail) (rcd:UACCT) =
    let rollback_p = rcd.p |> pUACCT_clone
    let rollback_updatedat = rcd.Updatedat
    updater rcd.p
    let ctime,res =
        (rcd.ID,rcd.p,rollback_p,rollback_updatedat)
        |> update (conn,output,UACCT_table,UACCT_sql_update(),pUACCT__sps,suc,fail)
    match res with
    | Suc ctx ->
        rcd.Updatedat <- ctime
        suc(ctime,ctx)
    | Fail(eso,ctx) ->
        rcd.p <- rollback_p
        rcd.Updatedat <- rollback_updatedat
        fail eso

let UACCT_update output (rcd:UACCT) =
    rcd
    |> UACCT_update_transaction output ((fun p -> ()),(fun (ctime,ctx) -> ()),(fun dte -> ()))

let UACCT_create_incremental_transaction output (suc,fail) p =
    let cid = Interlocked.Increment UACCT_id
    let ctime = DateTime.UtcNow
    match create (conn,output,UACCT_table,pUACCT__sps) (cid,ctime,p) with
    | Suc ctx -> ((cid,ctime,ctime,cid),p) |> UACCT_wrapper |> suc
    | Fail(eso,ctx) -> fail(eso,ctx)

let UACCT_create output p =
    UACCT_create_incremental_transaction output ((fun rcd -> ()),(fun (eso,ctx) -> ())) p
    

let id__UACCTo id: UACCT option = id__rcd(conn,UACCT_fieldorders(),UACCT_table,db__UACCT) id

let UACCT_metadata = {
    fieldorders = UACCT_fieldorders
    db__rcd = db__UACCT 
    wrapper = UACCT_wrapper
    sps = pUACCT__sps
    id = UACCT_id
    id__rcdo = id__UACCTo
    clone = pUACCT_clone
    empty__p = pUACCT_empty
    rcd__bin = UACCT__bin
    bin__rcd = bin__UACCT
    p__json = pUACCT__json
    json__po = json__pUACCTo
    rcd__json = UACCT__json
    json__rcdo = json__UACCTo
    sql_update = UACCT_sql_update
    rcd_update = UACCT_update
    table = UACCT_table
    shorthand = "uacct" }

let UACCTTxSqlServer =
    """
    IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Kernel_UtilAcct' AND xtype='U')
    BEGIN

        CREATE TABLE Kernel_UtilAcct ([ID] BIGINT NOT NULL
    ,[Createdat] BIGINT NOT NULL
    ,[Updatedat] BIGINT NOT NULL
    ,[Sort] BIGINT NOT NULL,
    ,[Cat]
    ,[Provider]
    ,[Owner]
    ,[Unit]
    ,[AcctName]
    ,[AcctNum])
    END
    """


let db__pUBILL(line:Object[]): pUBILL =
    let p = pUBILL_empty()

    p.Cat <- if Convert.IsDBNull(line[4]) then 0L else line[4] :?> int64
    p.Provider <- if Convert.IsDBNull(line[5]) then 0L else line[5] :?> int64
    p.Owner <- if Convert.IsDBNull(line[6]) then 0L else line[6] :?> int64
    p.Representative <- if Convert.IsDBNull(line[7]) then 0L else line[7] :?> int64
    p.Unit <- if Convert.IsDBNull(line[8]) then 0L else line[8] :?> int64
    p.State <- EnumOfValue(if Convert.IsDBNull(line[9]) then 0 else line[9] :?> int)
    p.UAcct <- if Convert.IsDBNull(line[10]) then 0L else line[10] :?> int64
    p.Pool <- if Convert.IsDBNull(line[11]) then 0L else line[11] :?> int64
    p.YYYYMMDD <- string(line[12]).TrimEnd()
    p.Amt <- if Convert.IsDBNull(line[13]) then 0.0 else line[13] :?> float
    p.AmtReduction <- if Convert.IsDBNull(line[14]) then 0.0 else line[14] :?> float
    p.AmtReturn <- if Convert.IsDBNull(line[15]) then 0.0 else line[15] :?> float

    p

let pUBILL__sps (p:pUBILL) =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            ("Cat", p.Cat) |> kvp__sqlparam
            ("Provider", p.Provider) |> kvp__sqlparam
            ("Owner", p.Owner) |> kvp__sqlparam
            ("Representative", p.Representative) |> kvp__sqlparam
            ("Unit", p.Unit) |> kvp__sqlparam
            ("State", EnumToValue p.State) |> kvp__sqlparam
            ("UAcct", p.UAcct) |> kvp__sqlparam
            ("Pool", p.Pool) |> kvp__sqlparam
            ("YYYYMMDD", p.YYYYMMDD) |> kvp__sqlparam
            ("Amt", p.Amt) |> kvp__sqlparam
            ("AmtReduction", p.AmtReduction) |> kvp__sqlparam
            ("AmtReturn", p.AmtReturn) |> kvp__sqlparam |]
    | Rdbms.PostgreSql ->
        [|
            ("cat", p.Cat) |> kvp__sqlparam
            ("provider", p.Provider) |> kvp__sqlparam
            ("owner", p.Owner) |> kvp__sqlparam
            ("representative", p.Representative) |> kvp__sqlparam
            ("unit", p.Unit) |> kvp__sqlparam
            ("state", EnumToValue p.State) |> kvp__sqlparam
            ("uacct", p.UAcct) |> kvp__sqlparam
            ("pool", p.Pool) |> kvp__sqlparam
            ("yyyymmdd", p.YYYYMMDD) |> kvp__sqlparam
            ("amt", p.Amt) |> kvp__sqlparam
            ("amtreduction", p.AmtReduction) |> kvp__sqlparam
            ("amtreturn", p.AmtReturn) |> kvp__sqlparam |]

let db__UBILL = db__Rcd db__pUBILL

let UBILL_wrapper item: UBILL =
    let (i,c,u,s),p = item
    { ID = i; Createdat = c; Updatedat = u; Sort = s; p = p }

let pUBILL_clone (p:pUBILL): pUBILL = {
    Cat = p.Cat
    Provider = p.Provider
    Owner = p.Owner
    Representative = p.Representative
    Unit = p.Unit
    State = p.State
    UAcct = p.UAcct
    Pool = p.Pool
    YYYYMMDD = p.YYYYMMDD
    Amt = p.Amt
    AmtReduction = p.AmtReduction
    AmtReturn = p.AmtReturn }

let UBILL_update_transaction output (updater,suc,fail) (rcd:UBILL) =
    let rollback_p = rcd.p |> pUBILL_clone
    let rollback_updatedat = rcd.Updatedat
    updater rcd.p
    let ctime,res =
        (rcd.ID,rcd.p,rollback_p,rollback_updatedat)
        |> update (conn,output,UBILL_table,UBILL_sql_update(),pUBILL__sps,suc,fail)
    match res with
    | Suc ctx ->
        rcd.Updatedat <- ctime
        suc(ctime,ctx)
    | Fail(eso,ctx) ->
        rcd.p <- rollback_p
        rcd.Updatedat <- rollback_updatedat
        fail eso

let UBILL_update output (rcd:UBILL) =
    rcd
    |> UBILL_update_transaction output ((fun p -> ()),(fun (ctime,ctx) -> ()),(fun dte -> ()))

let UBILL_create_incremental_transaction output (suc,fail) p =
    let cid = Interlocked.Increment UBILL_id
    let ctime = DateTime.UtcNow
    match create (conn,output,UBILL_table,pUBILL__sps) (cid,ctime,p) with
    | Suc ctx -> ((cid,ctime,ctime,cid),p) |> UBILL_wrapper |> suc
    | Fail(eso,ctx) -> fail(eso,ctx)

let UBILL_create output p =
    UBILL_create_incremental_transaction output ((fun rcd -> ()),(fun (eso,ctx) -> ())) p
    

let id__UBILLo id: UBILL option = id__rcd(conn,UBILL_fieldorders(),UBILL_table,db__UBILL) id

let UBILL_metadata = {
    fieldorders = UBILL_fieldorders
    db__rcd = db__UBILL 
    wrapper = UBILL_wrapper
    sps = pUBILL__sps
    id = UBILL_id
    id__rcdo = id__UBILLo
    clone = pUBILL_clone
    empty__p = pUBILL_empty
    rcd__bin = UBILL__bin
    bin__rcd = bin__UBILL
    p__json = pUBILL__json
    json__po = json__pUBILLo
    rcd__json = UBILL__json
    json__rcdo = json__UBILLo
    sql_update = UBILL_sql_update
    rcd_update = UBILL_update
    table = UBILL_table
    shorthand = "ubill" }

let UBILLTxSqlServer =
    """
    IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Kernel_UtilBill' AND xtype='U')
    BEGIN

        CREATE TABLE Kernel_UtilBill ([ID] BIGINT NOT NULL
    ,[Createdat] BIGINT NOT NULL
    ,[Updatedat] BIGINT NOT NULL
    ,[Sort] BIGINT NOT NULL,
    ,[Cat]
    ,[Provider]
    ,[Owner]
    ,[Representative]
    ,[Unit]
    ,[State]
    ,[UAcct]
    ,[Pool]
    ,[YYYYMMDD]
    ,[Amt]
    ,[AmtReduction]
    ,[AmtReturn])
    END
    """


let db__pUCAT(line:Object[]): pUCAT =
    let p = pUCAT_empty()

    p.Caption <- string(line[4]).TrimEnd()

    p

let pUCAT__sps (p:pUCAT) =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            ("Caption", p.Caption) |> kvp__sqlparam |]
    | Rdbms.PostgreSql ->
        [|
            ("caption", p.Caption) |> kvp__sqlparam |]

let db__UCAT = db__Rcd db__pUCAT

let UCAT_wrapper item: UCAT =
    let (i,c,u,s),p = item
    { ID = i; Createdat = c; Updatedat = u; Sort = s; p = p }

let pUCAT_clone (p:pUCAT): pUCAT = {
    Caption = p.Caption }

let UCAT_update_transaction output (updater,suc,fail) (rcd:UCAT) =
    let rollback_p = rcd.p |> pUCAT_clone
    let rollback_updatedat = rcd.Updatedat
    updater rcd.p
    let ctime,res =
        (rcd.ID,rcd.p,rollback_p,rollback_updatedat)
        |> update (conn,output,UCAT_table,UCAT_sql_update(),pUCAT__sps,suc,fail)
    match res with
    | Suc ctx ->
        rcd.Updatedat <- ctime
        suc(ctime,ctx)
    | Fail(eso,ctx) ->
        rcd.p <- rollback_p
        rcd.Updatedat <- rollback_updatedat
        fail eso

let UCAT_update output (rcd:UCAT) =
    rcd
    |> UCAT_update_transaction output ((fun p -> ()),(fun (ctime,ctx) -> ()),(fun dte -> ()))

let UCAT_create_incremental_transaction output (suc,fail) p =
    let cid = Interlocked.Increment UCAT_id
    let ctime = DateTime.UtcNow
    match create (conn,output,UCAT_table,pUCAT__sps) (cid,ctime,p) with
    | Suc ctx -> ((cid,ctime,ctime,cid),p) |> UCAT_wrapper |> suc
    | Fail(eso,ctx) -> fail(eso,ctx)

let UCAT_create output p =
    UCAT_create_incremental_transaction output ((fun rcd -> ()),(fun (eso,ctx) -> ())) p
    

let id__UCATo id: UCAT option = id__rcd(conn,UCAT_fieldorders(),UCAT_table,db__UCAT) id

let UCAT_metadata = {
    fieldorders = UCAT_fieldorders
    db__rcd = db__UCAT 
    wrapper = UCAT_wrapper
    sps = pUCAT__sps
    id = UCAT_id
    id__rcdo = id__UCATo
    clone = pUCAT_clone
    empty__p = pUCAT_empty
    rcd__bin = UCAT__bin
    bin__rcd = bin__UCAT
    p__json = pUCAT__json
    json__po = json__pUCATo
    rcd__json = UCAT__json
    json__rcdo = json__UCATo
    sql_update = UCAT_sql_update
    rcd_update = UCAT_update
    table = UCAT_table
    shorthand = "ucat" }

let UCATTxSqlServer =
    """
    IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Kernel_UtilCat' AND xtype='U')
    BEGIN

        CREATE TABLE Kernel_UtilCat ([ID] BIGINT NOT NULL
    ,[Createdat] BIGINT NOT NULL
    ,[Updatedat] BIGINT NOT NULL
    ,[Sort] BIGINT NOT NULL,
    ,[Caption])
    END
    """


let db__pKUCP(line:Object[]): pKUCP =
    let p = pKUCP_empty()

    p.Cat <- if Convert.IsDBNull(line[4]) then 0L else line[4] :?> int64
    p.Provider <- if Convert.IsDBNull(line[5]) then 0L else line[5] :?> int64

    p

let pKUCP__sps (p:pKUCP) =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            ("Cat", p.Cat) |> kvp__sqlparam
            ("Provider", p.Provider) |> kvp__sqlparam |]
    | Rdbms.PostgreSql ->
        [|
            ("cat", p.Cat) |> kvp__sqlparam
            ("provider", p.Provider) |> kvp__sqlparam |]

let db__KUCP = db__Rcd db__pKUCP

let KUCP_wrapper item: KUCP =
    let (i,c,u,s),p = item
    { ID = i; Createdat = c; Updatedat = u; Sort = s; p = p }

let pKUCP_clone (p:pKUCP): pKUCP = {
    Cat = p.Cat
    Provider = p.Provider }

let KUCP_update_transaction output (updater,suc,fail) (rcd:KUCP) =
    let rollback_p = rcd.p |> pKUCP_clone
    let rollback_updatedat = rcd.Updatedat
    updater rcd.p
    let ctime,res =
        (rcd.ID,rcd.p,rollback_p,rollback_updatedat)
        |> update (conn,output,KUCP_table,KUCP_sql_update(),pKUCP__sps,suc,fail)
    match res with
    | Suc ctx ->
        rcd.Updatedat <- ctime
        suc(ctime,ctx)
    | Fail(eso,ctx) ->
        rcd.p <- rollback_p
        rcd.Updatedat <- rollback_updatedat
        fail eso

let KUCP_update output (rcd:KUCP) =
    rcd
    |> KUCP_update_transaction output ((fun p -> ()),(fun (ctime,ctx) -> ()),(fun dte -> ()))

let KUCP_create_incremental_transaction output (suc,fail) p =
    let cid = Interlocked.Increment KUCP_id
    let ctime = DateTime.UtcNow
    match create (conn,output,KUCP_table,pKUCP__sps) (cid,ctime,p) with
    | Suc ctx -> ((cid,ctime,ctime,cid),p) |> KUCP_wrapper |> suc
    | Fail(eso,ctx) -> fail(eso,ctx)

let KUCP_create output p =
    KUCP_create_incremental_transaction output ((fun rcd -> ()),(fun (eso,ctx) -> ())) p
    

let id__KUCPo id: KUCP option = id__rcd(conn,KUCP_fieldorders(),KUCP_table,db__KUCP) id

let KUCP_metadata = {
    fieldorders = KUCP_fieldorders
    db__rcd = db__KUCP 
    wrapper = KUCP_wrapper
    sps = pKUCP__sps
    id = KUCP_id
    id__rcdo = id__KUCPo
    clone = pKUCP_clone
    empty__p = pKUCP_empty
    rcd__bin = KUCP__bin
    bin__rcd = bin__KUCP
    p__json = pKUCP__json
    json__po = json__pKUCPo
    rcd__json = KUCP__json
    json__rcdo = json__KUCPo
    sql_update = KUCP_sql_update
    rcd_update = KUCP_update
    table = KUCP_table
    shorthand = "kucp" }

let KUCPTxSqlServer =
    """
    IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Kernel_UtilCatProvider' AND xtype='U')
    BEGIN

        CREATE TABLE Kernel_UtilCatProvider ([ID] BIGINT NOT NULL
    ,[Createdat] BIGINT NOT NULL
    ,[Updatedat] BIGINT NOT NULL
    ,[Sort] BIGINT NOT NULL,
    ,[Cat]
    ,[Provider])
    END
    """


let db__pUPROVIDER(line:Object[]): pUPROVIDER =
    let p = pUPROVIDER_empty()

    p.Caption <- string(line[4]).TrimEnd()
    p.Logo <- string(line[5]).TrimEnd()
    p.Icon <- string(line[6]).TrimEnd()
    p.Cat <- if Convert.IsDBNull(line[7]) then 0L else line[7] :?> int64

    p

let pUPROVIDER__sps (p:pUPROVIDER) =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            ("Caption", p.Caption) |> kvp__sqlparam
            ("Logo", p.Logo) |> kvp__sqlparam
            ("Icon", p.Icon) |> kvp__sqlparam
            ("Cat", p.Cat) |> kvp__sqlparam |]
    | Rdbms.PostgreSql ->
        [|
            ("caption", p.Caption) |> kvp__sqlparam
            ("logo", p.Logo) |> kvp__sqlparam
            ("icon", p.Icon) |> kvp__sqlparam
            ("cat", p.Cat) |> kvp__sqlparam |]

let db__UPROVIDER = db__Rcd db__pUPROVIDER

let UPROVIDER_wrapper item: UPROVIDER =
    let (i,c,u,s),p = item
    { ID = i; Createdat = c; Updatedat = u; Sort = s; p = p }

let pUPROVIDER_clone (p:pUPROVIDER): pUPROVIDER = {
    Caption = p.Caption
    Logo = p.Logo
    Icon = p.Icon
    Cat = p.Cat }

let UPROVIDER_update_transaction output (updater,suc,fail) (rcd:UPROVIDER) =
    let rollback_p = rcd.p |> pUPROVIDER_clone
    let rollback_updatedat = rcd.Updatedat
    updater rcd.p
    let ctime,res =
        (rcd.ID,rcd.p,rollback_p,rollback_updatedat)
        |> update (conn,output,UPROVIDER_table,UPROVIDER_sql_update(),pUPROVIDER__sps,suc,fail)
    match res with
    | Suc ctx ->
        rcd.Updatedat <- ctime
        suc(ctime,ctx)
    | Fail(eso,ctx) ->
        rcd.p <- rollback_p
        rcd.Updatedat <- rollback_updatedat
        fail eso

let UPROVIDER_update output (rcd:UPROVIDER) =
    rcd
    |> UPROVIDER_update_transaction output ((fun p -> ()),(fun (ctime,ctx) -> ()),(fun dte -> ()))

let UPROVIDER_create_incremental_transaction output (suc,fail) p =
    let cid = Interlocked.Increment UPROVIDER_id
    let ctime = DateTime.UtcNow
    match create (conn,output,UPROVIDER_table,pUPROVIDER__sps) (cid,ctime,p) with
    | Suc ctx -> ((cid,ctime,ctime,cid),p) |> UPROVIDER_wrapper |> suc
    | Fail(eso,ctx) -> fail(eso,ctx)

let UPROVIDER_create output p =
    UPROVIDER_create_incremental_transaction output ((fun rcd -> ()),(fun (eso,ctx) -> ())) p
    

let id__UPROVIDERo id: UPROVIDER option = id__rcd(conn,UPROVIDER_fieldorders(),UPROVIDER_table,db__UPROVIDER) id

let UPROVIDER_metadata = {
    fieldorders = UPROVIDER_fieldorders
    db__rcd = db__UPROVIDER 
    wrapper = UPROVIDER_wrapper
    sps = pUPROVIDER__sps
    id = UPROVIDER_id
    id__rcdo = id__UPROVIDERo
    clone = pUPROVIDER_clone
    empty__p = pUPROVIDER_empty
    rcd__bin = UPROVIDER__bin
    bin__rcd = bin__UPROVIDER
    p__json = pUPROVIDER__json
    json__po = json__pUPROVIDERo
    rcd__json = UPROVIDER__json
    json__rcdo = json__UPROVIDERo
    sql_update = UPROVIDER_sql_update
    rcd_update = UPROVIDER_update
    table = UPROVIDER_table
    shorthand = "uprovider" }

let UPROVIDERTxSqlServer =
    """
    IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Kernel_UtilProvider' AND xtype='U')
    BEGIN

        CREATE TABLE Kernel_UtilProvider ([ID] BIGINT NOT NULL
    ,[Createdat] BIGINT NOT NULL
    ,[Updatedat] BIGINT NOT NULL
    ,[Sort] BIGINT NOT NULL,
    ,[Caption]
    ,[Logo]
    ,[Icon]
    ,[Cat])
    END
    """


let db__pFBIND(line:Object[]): pFBIND =
    let p = pFBIND_empty()

    p.File <- if Convert.IsDBNull(line[4]) then 0L else line[4] :?> int64
    p.Moment <- if Convert.IsDBNull(line[5]) then 0L else line[5] :?> int64
    p.Desc <- string(line[6]).TrimEnd()

    p

let pFBIND__sps (p:pFBIND) =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            ("File", p.File) |> kvp__sqlparam
            ("Moment", p.Moment) |> kvp__sqlparam
            ("Desc", p.Desc) |> kvp__sqlparam |]
    | Rdbms.PostgreSql ->
        [|
            ("file", p.File) |> kvp__sqlparam
            ("moment", p.Moment) |> kvp__sqlparam
            ("desc", p.Desc) |> kvp__sqlparam |]

let db__FBIND = db__Rcd db__pFBIND

let FBIND_wrapper item: FBIND =
    let (i,c,u,s),p = item
    { ID = i; Createdat = c; Updatedat = u; Sort = s; p = p }

let pFBIND_clone (p:pFBIND): pFBIND = {
    File = p.File
    Moment = p.Moment
    Desc = p.Desc }

let FBIND_update_transaction output (updater,suc,fail) (rcd:FBIND) =
    let rollback_p = rcd.p |> pFBIND_clone
    let rollback_updatedat = rcd.Updatedat
    updater rcd.p
    let ctime,res =
        (rcd.ID,rcd.p,rollback_p,rollback_updatedat)
        |> update (conn,output,FBIND_table,FBIND_sql_update(),pFBIND__sps,suc,fail)
    match res with
    | Suc ctx ->
        rcd.Updatedat <- ctime
        suc(ctime,ctx)
    | Fail(eso,ctx) ->
        rcd.p <- rollback_p
        rcd.Updatedat <- rollback_updatedat
        fail eso

let FBIND_update output (rcd:FBIND) =
    rcd
    |> FBIND_update_transaction output ((fun p -> ()),(fun (ctime,ctx) -> ()),(fun dte -> ()))

let FBIND_create_incremental_transaction output (suc,fail) p =
    let cid = Interlocked.Increment FBIND_id
    let ctime = DateTime.UtcNow
    match create (conn,output,FBIND_table,pFBIND__sps) (cid,ctime,p) with
    | Suc ctx -> ((cid,ctime,ctime,cid),p) |> FBIND_wrapper |> suc
    | Fail(eso,ctx) -> fail(eso,ctx)

let FBIND_create output p =
    FBIND_create_incremental_transaction output ((fun rcd -> ()),(fun (eso,ctx) -> ())) p
    

let id__FBINDo id: FBIND option = id__rcd(conn,FBIND_fieldorders(),FBIND_table,db__FBIND) id

let FBIND_metadata = {
    fieldorders = FBIND_fieldorders
    db__rcd = db__FBIND 
    wrapper = FBIND_wrapper
    sps = pFBIND__sps
    id = FBIND_id
    id__rcdo = id__FBINDo
    clone = pFBIND_clone
    empty__p = pFBIND_empty
    rcd__bin = FBIND__bin
    bin__rcd = bin__FBIND
    p__json = pFBIND__json
    json__po = json__pFBINDo
    rcd__json = FBIND__json
    json__rcdo = json__FBINDo
    sql_update = FBIND_sql_update
    rcd_update = FBIND_update
    table = FBIND_table
    shorthand = "fbind" }

let FBINDTxSqlServer =
    """
    IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Social_FileBind' AND xtype='U')
    BEGIN

        CREATE TABLE Social_FileBind ([ID] BIGINT NOT NULL
    ,[Createdat] BIGINT NOT NULL
    ,[Updatedat] BIGINT NOT NULL
    ,[Sort] BIGINT NOT NULL,
    ,[File]
    ,[Moment]
    ,[Desc])
    END
    """


let db__pMOMENT(line:Object[]): pMOMENT =
    let p = pMOMENT_empty()

    p.Title <- string(line[4]).TrimEnd()
    p.Summary <- string(line[5]).TrimEnd()
    p.FullText <- string(line[6]).TrimEnd()
    p.PreviewImgUrl <- string(line[7]).TrimEnd()
    p.Link <- string(line[8]).TrimEnd()
    p.Type <- EnumOfValue(if Convert.IsDBNull(line[9]) then 0 else line[9] :?> int)
    p.State <- EnumOfValue(if Convert.IsDBNull(line[10]) then 0 else line[10] :?> int)
    p.MediaType <- EnumOfValue(if Convert.IsDBNull(line[11]) then 0 else line[11] :?> int)

    p

let pMOMENT__sps (p:pMOMENT) =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            ("Title", p.Title) |> kvp__sqlparam
            ("Summary", p.Summary) |> kvp__sqlparam
            ("FullText", p.FullText) |> kvp__sqlparam
            ("PreviewImgUrl", p.PreviewImgUrl) |> kvp__sqlparam
            ("Link", p.Link) |> kvp__sqlparam
            ("Type", EnumToValue p.Type) |> kvp__sqlparam
            ("State", EnumToValue p.State) |> kvp__sqlparam
            ("MediaType", EnumToValue p.MediaType) |> kvp__sqlparam |]
    | Rdbms.PostgreSql ->
        [|
            ("title", p.Title) |> kvp__sqlparam
            ("summary", p.Summary) |> kvp__sqlparam
            ("fulltext", p.FullText) |> kvp__sqlparam
            ("previewimgurl", p.PreviewImgUrl) |> kvp__sqlparam
            ("link", p.Link) |> kvp__sqlparam
            ("type", EnumToValue p.Type) |> kvp__sqlparam
            ("state", EnumToValue p.State) |> kvp__sqlparam
            ("mediatype", EnumToValue p.MediaType) |> kvp__sqlparam |]

let db__MOMENT = db__Rcd db__pMOMENT

let MOMENT_wrapper item: MOMENT =
    let (i,c,u,s),p = item
    { ID = i; Createdat = c; Updatedat = u; Sort = s; p = p }

let pMOMENT_clone (p:pMOMENT): pMOMENT = {
    Title = p.Title
    Summary = p.Summary
    FullText = p.FullText
    PreviewImgUrl = p.PreviewImgUrl
    Link = p.Link
    Type = p.Type
    State = p.State
    MediaType = p.MediaType }

let MOMENT_update_transaction output (updater,suc,fail) (rcd:MOMENT) =
    let rollback_p = rcd.p |> pMOMENT_clone
    let rollback_updatedat = rcd.Updatedat
    updater rcd.p
    let ctime,res =
        (rcd.ID,rcd.p,rollback_p,rollback_updatedat)
        |> update (conn,output,MOMENT_table,MOMENT_sql_update(),pMOMENT__sps,suc,fail)
    match res with
    | Suc ctx ->
        rcd.Updatedat <- ctime
        suc(ctime,ctx)
    | Fail(eso,ctx) ->
        rcd.p <- rollback_p
        rcd.Updatedat <- rollback_updatedat
        fail eso

let MOMENT_update output (rcd:MOMENT) =
    rcd
    |> MOMENT_update_transaction output ((fun p -> ()),(fun (ctime,ctx) -> ()),(fun dte -> ()))

let MOMENT_create_incremental_transaction output (suc,fail) p =
    let cid = Interlocked.Increment MOMENT_id
    let ctime = DateTime.UtcNow
    match create (conn,output,MOMENT_table,pMOMENT__sps) (cid,ctime,p) with
    | Suc ctx -> ((cid,ctime,ctime,cid),p) |> MOMENT_wrapper |> suc
    | Fail(eso,ctx) -> fail(eso,ctx)

let MOMENT_create output p =
    MOMENT_create_incremental_transaction output ((fun rcd -> ()),(fun (eso,ctx) -> ())) p
    

let id__MOMENTo id: MOMENT option = id__rcd(conn,MOMENT_fieldorders(),MOMENT_table,db__MOMENT) id

let MOMENT_metadata = {
    fieldorders = MOMENT_fieldorders
    db__rcd = db__MOMENT 
    wrapper = MOMENT_wrapper
    sps = pMOMENT__sps
    id = MOMENT_id
    id__rcdo = id__MOMENTo
    clone = pMOMENT_clone
    empty__p = pMOMENT_empty
    rcd__bin = MOMENT__bin
    bin__rcd = bin__MOMENT
    p__json = pMOMENT__json
    json__po = json__pMOMENTo
    rcd__json = MOMENT__json
    json__rcdo = json__MOMENTo
    sql_update = MOMENT_sql_update
    rcd_update = MOMENT_update
    table = MOMENT_table
    shorthand = "moment" }

let MOMENTTxSqlServer =
    """
    IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Social_Moment' AND xtype='U')
    BEGIN

        CREATE TABLE Social_Moment ([ID] BIGINT NOT NULL
    ,[Createdat] BIGINT NOT NULL
    ,[Updatedat] BIGINT NOT NULL
    ,[Sort] BIGINT NOT NULL,
    ,[Title]
    ,[Summary]
    ,[FullText]
    ,[PreviewImgUrl]
    ,[Link]
    ,[Type]
    ,[State]
    ,[MediaType])
    END
    """


let db__pCONFIG(line:Object[]): pCONFIG =
    let p = pCONFIG_empty()

    p.Key <- string(line[4]).TrimEnd()
    p.Val <- string(line[5]).TrimEnd()

    p

let pCONFIG__sps (p:pCONFIG) =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            ("Key", p.Key) |> kvp__sqlparam
            ("Val", p.Val) |> kvp__sqlparam |]
    | Rdbms.PostgreSql ->
        [|
            ("key", p.Key) |> kvp__sqlparam
            ("val", p.Val) |> kvp__sqlparam |]

let db__CONFIG = db__Rcd db__pCONFIG

let CONFIG_wrapper item: CONFIG =
    let (i,c,u,s),p = item
    { ID = i; Createdat = c; Updatedat = u; Sort = s; p = p }

let pCONFIG_clone (p:pCONFIG): pCONFIG = {
    Key = p.Key
    Val = p.Val }

let CONFIG_update_transaction output (updater,suc,fail) (rcd:CONFIG) =
    let rollback_p = rcd.p |> pCONFIG_clone
    let rollback_updatedat = rcd.Updatedat
    updater rcd.p
    let ctime,res =
        (rcd.ID,rcd.p,rollback_p,rollback_updatedat)
        |> update (conn,output,CONFIG_table,CONFIG_sql_update(),pCONFIG__sps,suc,fail)
    match res with
    | Suc ctx ->
        rcd.Updatedat <- ctime
        suc(ctime,ctx)
    | Fail(eso,ctx) ->
        rcd.p <- rollback_p
        rcd.Updatedat <- rollback_updatedat
        fail eso

let CONFIG_update output (rcd:CONFIG) =
    rcd
    |> CONFIG_update_transaction output ((fun p -> ()),(fun (ctime,ctx) -> ()),(fun dte -> ()))

let CONFIG_create_incremental_transaction output (suc,fail) p =
    let cid = Interlocked.Increment CONFIG_id
    let ctime = DateTime.UtcNow
    match create (conn,output,CONFIG_table,pCONFIG__sps) (cid,ctime,p) with
    | Suc ctx -> ((cid,ctime,ctime,cid),p) |> CONFIG_wrapper |> suc
    | Fail(eso,ctx) -> fail(eso,ctx)

let CONFIG_create output p =
    CONFIG_create_incremental_transaction output ((fun rcd -> ()),(fun (eso,ctx) -> ())) p
    

let id__CONFIGo id: CONFIG option = id__rcd(conn,CONFIG_fieldorders(),CONFIG_table,db__CONFIG) id

let CONFIG_metadata = {
    fieldorders = CONFIG_fieldorders
    db__rcd = db__CONFIG 
    wrapper = CONFIG_wrapper
    sps = pCONFIG__sps
    id = CONFIG_id
    id__rcdo = id__CONFIGo
    clone = pCONFIG_clone
    empty__p = pCONFIG_empty
    rcd__bin = CONFIG__bin
    bin__rcd = bin__CONFIG
    p__json = pCONFIG__json
    json__po = json__pCONFIGo
    rcd__json = CONFIG__json
    json__rcdo = json__CONFIGo
    sql_update = CONFIG_sql_update
    rcd_update = CONFIG_update
    table = CONFIG_table
    shorthand = "config" }

let CONFIGTxSqlServer =
    """
    IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Sys_Config' AND xtype='U')
    BEGIN

        CREATE TABLE Sys_Config ([ID] BIGINT NOT NULL
    ,[Createdat] BIGINT NOT NULL
    ,[Updatedat] BIGINT NOT NULL
    ,[Sort] BIGINT NOT NULL,
    ,[Key]
    ,[Val])
    END
    """


let db__pLOG(line:Object[]): pLOG =
    let p = pLOG_empty()

    p.Location <- string(line[4]).TrimEnd()
    p.Content <- string(line[5]).TrimEnd()
    p.Sql <- string(line[6]).TrimEnd()

    p

let pLOG__sps (p:pLOG) =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            ("Location", p.Location) |> kvp__sqlparam
            ("Content", p.Content) |> kvp__sqlparam
            ("Sql", p.Sql) |> kvp__sqlparam |]
    | Rdbms.PostgreSql ->
        [|
            ("location", p.Location) |> kvp__sqlparam
            ("content", p.Content) |> kvp__sqlparam
            ("sql", p.Sql) |> kvp__sqlparam |]

let db__LOG = db__Rcd db__pLOG

let LOG_wrapper item: LOG =
    let (i,c,u,s),p = item
    { ID = i; Createdat = c; Updatedat = u; Sort = s; p = p }

let pLOG_clone (p:pLOG): pLOG = {
    Location = p.Location
    Content = p.Content
    Sql = p.Sql }

let LOG_update_transaction output (updater,suc,fail) (rcd:LOG) =
    let rollback_p = rcd.p |> pLOG_clone
    let rollback_updatedat = rcd.Updatedat
    updater rcd.p
    let ctime,res =
        (rcd.ID,rcd.p,rollback_p,rollback_updatedat)
        |> update (conn,output,LOG_table,LOG_sql_update(),pLOG__sps,suc,fail)
    match res with
    | Suc ctx ->
        rcd.Updatedat <- ctime
        suc(ctime,ctx)
    | Fail(eso,ctx) ->
        rcd.p <- rollback_p
        rcd.Updatedat <- rollback_updatedat
        fail eso

let LOG_update output (rcd:LOG) =
    rcd
    |> LOG_update_transaction output ((fun p -> ()),(fun (ctime,ctx) -> ()),(fun dte -> ()))

let LOG_create_incremental_transaction output (suc,fail) p =
    let cid = Interlocked.Increment LOG_id
    let ctime = DateTime.UtcNow
    match create (conn,output,LOG_table,pLOG__sps) (cid,ctime,p) with
    | Suc ctx -> ((cid,ctime,ctime,cid),p) |> LOG_wrapper |> suc
    | Fail(eso,ctx) -> fail(eso,ctx)

let LOG_create output p =
    LOG_create_incremental_transaction output ((fun rcd -> ()),(fun (eso,ctx) -> ())) p
    

let id__LOGo id: LOG option = id__rcd(conn,LOG_fieldorders(),LOG_table,db__LOG) id

let LOG_metadata = {
    fieldorders = LOG_fieldorders
    db__rcd = db__LOG 
    wrapper = LOG_wrapper
    sps = pLOG__sps
    id = LOG_id
    id__rcdo = id__LOGo
    clone = pLOG_clone
    empty__p = pLOG_empty
    rcd__bin = LOG__bin
    bin__rcd = bin__LOG
    p__json = pLOG__json
    json__po = json__pLOGo
    rcd__json = LOG__json
    json__rcdo = json__LOGo
    sql_update = LOG_sql_update
    rcd_update = LOG_update
    table = LOG_table
    shorthand = "log" }

let LOGTxSqlServer =
    """
    IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Sys_Log' AND xtype='U')
    BEGIN

        CREATE TABLE Sys_Log ([ID] BIGINT NOT NULL
    ,[Createdat] BIGINT NOT NULL
    ,[Updatedat] BIGINT NOT NULL
    ,[Sort] BIGINT NOT NULL,
    ,[Location]
    ,[Content]
    ,[Sql])
    END
    """


let db__pPLOG(line:Object[]): pPLOG =
    let p = pPLOG_empty()

    p.Ip <- string(line[4]).TrimEnd()
    p.Request <- string(line[5]).TrimEnd()

    p

let pPLOG__sps (p:pPLOG) =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            ("Ip", p.Ip) |> kvp__sqlparam
            ("Request", p.Request) |> kvp__sqlparam |]
    | Rdbms.PostgreSql ->
        [|
            ("ip", p.Ip) |> kvp__sqlparam
            ("request", p.Request) |> kvp__sqlparam |]

let db__PLOG = db__Rcd db__pPLOG

let PLOG_wrapper item: PLOG =
    let (i,c,u,s),p = item
    { ID = i; Createdat = c; Updatedat = u; Sort = s; p = p }

let pPLOG_clone (p:pPLOG): pPLOG = {
    Ip = p.Ip
    Request = p.Request }

let PLOG_update_transaction output (updater,suc,fail) (rcd:PLOG) =
    let rollback_p = rcd.p |> pPLOG_clone
    let rollback_updatedat = rcd.Updatedat
    updater rcd.p
    let ctime,res =
        (rcd.ID,rcd.p,rollback_p,rollback_updatedat)
        |> update (conn,output,PLOG_table,PLOG_sql_update(),pPLOG__sps,suc,fail)
    match res with
    | Suc ctx ->
        rcd.Updatedat <- ctime
        suc(ctime,ctx)
    | Fail(eso,ctx) ->
        rcd.p <- rollback_p
        rcd.Updatedat <- rollback_updatedat
        fail eso

let PLOG_update output (rcd:PLOG) =
    rcd
    |> PLOG_update_transaction output ((fun p -> ()),(fun (ctime,ctx) -> ()),(fun dte -> ()))

let PLOG_create_incremental_transaction output (suc,fail) p =
    let cid = Interlocked.Increment PLOG_id
    let ctime = DateTime.UtcNow
    match create (conn,output,PLOG_table,pPLOG__sps) (cid,ctime,p) with
    | Suc ctx -> ((cid,ctime,ctime,cid),p) |> PLOG_wrapper |> suc
    | Fail(eso,ctx) -> fail(eso,ctx)

let PLOG_create output p =
    PLOG_create_incremental_transaction output ((fun rcd -> ()),(fun (eso,ctx) -> ())) p
    

let id__PLOGo id: PLOG option = id__rcd(conn,PLOG_fieldorders(),PLOG_table,db__PLOG) id

let PLOG_metadata = {
    fieldorders = PLOG_fieldorders
    db__rcd = db__PLOG 
    wrapper = PLOG_wrapper
    sps = pPLOG__sps
    id = PLOG_id
    id__rcdo = id__PLOGo
    clone = pPLOG_clone
    empty__p = pPLOG_empty
    rcd__bin = PLOG__bin
    bin__rcd = bin__PLOG
    p__json = pPLOG__json
    json__po = json__pPLOGo
    rcd__json = PLOG__json
    json__rcdo = json__PLOGo
    sql_update = PLOG_sql_update
    rcd_update = PLOG_update
    table = PLOG_table
    shorthand = "plog" }

let PLOGTxSqlServer =
    """
    IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Sys_PageLog' AND xtype='U')
    BEGIN

        CREATE TABLE Sys_PageLog ([ID] BIGINT NOT NULL
    ,[Createdat] BIGINT NOT NULL
    ,[Updatedat] BIGINT NOT NULL
    ,[Sort] BIGINT NOT NULL,
    ,[Ip]
    ,[Request])
    END
    """


type MetadataEnum = 
| EU = 0
| FILE = 1
| POOL = 2
| UNIT = 3
| UACCT = 4
| UBILL = 5
| UCAT = 6
| KUCP = 7
| UPROVIDER = 8
| FBIND = 9
| MOMENT = 10
| CONFIG = 11
| LOG = 12
| PLOG = 13

let tablenames = [|
    EU_metadata.table
    FILE_metadata.table
    POOL_metadata.table
    UNIT_metadata.table
    UACCT_metadata.table
    UBILL_metadata.table
    UCAT_metadata.table
    KUCP_metadata.table
    UPROVIDER_metadata.table
    FBIND_metadata.table
    MOMENT_metadata.table
    CONFIG_metadata.table
    LOG_metadata.table
    PLOG_metadata.table |]

let init() =

    let sqlMaxCa_EndUser, sqlCountCa_EndUser =
        match rdbms with
        | Rdbms.SqlServer -> "SELECT MAX(ID) FROM [Ca_EndUser]", "SELECT COUNT(ID) FROM [Ca_EndUser]"
        | Rdbms.PostgreSql -> "SELECT MAX(id) FROM ca_enduser", "SELECT COUNT(id) FROM ca_enduser"
    match singlevalue_query conn (str__sql sqlMaxCa_EndUser) with
    | Some v ->
        let max = v :?> int64
        if max > EU_id.Value then
            EU_id.Value <- max
    | None -> ()

    match singlevalue_query conn (str__sql sqlCountCa_EndUser) with
    | Some v ->
        EU_count.Value <-
            match rdbms with
            | Rdbms.SqlServer -> v :?> int32
            | Rdbms.PostgreSql -> v :?> int64 |> int32
    | None -> ()

    let sqlMaxCa_File, sqlCountCa_File =
        match rdbms with
        | Rdbms.SqlServer -> "SELECT MAX(ID) FROM [Ca_File]", "SELECT COUNT(ID) FROM [Ca_File]"
        | Rdbms.PostgreSql -> "SELECT MAX(id) FROM ca_file", "SELECT COUNT(id) FROM ca_file"
    match singlevalue_query conn (str__sql sqlMaxCa_File) with
    | Some v ->
        let max = v :?> int64
        if max > FILE_id.Value then
            FILE_id.Value <- max
    | None -> ()

    match singlevalue_query conn (str__sql sqlCountCa_File) with
    | Some v ->
        FILE_count.Value <-
            match rdbms with
            | Rdbms.SqlServer -> v :?> int32
            | Rdbms.PostgreSql -> v :?> int64 |> int32
    | None -> ()

    let sqlMaxKernel_Pool, sqlCountKernel_Pool =
        match rdbms with
        | Rdbms.SqlServer -> "SELECT MAX(ID) FROM [Kernel_Pool]", "SELECT COUNT(ID) FROM [Kernel_Pool]"
        | Rdbms.PostgreSql -> "SELECT MAX(id) FROM kernel_pool", "SELECT COUNT(id) FROM kernel_pool"
    match singlevalue_query conn (str__sql sqlMaxKernel_Pool) with
    | Some v ->
        let max = v :?> int64
        if max > POOL_id.Value then
            POOL_id.Value <- max
    | None -> ()

    match singlevalue_query conn (str__sql sqlCountKernel_Pool) with
    | Some v ->
        POOL_count.Value <-
            match rdbms with
            | Rdbms.SqlServer -> v :?> int32
            | Rdbms.PostgreSql -> v :?> int64 |> int32
    | None -> ()

    let sqlMaxKernel_Unit, sqlCountKernel_Unit =
        match rdbms with
        | Rdbms.SqlServer -> "SELECT MAX(ID) FROM [Kernel_Unit]", "SELECT COUNT(ID) FROM [Kernel_Unit]"
        | Rdbms.PostgreSql -> "SELECT MAX(id) FROM kernel_unit", "SELECT COUNT(id) FROM kernel_unit"
    match singlevalue_query conn (str__sql sqlMaxKernel_Unit) with
    | Some v ->
        let max = v :?> int64
        if max > UNIT_id.Value then
            UNIT_id.Value <- max
    | None -> ()

    match singlevalue_query conn (str__sql sqlCountKernel_Unit) with
    | Some v ->
        UNIT_count.Value <-
            match rdbms with
            | Rdbms.SqlServer -> v :?> int32
            | Rdbms.PostgreSql -> v :?> int64 |> int32
    | None -> ()

    let sqlMaxKernel_UtilAcct, sqlCountKernel_UtilAcct =
        match rdbms with
        | Rdbms.SqlServer -> "SELECT MAX(ID) FROM [Kernel_UtilAcct]", "SELECT COUNT(ID) FROM [Kernel_UtilAcct]"
        | Rdbms.PostgreSql -> "SELECT MAX(id) FROM kernel_utilacct", "SELECT COUNT(id) FROM kernel_utilacct"
    match singlevalue_query conn (str__sql sqlMaxKernel_UtilAcct) with
    | Some v ->
        let max = v :?> int64
        if max > UACCT_id.Value then
            UACCT_id.Value <- max
    | None -> ()

    match singlevalue_query conn (str__sql sqlCountKernel_UtilAcct) with
    | Some v ->
        UACCT_count.Value <-
            match rdbms with
            | Rdbms.SqlServer -> v :?> int32
            | Rdbms.PostgreSql -> v :?> int64 |> int32
    | None -> ()

    let sqlMaxKernel_UtilBill, sqlCountKernel_UtilBill =
        match rdbms with
        | Rdbms.SqlServer -> "SELECT MAX(ID) FROM [Kernel_UtilBill]", "SELECT COUNT(ID) FROM [Kernel_UtilBill]"
        | Rdbms.PostgreSql -> "SELECT MAX(id) FROM kernel_utilbill", "SELECT COUNT(id) FROM kernel_utilbill"
    match singlevalue_query conn (str__sql sqlMaxKernel_UtilBill) with
    | Some v ->
        let max = v :?> int64
        if max > UBILL_id.Value then
            UBILL_id.Value <- max
    | None -> ()

    match singlevalue_query conn (str__sql sqlCountKernel_UtilBill) with
    | Some v ->
        UBILL_count.Value <-
            match rdbms with
            | Rdbms.SqlServer -> v :?> int32
            | Rdbms.PostgreSql -> v :?> int64 |> int32
    | None -> ()

    let sqlMaxKernel_UtilCat, sqlCountKernel_UtilCat =
        match rdbms with
        | Rdbms.SqlServer -> "SELECT MAX(ID) FROM [Kernel_UtilCat]", "SELECT COUNT(ID) FROM [Kernel_UtilCat]"
        | Rdbms.PostgreSql -> "SELECT MAX(id) FROM kernel_utilcat", "SELECT COUNT(id) FROM kernel_utilcat"
    match singlevalue_query conn (str__sql sqlMaxKernel_UtilCat) with
    | Some v ->
        let max = v :?> int64
        if max > UCAT_id.Value then
            UCAT_id.Value <- max
    | None -> ()

    match singlevalue_query conn (str__sql sqlCountKernel_UtilCat) with
    | Some v ->
        UCAT_count.Value <-
            match rdbms with
            | Rdbms.SqlServer -> v :?> int32
            | Rdbms.PostgreSql -> v :?> int64 |> int32
    | None -> ()

    let sqlMaxKernel_UtilCatProvider, sqlCountKernel_UtilCatProvider =
        match rdbms with
        | Rdbms.SqlServer -> "SELECT MAX(ID) FROM [Kernel_UtilCatProvider]", "SELECT COUNT(ID) FROM [Kernel_UtilCatProvider]"
        | Rdbms.PostgreSql -> "SELECT MAX(id) FROM kernel_utilcatprovider", "SELECT COUNT(id) FROM kernel_utilcatprovider"
    match singlevalue_query conn (str__sql sqlMaxKernel_UtilCatProvider) with
    | Some v ->
        let max = v :?> int64
        if max > KUCP_id.Value then
            KUCP_id.Value <- max
    | None -> ()

    match singlevalue_query conn (str__sql sqlCountKernel_UtilCatProvider) with
    | Some v ->
        KUCP_count.Value <-
            match rdbms with
            | Rdbms.SqlServer -> v :?> int32
            | Rdbms.PostgreSql -> v :?> int64 |> int32
    | None -> ()

    let sqlMaxKernel_UtilProvider, sqlCountKernel_UtilProvider =
        match rdbms with
        | Rdbms.SqlServer -> "SELECT MAX(ID) FROM [Kernel_UtilProvider]", "SELECT COUNT(ID) FROM [Kernel_UtilProvider]"
        | Rdbms.PostgreSql -> "SELECT MAX(id) FROM kernel_utilprovider", "SELECT COUNT(id) FROM kernel_utilprovider"
    match singlevalue_query conn (str__sql sqlMaxKernel_UtilProvider) with
    | Some v ->
        let max = v :?> int64
        if max > UPROVIDER_id.Value then
            UPROVIDER_id.Value <- max
    | None -> ()

    match singlevalue_query conn (str__sql sqlCountKernel_UtilProvider) with
    | Some v ->
        UPROVIDER_count.Value <-
            match rdbms with
            | Rdbms.SqlServer -> v :?> int32
            | Rdbms.PostgreSql -> v :?> int64 |> int32
    | None -> ()

    let sqlMaxSocial_FileBind, sqlCountSocial_FileBind =
        match rdbms with
        | Rdbms.SqlServer -> "SELECT MAX(ID) FROM [Social_FileBind]", "SELECT COUNT(ID) FROM [Social_FileBind]"
        | Rdbms.PostgreSql -> "SELECT MAX(id) FROM social_filebind", "SELECT COUNT(id) FROM social_filebind"
    match singlevalue_query conn (str__sql sqlMaxSocial_FileBind) with
    | Some v ->
        let max = v :?> int64
        if max > FBIND_id.Value then
            FBIND_id.Value <- max
    | None -> ()

    match singlevalue_query conn (str__sql sqlCountSocial_FileBind) with
    | Some v ->
        FBIND_count.Value <-
            match rdbms with
            | Rdbms.SqlServer -> v :?> int32
            | Rdbms.PostgreSql -> v :?> int64 |> int32
    | None -> ()

    let sqlMaxSocial_Moment, sqlCountSocial_Moment =
        match rdbms with
        | Rdbms.SqlServer -> "SELECT MAX(ID) FROM [Social_Moment]", "SELECT COUNT(ID) FROM [Social_Moment]"
        | Rdbms.PostgreSql -> "SELECT MAX(id) FROM social_moment", "SELECT COUNT(id) FROM social_moment"
    match singlevalue_query conn (str__sql sqlMaxSocial_Moment) with
    | Some v ->
        let max = v :?> int64
        if max > MOMENT_id.Value then
            MOMENT_id.Value <- max
    | None -> ()

    match singlevalue_query conn (str__sql sqlCountSocial_Moment) with
    | Some v ->
        MOMENT_count.Value <-
            match rdbms with
            | Rdbms.SqlServer -> v :?> int32
            | Rdbms.PostgreSql -> v :?> int64 |> int32
    | None -> ()

    let sqlMaxSys_Config, sqlCountSys_Config =
        match rdbms with
        | Rdbms.SqlServer -> "SELECT MAX(ID) FROM [Sys_Config]", "SELECT COUNT(ID) FROM [Sys_Config]"
        | Rdbms.PostgreSql -> "SELECT MAX(id) FROM sys_config", "SELECT COUNT(id) FROM sys_config"
    match singlevalue_query conn (str__sql sqlMaxSys_Config) with
    | Some v ->
        let max = v :?> int64
        if max > CONFIG_id.Value then
            CONFIG_id.Value <- max
    | None -> ()

    match singlevalue_query conn (str__sql sqlCountSys_Config) with
    | Some v ->
        CONFIG_count.Value <-
            match rdbms with
            | Rdbms.SqlServer -> v :?> int32
            | Rdbms.PostgreSql -> v :?> int64 |> int32
    | None -> ()

    let sqlMaxSys_Log, sqlCountSys_Log =
        match rdbms with
        | Rdbms.SqlServer -> "SELECT MAX(ID) FROM [Sys_Log]", "SELECT COUNT(ID) FROM [Sys_Log]"
        | Rdbms.PostgreSql -> "SELECT MAX(id) FROM sys_log", "SELECT COUNT(id) FROM sys_log"
    match singlevalue_query conn (str__sql sqlMaxSys_Log) with
    | Some v ->
        let max = v :?> int64
        if max > LOG_id.Value then
            LOG_id.Value <- max
    | None -> ()

    match singlevalue_query conn (str__sql sqlCountSys_Log) with
    | Some v ->
        LOG_count.Value <-
            match rdbms with
            | Rdbms.SqlServer -> v :?> int32
            | Rdbms.PostgreSql -> v :?> int64 |> int32
    | None -> ()

    let sqlMaxSys_PageLog, sqlCountSys_PageLog =
        match rdbms with
        | Rdbms.SqlServer -> "SELECT MAX(ID) FROM [Sys_PageLog]", "SELECT COUNT(ID) FROM [Sys_PageLog]"
        | Rdbms.PostgreSql -> "SELECT MAX(id) FROM sys_pagelog", "SELECT COUNT(id) FROM sys_pagelog"
    match singlevalue_query conn (str__sql sqlMaxSys_PageLog) with
    | Some v ->
        let max = v :?> int64
        if max > PLOG_id.Value then
            PLOG_id.Value <- max
    | None -> ()

    match singlevalue_query conn (str__sql sqlCountSys_PageLog) with
    | Some v ->
        PLOG_count.Value <-
            match rdbms with
            | Rdbms.SqlServer -> v :?> int32
            | Rdbms.PostgreSql -> v :?> int64 |> int32
    | None -> ()
    ()