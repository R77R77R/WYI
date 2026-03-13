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
open Util.Stat

open PreOrm

// [Ca_Book] (BOOK)

type pBOOK = {
mutable Caption: Chars
mutable Email: Chars
mutable Message: Text}


type BOOK = Rcd<pBOOK>

let BOOK_fieldorders() =
    match rdbms with
    | Rdbms.SqlServer ->
        "[ID],[Createdat],[Updatedat],[Sort],[Caption],[Email],[Message]"
    | Rdbms.PostgreSql ->
        $""" "id","createdat","updatedat","sort", "caption","email","message" """

let pBOOK_fieldordersArray = [|
    "Caption"
    "Email"
    "Message" |]

let BOOK_sql_update() =
    match rdbms with
    | Rdbms.SqlServer -> "[Caption]=@Caption,[Email]=@Email,[Message]=@Message"
    | Rdbms.PostgreSql -> "caption=@caption,email=@email,message=@message"

let pBOOK_fields() =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            Chars("Caption", 64)
            Chars("Email", 64)
            Text("Message") |]
    | Rdbms.PostgreSql ->
        [|
            Chars("caption", 64)
            Chars("email", 64)
            Text("message") |]

let pBOOK_empty(): pBOOK = {
    Caption = ""
    Email = ""
    Message = "" }

let BOOK_id = ref 1001L
let BOOK_count = ref 0
let BOOK_table = "Ca_Book"

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
mutable AuthType: euAuthTypeEnum}


type EU = Rcd<pEU>

let EU_fieldorders() =
    match rdbms with
    | Rdbms.SqlServer ->
        "[ID],[Createdat],[Updatedat],[Sort],[Caption],[AuthType]"
    | Rdbms.PostgreSql ->
        $""" "id","createdat","updatedat","sort", "caption","authtype" """

let pEU_fieldordersArray = [|
    "Caption"
    "AuthType" |]

let EU_sql_update() =
    match rdbms with
    | Rdbms.SqlServer -> "[Caption]=@Caption,[AuthType]=@AuthType"
    | Rdbms.PostgreSql -> "caption=@caption,authtype=@authtype"

let pEU_fields() =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            Chars("Caption", 64)
            SelectLines("AuthType", [| ("Normal","Normal");("Authorized","Authorized");("Admin","Admin") |]) |]
    | Rdbms.PostgreSql ->
        [|
            Chars("caption", 64)
            SelectLines("authtype", [| ("Normal","Normal");("Authorized","Authorized");("Admin","Admin") |]) |]

let pEU_empty(): pEU = {
    Caption = ""
    AuthType = EnumOfValue 0 }

let EU_id = ref 1001L
let EU_count = ref 0
let EU_table = "Ca_EndUser"

// [Ca_File] (FILE)

type pFILE = {
mutable Caption: Text
mutable Desc: Text
mutable Suffix: Chars
mutable Size: Integer
mutable Thumbnail: Bin
mutable Owner: FK}


type FILE = Rcd<pFILE>

let FILE_fieldorders() =
    match rdbms with
    | Rdbms.SqlServer ->
        "[ID],[Createdat],[Updatedat],[Sort],[Caption],[Desc],[Suffix],[Size],[Thumbnail],[Owner]"
    | Rdbms.PostgreSql ->
        $""" "id","createdat","updatedat","sort", "caption","desc","suffix","size","thumbnail","owner" """

let pFILE_fieldordersArray = [|
    "Caption"
    "Desc"
    "Suffix"
    "Size"
    "Thumbnail"
    "Owner" |]

let FILE_sql_update() =
    match rdbms with
    | Rdbms.SqlServer -> "[Caption]=@Caption,[Desc]=@Desc,[Suffix]=@Suffix,[Size]=@Size,[Thumbnail]=@Thumbnail,[Owner]=@Owner"
    | Rdbms.PostgreSql -> "caption=@caption,desc=@desc,suffix=@suffix,size=@size,thumbnail=@thumbnail,owner=@owner"

let pFILE_fields() =
    match rdbms with
    | Rdbms.SqlServer ->
        [|
            Text("Caption")
            Text("Desc")
            Chars("Suffix", 4)
            Integer("Size")
            Bin("Thumbnail")
            FK("Owner") |]
    | Rdbms.PostgreSql ->
        [|
            Text("caption")
            Text("desc")
            Chars("suffix", 4)
            Integer("size")
            Bin("thumbnail")
            FK("owner") |]

let pFILE_empty(): pFILE = {
    Caption = ""
    Desc = ""
    Suffix = ""
    Size = 0L
    Thumbnail = [||]
    Owner = 0L }

let FILE_id = ref 35461231L
let FILE_count = ref 0
let FILE_table = "Ca_File"

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
