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
open Util.Stat

open PreOrm

open System.Data.SqlClient
open System.Threading
open Util.Bin
open WYI.Shared.OrmTypes
open WYI.Shared.Types

// [BOOK] Structure


let pBOOK__bin (bb:BytesBuilder) (p:pBOOK) =

    
    let binCaption = p.Caption |> Encoding.UTF8.GetBytes
    binCaption.Length |> BitConverter.GetBytes |> bb.append
    binCaption |> bb.append
    
    let binEmail = p.Email |> Encoding.UTF8.GetBytes
    binEmail.Length |> BitConverter.GetBytes |> bb.append
    binEmail |> bb.append
    
    let binMessage = p.Message |> Encoding.UTF8.GetBytes
    binMessage.Length |> BitConverter.GetBytes |> bb.append
    binMessage |> bb.append

let BOOK__bin (bb:BytesBuilder) (v:BOOK) =
    v.ID |> BitConverter.GetBytes |> bb.append
    v.Sort |> BitConverter.GetBytes |> bb.append
    DateTime__bin bb v.Createdat
    DateTime__bin bb v.Updatedat
    
    pBOOK__bin bb v.p

let bin__pBOOK (bi:BinIndexed):pBOOK =
    let bin,index = bi

    let p = pBOOK_empty()
    
    let count_Caption = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Caption <- Encoding.UTF8.GetString(bin,index.Value,count_Caption)
    index.Value <- index.Value + count_Caption
    
    let count_Email = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Email <- Encoding.UTF8.GetString(bin,index.Value,count_Email)
    index.Value <- index.Value + count_Email
    
    let count_Message = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Message <- Encoding.UTF8.GetString(bin,index.Value,count_Message)
    index.Value <- index.Value + count_Message
    
    p

let bin__BOOK (bi:BinIndexed):BOOK =
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
        p = bin__pBOOK bi }

let pBOOK__json (p:pBOOK) =

    [|
        ("Caption",p.Caption |> Json.Str)
        ("Email",p.Email |> Json.Str)
        ("Message",p.Message |> Json.Str) |]
    |> Json.Braket

let BOOK__json (v:BOOK) =

    let p = v.p
    
    [|  ("id",v.ID.ToString() |> Json.Num)
        ("sort",v.Sort.ToString() |> Json.Num)
        ("createdat",(v.Createdat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("updatedat",(v.Updatedat |> Util.Time.wintime__unixtime).ToString() |> Json.Num)
        ("p",pBOOK__json v.p) |]
    |> Json.Braket

let BOOK__jsonTbw (w:TextBlockWriter) (v:BOOK) =
    json__str w (BOOK__json v)

let BOOK__jsonStr (v:BOOK) =
    (BOOK__json v) |> json__strFinal


let json__pBOOKo (json:Json):pBOOK option =
    let fields = json |> json__items

    let p = pBOOK_empty()
    
    p.Caption <- checkfieldz fields "Caption" 64
    
    p.Email <- checkfieldz fields "Email" 64
    
    p.Message <- checkfield fields "Message"
    
    p |> Some
    

let json__BOOKo (json:Json):BOOK option =
    let fields = json |> json__items

    let ID = checkfield fields "id" |> parse_int64
    let Sort = checkfield fields "sort" |> parse_int64
    let Createdat = checkfield fields "createdat" |> parse_int64 |> DateTime.FromBinary
    let Updatedat = checkfield fields "updatedat" |> parse_int64 |> DateTime.FromBinary
    
    let o  =
        match
            json
            |> tryFindByAtt "p" with
        | Some (s,v) -> json__pBOOKo v
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

let BOOK_clone src =
    let bb = new BytesBuilder()
    BOOK__bin bb src
    bin__BOOK (bb.bytes(),ref 0)

// [EU] Structure


let pEU__bin (bb:BytesBuilder) (p:pEU) =

    
    let binCaption = p.Caption |> Encoding.UTF8.GetBytes
    binCaption.Length |> BitConverter.GetBytes |> bb.append
    binCaption |> bb.append
    
    p.AuthType |> EnumToValue |> BitConverter.GetBytes |> bb.append

let EU__bin (bb:BytesBuilder) (v:EU) =
    v.ID |> BitConverter.GetBytes |> bb.append
    v.Sort |> BitConverter.GetBytes |> bb.append
    DateTime__bin bb v.Createdat
    DateTime__bin bb v.Updatedat
    
    pEU__bin bb v.p

let bin__pEU (bi:BinIndexed):pEU =
    let bin,index = bi

    let p = pEU_empty()
    
    let count_Caption = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Caption <- Encoding.UTF8.GetString(bin,index.Value,count_Caption)
    index.Value <- index.Value + count_Caption
    
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
    
    let binDesc = p.Desc |> Encoding.UTF8.GetBytes
    binDesc.Length |> BitConverter.GetBytes |> bb.append
    binDesc |> bb.append
    
    let binSuffix = p.Suffix |> Encoding.UTF8.GetBytes
    binSuffix.Length |> BitConverter.GetBytes |> bb.append
    binSuffix |> bb.append
    
    p.Size |> BitConverter.GetBytes |> bb.append
    
    p.Thumbnail.Length |> BitConverter.GetBytes |> bb.append
    p.Thumbnail |> bb.append
    
    p.Owner |> BitConverter.GetBytes |> bb.append

let FILE__bin (bb:BytesBuilder) (v:FILE) =
    v.ID |> BitConverter.GetBytes |> bb.append
    v.Sort |> BitConverter.GetBytes |> bb.append
    DateTime__bin bb v.Createdat
    DateTime__bin bb v.Updatedat
    
    pFILE__bin bb v.p

let bin__pFILE (bi:BinIndexed):pFILE =
    let bin,index = bi

    let p = pFILE_empty()
    
    let count_Caption = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Caption <- Encoding.UTF8.GetString(bin,index.Value,count_Caption)
    index.Value <- index.Value + count_Caption
    
    let count_Desc = BitConverter.ToInt32(bin,index.Value)
    index.Value <- index.Value + 4
    p.Desc <- Encoding.UTF8.GetString(bin,index.Value,count_Desc)
    index.Value <- index.Value + count_Desc
    
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
        ("Desc",p.Desc |> Json.Str)
        ("Suffix",p.Suffix |> Json.Str)
        ("Size",p.Size.ToString() |> Json.Num)
        ("Thumbnail",p.Thumbnail |> Convert.ToBase64String |> Json.Str)
        ("Owner",p.Owner.ToString() |> Json.Num) |]
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
    
    p.Desc <- checkfield fields "Desc"
    
    p.Suffix <- checkfieldz fields "Suffix" 4
    
    p.Size <- checkfield fields "Size" |> parse_int64
    
    p.Owner <- checkfield fields "Owner" |> parse_int64
    
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

let db__pBOOK(line:Object[]): pBOOK =
    let p = pBOOK_empty()

    p.Caption <- string(line[4]).TrimEnd()
    p.Email <- string(line[5]).TrimEnd()
    p.Message <- string(line[6]).TrimEnd()

    p

let pBOOK__sps (p:pBOOK) =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            ("Caption", p.Caption) |> kvp__sqlparam
            ("Email", p.Email) |> kvp__sqlparam
            ("Message", p.Message) |> kvp__sqlparam |]
    | Rdbms.PostgreSql ->
        [|
            ("caption", p.Caption) |> kvp__sqlparam
            ("email", p.Email) |> kvp__sqlparam
            ("message", p.Message) |> kvp__sqlparam |]

let db__BOOK = db__Rcd db__pBOOK

let BOOK_wrapper item: BOOK =
    let (i,c,u,s),p = item
    { ID = i; Createdat = c; Updatedat = u; Sort = s; p = p }

let pBOOK_clone (p:pBOOK): pBOOK = {
    Caption = p.Caption
    Email = p.Email
    Message = p.Message }

let BOOK_update_transaction output (updater,suc,fail) (rcd:BOOK) =
    let rollback_p = rcd.p |> pBOOK_clone
    let rollback_updatedat = rcd.Updatedat
    updater rcd.p
    let ctime,res =
        (rcd.ID,rcd.p,rollback_p,rollback_updatedat)
        |> update (conn,output,BOOK_table,BOOK_sql_update(),pBOOK__sps,suc,fail)
    match res with
    | Suc ctx ->
        rcd.Updatedat <- ctime
        suc(ctime,ctx)
    | Fail(eso,ctx) ->
        rcd.p <- rollback_p
        rcd.Updatedat <- rollback_updatedat
        fail eso

let BOOK_update output (rcd:BOOK) =
    rcd
    |> BOOK_update_transaction output ((fun p -> ()),(fun (ctime,ctx) -> ()),(fun dte -> ()))

let BOOK_create_incremental_transaction output (suc,fail) p =
    let cid = Interlocked.Increment BOOK_id
    let ctime = DateTime.UtcNow
    match create (conn,output,BOOK_table,pBOOK__sps) (cid,ctime,p) with
    | Suc ctx -> ((cid,ctime,ctime,cid),p) |> BOOK_wrapper |> suc
    | Fail(eso,ctx) -> fail(eso,ctx)

let BOOK_create output p =
    BOOK_create_incremental_transaction output ((fun rcd -> ()),(fun (eso,ctx) -> ())) p
    

let id__BOOKo id: BOOK option = id__rcd(conn,BOOK_fieldorders(),BOOK_table,db__BOOK) id

let BOOK_metadata = {
    fieldorders = BOOK_fieldorders
    db__rcd = db__BOOK 
    wrapper = BOOK_wrapper
    sps = pBOOK__sps
    id = BOOK_id
    id__rcdo = id__BOOKo
    clone = pBOOK_clone
    empty__p = pBOOK_empty
    rcd__bin = BOOK__bin
    bin__rcd = bin__BOOK
    p__json = pBOOK__json
    json__po = json__pBOOKo
    rcd__json = BOOK__json
    json__rcdo = json__BOOKo
    sql_update = BOOK_sql_update
    rcd_update = BOOK_update
    table = BOOK_table
    shorthand = "book" }

let BOOKTxSqlServer =
    """
    IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Ca_Book' AND xtype='U')
    BEGIN

        CREATE TABLE Ca_Book ([ID] BIGINT NOT NULL
    ,[Createdat] BIGINT NOT NULL
    ,[Updatedat] BIGINT NOT NULL
    ,[Sort] BIGINT NOT NULL,
    ,[Caption]
    ,[Email]
    ,[Message])
    END
    """


let db__pEU(line:Object[]): pEU =
    let p = pEU_empty()

    p.Caption <- string(line[4]).TrimEnd()
    p.AuthType <- EnumOfValue(if Convert.IsDBNull(line[5]) then 0 else line[5] :?> int)

    p

let pEU__sps (p:pEU) =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            ("Caption", p.Caption) |> kvp__sqlparam
            ("AuthType", p.AuthType) |> kvp__sqlparam |]
    | Rdbms.PostgreSql ->
        [|
            ("caption", p.Caption) |> kvp__sqlparam
            ("authtype", p.AuthType) |> kvp__sqlparam |]

let db__EU = db__Rcd db__pEU

let EU_wrapper item: EU =
    let (i,c,u,s),p = item
    { ID = i; Createdat = c; Updatedat = u; Sort = s; p = p }

let pEU_clone (p:pEU): pEU = {
    Caption = p.Caption
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
    ,[AuthType])
    END
    """


let db__pFILE(line:Object[]): pFILE =
    let p = pFILE_empty()

    p.Caption <- string(line[4]).TrimEnd()
    p.Desc <- string(line[5]).TrimEnd()
    p.Suffix <- string(line[6]).TrimEnd()
    p.Size <- if Convert.IsDBNull(line[7]) then 0L else line[7] :?> int64
    p.Thumbnail <- if Convert.IsDBNull(line[8]) then [| |] else line[8] :?> byte[]
    p.Owner <- if Convert.IsDBNull(line[9]) then 0L else line[9] :?> int64

    p

let pFILE__sps (p:pFILE) =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            ("Caption", p.Caption) |> kvp__sqlparam
            ("Desc", p.Desc) |> kvp__sqlparam
            ("Suffix", p.Suffix) |> kvp__sqlparam
            ("Size", p.Size) |> kvp__sqlparam
            ("Thumbnail", p.Thumbnail) |> kvp__sqlparam
            ("Owner", p.Owner) |> kvp__sqlparam |]
    | Rdbms.PostgreSql ->
        [|
            ("caption", p.Caption) |> kvp__sqlparam
            ("desc", p.Desc) |> kvp__sqlparam
            ("suffix", p.Suffix) |> kvp__sqlparam
            ("size", p.Size) |> kvp__sqlparam
            ("thumbnail", p.Thumbnail) |> kvp__sqlparam
            ("owner", p.Owner) |> kvp__sqlparam |]

let db__FILE = db__Rcd db__pFILE

let FILE_wrapper item: FILE =
    let (i,c,u,s),p = item
    { ID = i; Createdat = c; Updatedat = u; Sort = s; p = p }

let pFILE_clone (p:pFILE): pFILE = {
    Caption = p.Caption
    Desc = p.Desc
    Suffix = p.Suffix
    Size = p.Size
    Thumbnail = p.Thumbnail
    Owner = p.Owner }

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
    ,[Desc]
    ,[Suffix]
    ,[Size]
    ,[Thumbnail]
    ,[Owner])
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
            ("Type", p.Type) |> kvp__sqlparam
            ("State", p.State) |> kvp__sqlparam
            ("MediaType", p.MediaType) |> kvp__sqlparam |]
    | Rdbms.PostgreSql ->
        [|
            ("title", p.Title) |> kvp__sqlparam
            ("summary", p.Summary) |> kvp__sqlparam
            ("fulltext", p.FullText) |> kvp__sqlparam
            ("previewimgurl", p.PreviewImgUrl) |> kvp__sqlparam
            ("link", p.Link) |> kvp__sqlparam
            ("type", p.Type) |> kvp__sqlparam
            ("state", p.State) |> kvp__sqlparam
            ("mediatype", p.MediaType) |> kvp__sqlparam |]

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
| BOOK = 0
| EU = 1
| FILE = 2
| FBIND = 3
| MOMENT = 4
| LOG = 5
| PLOG = 6

let tablenames = [|
    BOOK_metadata.table
    EU_metadata.table
    FILE_metadata.table
    FBIND_metadata.table
    MOMENT_metadata.table
    LOG_metadata.table
    PLOG_metadata.table |]

let init() =

    let sqlMaxCa_Book, sqlCountCa_Book =
        match rdbms with
        | Rdbms.SqlServer -> "SELECT MAX(ID) FROM [Ca_Book]", "SELECT COUNT(ID) FROM [Ca_Book]"
        | Rdbms.PostgreSql -> "SELECT MAX(id) FROM ca_book", "SELECT COUNT(id) FROM ca_book"
    match singlevalue_query conn (str__sql sqlMaxCa_Book) with
    | Some v ->
        let max = v :?> int64
        if max > BOOK_id.Value then
            BOOK_id.Value <- max
    | None -> ()

    match singlevalue_query conn (str__sql sqlCountCa_Book) with
    | Some v ->
        BOOK_count.Value <-
            match rdbms with
            | Rdbms.SqlServer -> v :?> int32
            | Rdbms.PostgreSql -> v :?> int64 |> int32
    | None -> ()

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