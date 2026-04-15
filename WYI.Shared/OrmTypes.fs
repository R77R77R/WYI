module WYI.Shared.OrmTypes

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

// [Ca_EndUser] (EU)

type euAuthTypeEnum = 
| Normal = 0 // Normal
| Authorized = 1 // Authorized
| Admin = 2 // Admin

let euAuthTypeEnums = [| euAuthTypeEnum.Normal; euAuthTypeEnum.Authorized; euAuthTypeEnum.Admin |]
let euAuthTypeEnumstrs = [| "euAuthTypeEnum"; "euAuthTypeEnum"; "euAuthTypeEnum" |]
let euAuthTypeNum = 3

let int__euAuthTypeEnum v =
    match v with
    | 0 -> Some euAuthTypeEnum.Normal
    | 1 -> Some euAuthTypeEnum.Authorized
    | 2 -> Some euAuthTypeEnum.Admin
    | _ -> None

let str__euAuthTypeEnum s =
    match s with
    | "Normal" -> Some euAuthTypeEnum.Normal
    | "Authorized" -> Some euAuthTypeEnum.Authorized
    | "Admin" -> Some euAuthTypeEnum.Admin
    | _ -> None

let euAuthTypeEnum__caption e =
    match e with
    | euAuthTypeEnum.Normal -> "Normal"
    | euAuthTypeEnum.Authorized -> "Authorized"
    | euAuthTypeEnum.Admin -> "Admin"
    | _ -> ""

type pEU = {
mutable Caption: Chars
mutable Username: Chars
mutable Email: Chars
mutable Avatar: Text
mutable OAuthProvider: Chars
mutable ClerkUserID: Chars
mutable Pwd: Chars
mutable AuthType: euAuthTypeEnum}


type EU = Rcd<pEU>

let EU_fieldorders() =
    match rdbms with
    | Rdbms.SqlServer ->
        "[ID],[Createdat],[Updatedat],[Sort],[Caption],[Username],[Email],[Avatar],[OAuthProvider],[ClerkUserID],[Pwd],[AuthType]"
    | Rdbms.PostgreSql ->
        $""" "id","createdat","updatedat","sort", "caption","username","email","avatar","oauthprovider","clerkuserid","pwd","authtype" """

let pEU_fieldordersArray = [|
    "Caption"
    "Username"
    "Email"
    "Avatar"
    "OAuthProvider"
    "ClerkUserID"
    "Pwd"
    "AuthType" |]

let EU_sql_update() =
    match rdbms with
    | Rdbms.SqlServer -> "[Caption]=@Caption,[Username]=@Username,[Email]=@Email,[Avatar]=@Avatar,[OAuthProvider]=@OAuthProvider,[ClerkUserID]=@ClerkUserID,[Pwd]=@Pwd,[AuthType]=@AuthType"
    | Rdbms.PostgreSql -> "caption=@caption,username=@username,email=@email,avatar=@avatar,oauthprovider=@oauthprovider,clerkuserid=@clerkuserid,pwd=@pwd,authtype=@authtype"

let pEU_fields() =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            Chars("Caption", 64)
            Chars("Username", 64)
            Chars("Email", 255)
            Text("Avatar")
            Chars("OAuthProvider", 64)
            Chars("ClerkUserID", 100)
            Chars("Pwd", 64)
            SelectLines("AuthType", [| ("Normal","Normal");("Authorized","Authorized");("Admin","Admin") |]) |]
    | Rdbms.PostgreSql ->
        [|
            Chars("caption", 64)
            Chars("username", 64)
            Chars("email", 255)
            Text("avatar")
            Chars("oauthprovider", 64)
            Chars("clerkuserid", 100)
            Chars("pwd", 64)
            SelectLines("authtype", [| ("Normal","Normal");("Authorized","Authorized");("Admin","Admin") |]) |]

let pEU_empty(): pEU = {
    Caption = ""
    Username = ""
    Email = ""
    Avatar = ""
    OAuthProvider = ""
    ClerkUserID = ""
    Pwd = ""
    AuthType = EnumOfValue 0 }

let EU_id = ref 1001L
let EU_count = ref 0
let EU_table = "Ca_EndUser"

// [Ca_File] (FILE)

type fileStateEnum = 
| Normal = 0 // Normal
| Failed = 1 // Failed

let fileStateEnums = [| fileStateEnum.Normal; fileStateEnum.Failed |]
let fileStateEnumstrs = [| "fileStateEnum"; "fileStateEnum" |]
let fileStateNum = 2

let int__fileStateEnum v =
    match v with
    | 0 -> Some fileStateEnum.Normal
    | 1 -> Some fileStateEnum.Failed
    | _ -> None

let str__fileStateEnum s =
    match s with
    | "Normal" -> Some fileStateEnum.Normal
    | "Failed" -> Some fileStateEnum.Failed
    | _ -> None

let fileStateEnum__caption e =
    match e with
    | fileStateEnum.Normal -> "Normal"
    | fileStateEnum.Failed -> "Failed"
    | _ -> ""

type pFILE = {
mutable Caption: Text
mutable Path: Text
mutable State: fileStateEnum
mutable ContentType: Chars
mutable Suffix: Chars
mutable Size: Integer
mutable Thumbnail: Bin
mutable Owner: FK
mutable Cat: FK
mutable Provider: FK
mutable Unit: FK
mutable Bill: FK}


type FILE = Rcd<pFILE>

let FILE_fieldorders() =
    match rdbms with
    | Rdbms.SqlServer ->
        "[ID],[Createdat],[Updatedat],[Sort],[Caption],[Path],[State],[ContentType],[Suffix],[Size],[Thumbnail],[Owner],[Cat],[Provider],[Unit],[Bill]"
    | Rdbms.PostgreSql ->
        $""" "id","createdat","updatedat","sort", "caption","path","state","contenttype","suffix","size","thumbnail","owner","cat","provider","unit","bill" """

let pFILE_fieldordersArray = [|
    "Caption"
    "Path"
    "State"
    "ContentType"
    "Suffix"
    "Size"
    "Thumbnail"
    "Owner"
    "Cat"
    "Provider"
    "Unit"
    "Bill" |]

let FILE_sql_update() =
    match rdbms with
    | Rdbms.SqlServer -> "[Caption]=@Caption,[Path]=@Path,[State]=@State,[ContentType]=@ContentType,[Suffix]=@Suffix,[Size]=@Size,[Thumbnail]=@Thumbnail,[Owner]=@Owner,[Cat]=@Cat,[Provider]=@Provider,[Unit]=@Unit,[Bill]=@Bill"
    | Rdbms.PostgreSql -> "caption=@caption,path=@path,state=@state,contenttype=@contenttype,suffix=@suffix,size=@size,thumbnail=@thumbnail,owner=@owner,cat=@cat,provider=@provider,unit=@unit,bill=@bill"

let pFILE_fields() =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            Text("Caption")
            Text("Path")
            SelectLines("State", [| ("Normal","Normal");("Failed","Failed") |])
            Chars("ContentType", 256)
            Chars("Suffix", 4)
            Integer("Size")
            Bin("Thumbnail")
            FK("Owner")
            FK("Cat")
            FK("Provider")
            FK("Unit")
            FK("Bill") |]
    | Rdbms.PostgreSql ->
        [|
            Text("caption")
            Text("path")
            SelectLines("state", [| ("Normal","Normal");("Failed","Failed") |])
            Chars("contenttype", 256)
            Chars("suffix", 4)
            Integer("size")
            Bin("thumbnail")
            FK("owner")
            FK("cat")
            FK("provider")
            FK("unit")
            FK("bill") |]

let pFILE_empty(): pFILE = {
    Caption = ""
    Path = ""
    State = EnumOfValue 0
    ContentType = ""
    Suffix = ""
    Size = 0L
    Thumbnail = [||]
    Owner = 0L
    Cat = 0L
    Provider = 0L
    Unit = 0L
    Bill = 0L }

let FILE_id = ref 35461231L
let FILE_count = ref 0
let FILE_table = "Ca_File"

// [Kernel_Pool] (POOL)

type poolStateEnum = 
| Draft = 0 // Draft
| OnGoing = 1 // OnGoing
| Closed = 2 // Closed

let poolStateEnums = [| poolStateEnum.Draft; poolStateEnum.OnGoing; poolStateEnum.Closed |]
let poolStateEnumstrs = [| "poolStateEnum"; "poolStateEnum"; "poolStateEnum" |]
let poolStateNum = 3

let int__poolStateEnum v =
    match v with
    | 0 -> Some poolStateEnum.Draft
    | 1 -> Some poolStateEnum.OnGoing
    | 2 -> Some poolStateEnum.Closed
    | _ -> None

let str__poolStateEnum s =
    match s with
    | "Draft" -> Some poolStateEnum.Draft
    | "OnGoing" -> Some poolStateEnum.OnGoing
    | "Closed" -> Some poolStateEnum.Closed
    | _ -> None

let poolStateEnum__caption e =
    match e with
    | poolStateEnum.Draft -> "Draft"
    | poolStateEnum.OnGoing -> "OnGoing"
    | poolStateEnum.Closed -> "Closed"
    | _ -> ""

type pPOOL = {
mutable Caption: Text
mutable Cat: FK
mutable Provider: FK
mutable Manager: FK
mutable State: poolStateEnum
mutable Notes: Text
mutable Amt: Float
mutable AmtReduction: Float
mutable AmtReturn: Float}


type POOL = Rcd<pPOOL>

let POOL_fieldorders() =
    match rdbms with
    | Rdbms.SqlServer ->
        "[ID],[Createdat],[Updatedat],[Sort],[Caption],[Cat],[Provider],[Manager],[State],[Notes],[Amt],[AmtReduction],[AmtReturn]"
    | Rdbms.PostgreSql ->
        $""" "id","createdat","updatedat","sort", "caption","cat","provider","manager","state","notes","amt","amtreduction","amtreturn" """

let pPOOL_fieldordersArray = [|
    "Caption"
    "Cat"
    "Provider"
    "Manager"
    "State"
    "Notes"
    "Amt"
    "AmtReduction"
    "AmtReturn" |]

let POOL_sql_update() =
    match rdbms with
    | Rdbms.SqlServer -> "[Caption]=@Caption,[Cat]=@Cat,[Provider]=@Provider,[Manager]=@Manager,[State]=@State,[Notes]=@Notes,[Amt]=@Amt,[AmtReduction]=@AmtReduction,[AmtReturn]=@AmtReturn"
    | Rdbms.PostgreSql -> "caption=@caption,cat=@cat,provider=@provider,manager=@manager,state=@state,notes=@notes,amt=@amt,amtreduction=@amtreduction,amtreturn=@amtreturn"

let pPOOL_fields() =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            Text("Caption")
            FK("Cat")
            FK("Provider")
            FK("Manager")
            SelectLines("State", [| ("Draft","Draft");("OnGoing","OnGoing");("Closed","Closed") |])
            Text("Notes")
            Float("Amt")
            Float("AmtReduction")
            Float("AmtReturn") |]
    | Rdbms.PostgreSql ->
        [|
            Text("caption")
            FK("cat")
            FK("provider")
            FK("manager")
            SelectLines("state", [| ("Draft","Draft");("OnGoing","OnGoing");("Closed","Closed") |])
            Text("notes")
            Float("amt")
            Float("amtreduction")
            Float("amtreturn") |]

let pPOOL_empty(): pPOOL = {
    Caption = ""
    Cat = 0L
    Provider = 0L
    Manager = 0L
    State = EnumOfValue 0
    Notes = ""
    Amt = 0.0
    AmtReduction = 0.0
    AmtReturn = 0.0 }

let POOL_id = ref 6544261L
let POOL_count = ref 0
let POOL_table = "Kernel_Pool"

// [Kernel_Unit] (UNIT)

type pUNIT = {
mutable Caption: Text
mutable Owner: FK
mutable UnitNum: Chars
mutable AcctNum: Text
mutable Address: Text
mutable Town: Text
mutable State: Chars
mutable Zip: Chars}


type UNIT = Rcd<pUNIT>

let UNIT_fieldorders() =
    match rdbms with
    | Rdbms.SqlServer ->
        "[ID],[Createdat],[Updatedat],[Sort],[Caption],[Owner],[UnitNum],[AcctNum],[Address],[Town],[State],[Zip]"
    | Rdbms.PostgreSql ->
        $""" "id","createdat","updatedat","sort", "caption","owner","unitnum","acctnum","address","town","state","zip" """

let pUNIT_fieldordersArray = [|
    "Caption"
    "Owner"
    "UnitNum"
    "AcctNum"
    "Address"
    "Town"
    "State"
    "Zip" |]

let UNIT_sql_update() =
    match rdbms with
    | Rdbms.SqlServer -> "[Caption]=@Caption,[Owner]=@Owner,[UnitNum]=@UnitNum,[AcctNum]=@AcctNum,[Address]=@Address,[Town]=@Town,[State]=@State,[Zip]=@Zip"
    | Rdbms.PostgreSql -> "caption=@caption,owner=@owner,unitnum=@unitnum,acctnum=@acctnum,address=@address,town=@town,state=@state,zip=@zip"

let pUNIT_fields() =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            Text("Caption")
            FK("Owner")
            Chars("UnitNum", 5)
            Text("AcctNum")
            Text("Address")
            Text("Town")
            Chars("State", 2)
            Chars("Zip", 10) |]
    | Rdbms.PostgreSql ->
        [|
            Text("caption")
            FK("owner")
            Chars("unitnum", 5)
            Text("acctnum")
            Text("address")
            Text("town")
            Chars("state", 2)
            Chars("zip", 10) |]

let pUNIT_empty(): pUNIT = {
    Caption = ""
    Owner = 0L
    UnitNum = ""
    AcctNum = ""
    Address = ""
    Town = ""
    State = ""
    Zip = "" }

let UNIT_id = ref 29554261L
let UNIT_count = ref 0
let UNIT_table = "Kernel_Unit"

// [Kernel_UtilAcct] (UACCT)

type pUACCT = {
mutable Cat: FK
mutable Provider: FK
mutable Owner: FK
mutable Unit: FK
mutable AcctName: Text
mutable AcctNum: Text}


type UACCT = Rcd<pUACCT>

let UACCT_fieldorders() =
    match rdbms with
    | Rdbms.SqlServer ->
        "[ID],[Createdat],[Updatedat],[Sort],[Cat],[Provider],[Owner],[Unit],[AcctName],[AcctNum]"
    | Rdbms.PostgreSql ->
        $""" "id","createdat","updatedat","sort", "cat","provider","owner","unit","acctname","acctnum" """

let pUACCT_fieldordersArray = [|
    "Cat"
    "Provider"
    "Owner"
    "Unit"
    "AcctName"
    "AcctNum" |]

let UACCT_sql_update() =
    match rdbms with
    | Rdbms.SqlServer -> "[Cat]=@Cat,[Provider]=@Provider,[Owner]=@Owner,[Unit]=@Unit,[AcctName]=@AcctName,[AcctNum]=@AcctNum"
    | Rdbms.PostgreSql -> "cat=@cat,provider=@provider,owner=@owner,unit=@unit,acctname=@acctname,acctnum=@acctnum"

let pUACCT_fields() =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            FK("Cat")
            FK("Provider")
            FK("Owner")
            FK("Unit")
            Text("AcctName")
            Text("AcctNum") |]
    | Rdbms.PostgreSql ->
        [|
            FK("cat")
            FK("provider")
            FK("owner")
            FK("unit")
            Text("acctname")
            Text("acctnum") |]

let pUACCT_empty(): pUACCT = {
    Cat = 0L
    Provider = 0L
    Owner = 0L
    Unit = 0L
    AcctName = ""
    AcctNum = "" }

let UACCT_id = ref 54229561L
let UACCT_count = ref 0
let UACCT_table = "Kernel_UtilAcct"

// [Kernel_UtilBill] (UBILL)

type ubillStateEnum = 
| Submitted = 0 // Submitted
| Declined = 1 // Declined
| Accepted = 2 // Accepted
| Closed = 3 // Closed

let ubillStateEnums = [| ubillStateEnum.Submitted; ubillStateEnum.Declined; ubillStateEnum.Accepted; ubillStateEnum.Closed |]
let ubillStateEnumstrs = [| "ubillStateEnum"; "ubillStateEnum"; "ubillStateEnum"; "ubillStateEnum" |]
let ubillStateNum = 4

let int__ubillStateEnum v =
    match v with
    | 0 -> Some ubillStateEnum.Submitted
    | 1 -> Some ubillStateEnum.Declined
    | 2 -> Some ubillStateEnum.Accepted
    | 3 -> Some ubillStateEnum.Closed
    | _ -> None

let str__ubillStateEnum s =
    match s with
    | "Submitted" -> Some ubillStateEnum.Submitted
    | "Declined" -> Some ubillStateEnum.Declined
    | "Accepted" -> Some ubillStateEnum.Accepted
    | "Closed" -> Some ubillStateEnum.Closed
    | _ -> None

let ubillStateEnum__caption e =
    match e with
    | ubillStateEnum.Submitted -> "Submitted"
    | ubillStateEnum.Declined -> "Declined"
    | ubillStateEnum.Accepted -> "Accepted"
    | ubillStateEnum.Closed -> "Closed"
    | _ -> ""

type pUBILL = {
mutable Cat: FK
mutable Provider: FK
mutable Owner: FK
mutable Representative: FK
mutable Unit: FK
mutable State: ubillStateEnum
mutable UAcct: FK
mutable Pool: FK
mutable YYYYMMDD: Chars
mutable Amt: Float
mutable AmtReduction: Float
mutable AmtReturn: Float}


type UBILL = Rcd<pUBILL>

let UBILL_fieldorders() =
    match rdbms with
    | Rdbms.SqlServer ->
        "[ID],[Createdat],[Updatedat],[Sort],[Cat],[Provider],[Owner],[Representative],[Unit],[State],[UAcct],[Pool],[YYYYMMDD],[Amt],[AmtReduction],[AmtReturn]"
    | Rdbms.PostgreSql ->
        $""" "id","createdat","updatedat","sort", "cat","provider","owner","representative","unit","state","uacct","pool","yyyymmdd","amt","amtreduction","amtreturn" """

let pUBILL_fieldordersArray = [|
    "Cat"
    "Provider"
    "Owner"
    "Representative"
    "Unit"
    "State"
    "UAcct"
    "Pool"
    "YYYYMMDD"
    "Amt"
    "AmtReduction"
    "AmtReturn" |]

let UBILL_sql_update() =
    match rdbms with
    | Rdbms.SqlServer -> "[Cat]=@Cat,[Provider]=@Provider,[Owner]=@Owner,[Representative]=@Representative,[Unit]=@Unit,[State]=@State,[UAcct]=@UAcct,[Pool]=@Pool,[YYYYMMDD]=@YYYYMMDD,[Amt]=@Amt,[AmtReduction]=@AmtReduction,[AmtReturn]=@AmtReturn"
    | Rdbms.PostgreSql -> "cat=@cat,provider=@provider,owner=@owner,representative=@representative,unit=@unit,state=@state,uacct=@uacct,pool=@pool,yyyymmdd=@yyyymmdd,amt=@amt,amtreduction=@amtreduction,amtreturn=@amtreturn"

let pUBILL_fields() =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            FK("Cat")
            FK("Provider")
            FK("Owner")
            FK("Representative")
            FK("Unit")
            SelectLines("State", [| ("Submitted","Submitted");("Declined","Declined");("Accepted","Accepted");("Closed","Closed") |])
            FK("UAcct")
            FK("Pool")
            Chars("YYYYMMDD", 8)
            Float("Amt")
            Float("AmtReduction")
            Float("AmtReturn") |]
    | Rdbms.PostgreSql ->
        [|
            FK("cat")
            FK("provider")
            FK("owner")
            FK("representative")
            FK("unit")
            SelectLines("state", [| ("Submitted","Submitted");("Declined","Declined");("Accepted","Accepted");("Closed","Closed") |])
            FK("uacct")
            FK("pool")
            Chars("yyyymmdd", 8)
            Float("amt")
            Float("amtreduction")
            Float("amtreturn") |]

let pUBILL_empty(): pUBILL = {
    Cat = 0L
    Provider = 0L
    Owner = 0L
    Representative = 0L
    Unit = 0L
    State = EnumOfValue 0
    UAcct = 0L
    Pool = 0L
    YYYYMMDD = ""
    Amt = 0.0
    AmtReduction = 0.0
    AmtReturn = 0.0 }

let UBILL_id = ref 4426561L
let UBILL_count = ref 0
let UBILL_table = "Kernel_UtilBill"

// [Kernel_UtilCat] (UCAT)

type pUCAT = {
mutable Caption: Text}


type UCAT = Rcd<pUCAT>

let UCAT_fieldorders() =
    match rdbms with
    | Rdbms.SqlServer ->
        "[ID],[Createdat],[Updatedat],[Sort],[Caption]"
    | Rdbms.PostgreSql ->
        $""" "id","createdat","updatedat","sort", "caption" """

let pUCAT_fieldordersArray = [|
    "Caption" |]

let UCAT_sql_update() =
    match rdbms with
    | Rdbms.SqlServer -> "[Caption]=@Caption"
    | Rdbms.PostgreSql -> "caption=@caption"

let pUCAT_fields() =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            Text("Caption") |]
    | Rdbms.PostgreSql ->
        [|
            Text("caption") |]

let pUCAT_empty(): pUCAT = {
    Caption = "" }

let UCAT_id = ref 6461L
let UCAT_count = ref 0
let UCAT_table = "Kernel_UtilCat"

// [Kernel_UtilCatProvider] (KUCP)

type pKUCP = {
mutable Cat: FK
mutable Provider: FK}


type KUCP = Rcd<pKUCP>

let KUCP_fieldorders() =
    match rdbms with
    | Rdbms.SqlServer ->
        "[ID],[Createdat],[Updatedat],[Sort],[Cat],[Provider]"
    | Rdbms.PostgreSql ->
        $""" "id","createdat","updatedat","sort", "cat","provider" """

let pKUCP_fieldordersArray = [|
    "Cat"
    "Provider" |]

let KUCP_sql_update() =
    match rdbms with
    | Rdbms.SqlServer -> "[Cat]=@Cat,[Provider]=@Provider"
    | Rdbms.PostgreSql -> "cat=@cat,provider=@provider"

let pKUCP_fields() =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            FK("Cat")
            FK("Provider") |]
    | Rdbms.PostgreSql ->
        [|
            FK("cat")
            FK("provider") |]

let pKUCP_empty(): pKUCP = {
    Cat = 0L
    Provider = 0L }

let KUCP_id = ref 254261L
let KUCP_count = ref 0
let KUCP_table = "Kernel_UtilCatProvider"

// [Kernel_UtilProvider] (UPROVIDER)

type pUPROVIDER = {
mutable Caption: Text
mutable Logo: Text
mutable Icon: Text
mutable Cat: FK}


type UPROVIDER = Rcd<pUPROVIDER>

let UPROVIDER_fieldorders() =
    match rdbms with
    | Rdbms.SqlServer ->
        "[ID],[Createdat],[Updatedat],[Sort],[Caption],[Logo],[Icon],[Cat]"
    | Rdbms.PostgreSql ->
        $""" "id","createdat","updatedat","sort", "caption","logo","icon","cat" """

let pUPROVIDER_fieldordersArray = [|
    "Caption"
    "Logo"
    "Icon"
    "Cat" |]

let UPROVIDER_sql_update() =
    match rdbms with
    | Rdbms.SqlServer -> "[Caption]=@Caption,[Logo]=@Logo,[Icon]=@Icon,[Cat]=@Cat"
    | Rdbms.PostgreSql -> "caption=@caption,logo=@logo,icon=@icon,cat=@cat"

let pUPROVIDER_fields() =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            Text("Caption")
            Text("Logo")
            Text("Icon")
            FK("Cat") |]
    | Rdbms.PostgreSql ->
        [|
            Text("caption")
            Text("logo")
            Text("icon")
            FK("cat") |]

let pUPROVIDER_empty(): pUPROVIDER = {
    Caption = ""
    Logo = ""
    Icon = ""
    Cat = 0L }

let UPROVIDER_id = ref 254261L
let UPROVIDER_count = ref 0
let UPROVIDER_table = "Kernel_UtilProvider"

// [Social_FileBind] (FBIND)

type pFBIND = {
mutable File: FK
mutable Moment: FK
mutable Desc: Text}


type FBIND = Rcd<pFBIND>

let FBIND_fieldorders() =
    match rdbms with
    | Rdbms.SqlServer ->
        "[ID],[Createdat],[Updatedat],[Sort],[File],[Moment],[Desc]"
    | Rdbms.PostgreSql ->
        $""" "id","createdat","updatedat","sort", "file","moment","desc" """

let pFBIND_fieldordersArray = [|
    "File"
    "Moment"
    "Desc" |]

let FBIND_sql_update() =
    match rdbms with
    | Rdbms.SqlServer -> "[File]=@File,[Moment]=@Moment,[Desc]=@Desc"
    | Rdbms.PostgreSql -> "file=@file,moment=@moment,desc=@desc"

let pFBIND_fields() =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            FK("File")
            FK("Moment")
            Text("Desc") |]
    | Rdbms.PostgreSql ->
        [|
            FK("file")
            FK("moment")
            Text("desc") |]

let pFBIND_empty(): pFBIND = {
    File = 0L
    Moment = 0L
    Desc = "" }

let FBIND_id = ref 54864675L
let FBIND_count = ref 0
let FBIND_table = "Social_FileBind"

// [Social_Moment] (MOMENT)

type momentTypeEnum = 
| Original = 0 // 原创图文视频
| Repost = 1 // 转发
| Thread = 2 // 文章
| Forum = 3 // 论坛
| Question = 4 // 问题
| Answer = 5 // 回答
| BookmarkList = 6 // 收藏夹
| Poll = 7 // 投票
| Miles = 8 // 文贵直播文字版
| Dict = 9 // 辞典
| WebPage = 10 // 页面
| MediaFile = 11 // 媒体文件

let momentTypeEnums = [| momentTypeEnum.Original; momentTypeEnum.Repost; momentTypeEnum.Thread; momentTypeEnum.Forum; momentTypeEnum.Question; momentTypeEnum.Answer; momentTypeEnum.BookmarkList; momentTypeEnum.Poll; momentTypeEnum.Miles; momentTypeEnum.Dict; momentTypeEnum.WebPage; momentTypeEnum.MediaFile |]
let momentTypeEnumstrs = [| "momentTypeEnum"; "momentTypeEnum"; "momentTypeEnum"; "momentTypeEnum"; "momentTypeEnum"; "momentTypeEnum"; "momentTypeEnum"; "momentTypeEnum"; "momentTypeEnum"; "momentTypeEnum"; "momentTypeEnum"; "momentTypeEnum" |]
let momentTypeNum = 12

let int__momentTypeEnum v =
    match v with
    | 0 -> Some momentTypeEnum.Original
    | 1 -> Some momentTypeEnum.Repost
    | 2 -> Some momentTypeEnum.Thread
    | 3 -> Some momentTypeEnum.Forum
    | 4 -> Some momentTypeEnum.Question
    | 5 -> Some momentTypeEnum.Answer
    | 6 -> Some momentTypeEnum.BookmarkList
    | 7 -> Some momentTypeEnum.Poll
    | 8 -> Some momentTypeEnum.Miles
    | 9 -> Some momentTypeEnum.Dict
    | 10 -> Some momentTypeEnum.WebPage
    | 11 -> Some momentTypeEnum.MediaFile
    | _ -> None

let str__momentTypeEnum s =
    match s with
    | "Original" -> Some momentTypeEnum.Original
    | "Repost" -> Some momentTypeEnum.Repost
    | "Thread" -> Some momentTypeEnum.Thread
    | "Forum" -> Some momentTypeEnum.Forum
    | "Question" -> Some momentTypeEnum.Question
    | "Answer" -> Some momentTypeEnum.Answer
    | "BookmarkList" -> Some momentTypeEnum.BookmarkList
    | "Poll" -> Some momentTypeEnum.Poll
    | "Miles" -> Some momentTypeEnum.Miles
    | "Dict" -> Some momentTypeEnum.Dict
    | "WebPage" -> Some momentTypeEnum.WebPage
    | "MediaFile" -> Some momentTypeEnum.MediaFile
    | _ -> None

let momentTypeEnum__caption e =
    match e with
    | momentTypeEnum.Original -> "原创图文视频"
    | momentTypeEnum.Repost -> "转发"
    | momentTypeEnum.Thread -> "文章"
    | momentTypeEnum.Forum -> "论坛"
    | momentTypeEnum.Question -> "问题"
    | momentTypeEnum.Answer -> "回答"
    | momentTypeEnum.BookmarkList -> "收藏夹"
    | momentTypeEnum.Poll -> "投票"
    | momentTypeEnum.Miles -> "文贵直播文字版"
    | momentTypeEnum.Dict -> "辞典"
    | momentTypeEnum.WebPage -> "页面"
    | momentTypeEnum.MediaFile -> "媒体文件"
    | _ -> ""

type momentStateEnum = 
| Normal = 0 // 正常
| Deleted = 1 // 标记删除
| Scratch = 2 // 草稿

let momentStateEnums = [| momentStateEnum.Normal; momentStateEnum.Deleted; momentStateEnum.Scratch |]
let momentStateEnumstrs = [| "momentStateEnum"; "momentStateEnum"; "momentStateEnum" |]
let momentStateNum = 3

let int__momentStateEnum v =
    match v with
    | 0 -> Some momentStateEnum.Normal
    | 1 -> Some momentStateEnum.Deleted
    | 2 -> Some momentStateEnum.Scratch
    | _ -> None

let str__momentStateEnum s =
    match s with
    | "Normal" -> Some momentStateEnum.Normal
    | "Deleted" -> Some momentStateEnum.Deleted
    | "Scratch" -> Some momentStateEnum.Scratch
    | _ -> None

let momentStateEnum__caption e =
    match e with
    | momentStateEnum.Normal -> "正常"
    | momentStateEnum.Deleted -> "标记删除"
    | momentStateEnum.Scratch -> "草稿"
    | _ -> ""

type momentMediaTypeEnum = 
| None = 0 // 无
| Video = 1 // 视频
| Audio = 2 // 音频

let momentMediaTypeEnums = [| momentMediaTypeEnum.None; momentMediaTypeEnum.Video; momentMediaTypeEnum.Audio |]
let momentMediaTypeEnumstrs = [| "momentMediaTypeEnum"; "momentMediaTypeEnum"; "momentMediaTypeEnum" |]
let momentMediaTypeNum = 3

let int__momentMediaTypeEnum v =
    match v with
    | 0 -> Some momentMediaTypeEnum.None
    | 1 -> Some momentMediaTypeEnum.Video
    | 2 -> Some momentMediaTypeEnum.Audio
    | _ -> None

let str__momentMediaTypeEnum s =
    match s with
    | "None" -> Some momentMediaTypeEnum.None
    | "Video" -> Some momentMediaTypeEnum.Video
    | "Audio" -> Some momentMediaTypeEnum.Audio
    | _ -> None

let momentMediaTypeEnum__caption e =
    match e with
    | momentMediaTypeEnum.None -> "无"
    | momentMediaTypeEnum.Video -> "视频"
    | momentMediaTypeEnum.Audio -> "音频"
    | _ -> ""

type pMOMENT = {
mutable Title: Text
mutable Summary: Text
mutable FullText: Text
mutable PreviewImgUrl: Text
mutable Link: Text
mutable Type: momentTypeEnum
mutable State: momentStateEnum
mutable MediaType: momentMediaTypeEnum}


type MOMENT = Rcd<pMOMENT>

let MOMENT_fieldorders() =
    match rdbms with
    | Rdbms.SqlServer ->
        "[ID],[Createdat],[Updatedat],[Sort],[Title],[Summary],[FullText],[PreviewImgUrl],[Link],[Type],[State],[MediaType]"
    | Rdbms.PostgreSql ->
        $""" "id","createdat","updatedat","sort", "title","summary","fulltext","previewimgurl","link","type","state","mediatype" """

let pMOMENT_fieldordersArray = [|
    "Title"
    "Summary"
    "FullText"
    "PreviewImgUrl"
    "Link"
    "Type"
    "State"
    "MediaType" |]

let MOMENT_sql_update() =
    match rdbms with
    | Rdbms.SqlServer -> "[Title]=@Title,[Summary]=@Summary,[FullText]=@FullText,[PreviewImgUrl]=@PreviewImgUrl,[Link]=@Link,[Type]=@Type,[State]=@State,[MediaType]=@MediaType"
    | Rdbms.PostgreSql -> "title=@title,summary=@summary,fulltext=@fulltext,previewimgurl=@previewimgurl,link=@link,type=@type,state=@state,mediatype=@mediatype"

let pMOMENT_fields() =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            Text("Title")
            Text("Summary")
            Text("FullText")
            Text("PreviewImgUrl")
            Text("Link")
            SelectLines("Type", [| ("Original","原创图文视频");("Repost","转发");("Thread","文章");("Forum","论坛");("Question","问题");("Answer","回答");("BookmarkList","收藏夹");("Poll","投票");("Miles","文贵直播文字版");("Dict","辞典");("WebPage","页面");("MediaFile","媒体文件") |])
            SelectLines("State", [| ("Normal","正常");("Deleted","标记删除");("Scratch","草稿") |])
            SelectLines("MediaType", [| ("None","无");("Video","视频");("Audio","音频") |]) |]
    | Rdbms.PostgreSql ->
        [|
            Text("title")
            Text("summary")
            Text("fulltext")
            Text("previewimgurl")
            Text("link")
            SelectLines("type", [| ("Original","原创图文视频");("Repost","转发");("Thread","文章");("Forum","论坛");("Question","问题");("Answer","回答");("BookmarkList","收藏夹");("Poll","投票");("Miles","文贵直播文字版");("Dict","辞典");("WebPage","页面");("MediaFile","媒体文件") |])
            SelectLines("state", [| ("Normal","正常");("Deleted","标记删除");("Scratch","草稿") |])
            SelectLines("mediatype", [| ("None","无");("Video","视频");("Audio","音频") |]) |]

let pMOMENT_empty(): pMOMENT = {
    Title = ""
    Summary = ""
    FullText = ""
    PreviewImgUrl = ""
    Link = ""
    Type = EnumOfValue 0
    State = EnumOfValue 0
    MediaType = EnumOfValue 0 }

let MOMENT_id = ref 54864675L
let MOMENT_count = ref 0
let MOMENT_table = "Social_Moment"

// [Sys_Config] (CONFIG)

type pCONFIG = {
mutable Key: Chars
mutable Val: Text}


type CONFIG = Rcd<pCONFIG>

let CONFIG_fieldorders() =
    match rdbms with
    | Rdbms.SqlServer ->
        "[ID],[Createdat],[Updatedat],[Sort],[Key],[Val]"
    | Rdbms.PostgreSql ->
        $""" "id","createdat","updatedat","sort", "key","val" """

let pCONFIG_fieldordersArray = [|
    "Key"
    "Val" |]

let CONFIG_sql_update() =
    match rdbms with
    | Rdbms.SqlServer -> "[Key]=@Key,[Val]=@Val"
    | Rdbms.PostgreSql -> "key=@key,val=@val"

let pCONFIG_fields() =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            Chars("Key", 64)
            Text("Val") |]
    | Rdbms.PostgreSql ->
        [|
            Chars("key", 64)
            Text("val") |]

let pCONFIG_empty(): pCONFIG = {
    Key = ""
    Val = "" }

let CONFIG_id = ref 0L
let CONFIG_count = ref 0
let CONFIG_table = "Sys_Config"

// [Sys_Log] (LOG)

type pLOG = {
mutable Location: Text
mutable Content: Text
mutable Sql: Text}


type LOG = Rcd<pLOG>

let LOG_fieldorders() =
    match rdbms with
    | Rdbms.SqlServer ->
        "[ID],[Createdat],[Updatedat],[Sort],[Location],[Content],[Sql]"
    | Rdbms.PostgreSql ->
        $""" "id","createdat","updatedat","sort", "location","content","sql" """

let pLOG_fieldordersArray = [|
    "Location"
    "Content"
    "Sql" |]

let LOG_sql_update() =
    match rdbms with
    | Rdbms.SqlServer -> "[Location]=@Location,[Content]=@Content,[Sql]=@Sql"
    | Rdbms.PostgreSql -> "location=@location,content=@content,sql=@sql"

let pLOG_fields() =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            Text("Location")
            Text("Content")
            Text("Sql") |]
    | Rdbms.PostgreSql ->
        [|
            Text("location")
            Text("content")
            Text("sql") |]

let pLOG_empty(): pLOG = {
    Location = ""
    Content = ""
    Sql = "" }

let LOG_id = ref 0L
let LOG_count = ref 0
let LOG_table = "Sys_Log"

// [Sys_PageLog] (PLOG)

type pPLOG = {
mutable Ip: Chars
mutable Request: Text}


type PLOG = Rcd<pPLOG>

let PLOG_fieldorders() =
    match rdbms with
    | Rdbms.SqlServer ->
        "[ID],[Createdat],[Updatedat],[Sort],[Ip],[Request]"
    | Rdbms.PostgreSql ->
        $""" "id","createdat","updatedat","sort", "ip","request" """

let pPLOG_fieldordersArray = [|
    "Ip"
    "Request" |]

let PLOG_sql_update() =
    match rdbms with
    | Rdbms.SqlServer -> "[Ip]=@Ip,[Request]=@Request"
    | Rdbms.PostgreSql -> "ip=@ip,request=@request"

let pPLOG_fields() =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            Chars("Ip", 64)
            Text("Request") |]
    | Rdbms.PostgreSql ->
        [|
            Chars("ip", 64)
            Text("request") |]

let pPLOG_empty(): pPLOG = {
    Ip = ""
    Request = "" }

let PLOG_id = ref 0L
let PLOG_count = ref 0
let PLOG_table = "Sys_PageLog"
