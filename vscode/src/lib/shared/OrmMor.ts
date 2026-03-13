// OrmMor.ts
import { BinIndexed, BytesBuilder } from "~/lib/util/bin"
import * as binCommon from '~/lib/util/bin'
const marshall = {...binCommon }


// [BOOK] Structure


export const pBOOK__bin = (bb:BytesBuilder) => (p:studio.pBOOK) => {

    
    marshall.str__bin (bb) (p.Caption)
    
    marshall.str__bin (bb) (p.Email)
    
    marshall.str__bin (bb) (p.Message)
}

export const BOOK__bin = (bb:BytesBuilder) => (v:studio.BOOK) => {
    marshall.int64__bin (bb) (v.id)
    marshall.int64__bin (bb) (v.sort)
    marshall.DateTime__bin (bb) (v.createdat)
    marshall.DateTime__bin (bb) (v.updatedat)

    pBOOK__bin (bb) (v.p)
}

export const bin__pBOOK = (bi:BinIndexed):studio.pBOOK => {

    let p = pBOOK_empty()
    p.Caption = marshall.bin__str (bi)
    p.Email = marshall.bin__str (bi)
    p.Message = marshall.bin__str (bi)

    return p
}


export const bin__BOOK = (bi:BinIndexed):studio.BOOK => {

    let ID = marshall.bin__int64 (bi)
    let Sort = marshall.bin__int64 (bi)
    let Createdat = marshall.bin__DateTime (bi)
    let Updatedat = marshall.bin__DateTime (bi)
    
    return {
        id: ID,
        sort: Sort,
        createdat: Createdat,
        updatedat: Updatedat,
        p:  bin__pBOOK (bi)
    }
}

// [EU] Structure


export const pEU__bin = (bb:BytesBuilder) => (p:studio.pEU) => {

    
    marshall.str__bin (bb) (p.Caption)
    
    marshall.int32__bin (bb) (p.AuthType)
}

export const EU__bin = (bb:BytesBuilder) => (v:studio.EU) => {
    marshall.int64__bin (bb) (v.id)
    marshall.int64__bin (bb) (v.sort)
    marshall.DateTime__bin (bb) (v.createdat)
    marshall.DateTime__bin (bb) (v.updatedat)

    pEU__bin (bb) (v.p)
}

export const bin__pEU = (bi:BinIndexed):studio.pEU => {

    let p = pEU_empty()
    p.Caption = marshall.bin__str (bi)
    p.AuthType = marshall.bin__int32 (bi)

    return p
}


export const bin__EU = (bi:BinIndexed):studio.EU => {

    let ID = marshall.bin__int64 (bi)
    let Sort = marshall.bin__int64 (bi)
    let Createdat = marshall.bin__DateTime (bi)
    let Updatedat = marshall.bin__DateTime (bi)
    
    return {
        id: ID,
        sort: Sort,
        createdat: Createdat,
        updatedat: Updatedat,
        p:  bin__pEU (bi)
    }
}

// [FILE] Structure


export const pFILE__bin = (bb:BytesBuilder) => (p:studio.pFILE) => {

    
    marshall.str__bin (bb) (p.Caption)
    
    marshall.str__bin (bb) (p.Desc)
    
    marshall.str__bin (bb) (p.Suffix)
    
    marshall.int64__bin (bb) (p.Size)
    
    marshall.int32__bin (bb) (p.Thumbnail.length)
    bb.append(p.Thumbnail)
    
    marshall.int64__bin (bb) (p.Owner)
}

export const FILE__bin = (bb:BytesBuilder) => (v:studio.FILE) => {
    marshall.int64__bin (bb) (v.id)
    marshall.int64__bin (bb) (v.sort)
    marshall.DateTime__bin (bb) (v.createdat)
    marshall.DateTime__bin (bb) (v.updatedat)

    pFILE__bin (bb) (v.p)
}

export const bin__pFILE = (bi:BinIndexed):studio.pFILE => {

    let p = pFILE_empty()
    p.Caption = marshall.bin__str (bi)
    p.Desc = marshall.bin__str (bi)
    p.Suffix = marshall.bin__str (bi)
    p.Size = marshall.bin__int64 (bi)
    
    let lengthThumbnail = binCommon.bin__int32(bi)
    p.Thumbnail = bi.bin.slice(bi.index,lengthThumbnail)
    bi.index += lengthThumbnail
    
    p.Owner = marshall.bin__int64 (bi)

    return p
}


export const bin__FILE = (bi:BinIndexed):studio.FILE => {

    let ID = marshall.bin__int64 (bi)
    let Sort = marshall.bin__int64 (bi)
    let Createdat = marshall.bin__DateTime (bi)
    let Updatedat = marshall.bin__DateTime (bi)
    
    return {
        id: ID,
        sort: Sort,
        createdat: Createdat,
        updatedat: Updatedat,
        p:  bin__pFILE (bi)
    }
}

// [FBIND] Structure


export const pFBIND__bin = (bb:BytesBuilder) => (p:studio.pFBIND) => {

    
    marshall.int64__bin (bb) (p.File)
    
    marshall.int64__bin (bb) (p.Moment)
    
    marshall.str__bin (bb) (p.Desc)
}

export const FBIND__bin = (bb:BytesBuilder) => (v:studio.FBIND) => {
    marshall.int64__bin (bb) (v.id)
    marshall.int64__bin (bb) (v.sort)
    marshall.DateTime__bin (bb) (v.createdat)
    marshall.DateTime__bin (bb) (v.updatedat)

    pFBIND__bin (bb) (v.p)
}

export const bin__pFBIND = (bi:BinIndexed):studio.pFBIND => {

    let p = pFBIND_empty()
    p.File = marshall.bin__int64 (bi)
    p.Moment = marshall.bin__int64 (bi)
    p.Desc = marshall.bin__str (bi)

    return p
}


export const bin__FBIND = (bi:BinIndexed):studio.FBIND => {

    let ID = marshall.bin__int64 (bi)
    let Sort = marshall.bin__int64 (bi)
    let Createdat = marshall.bin__DateTime (bi)
    let Updatedat = marshall.bin__DateTime (bi)
    
    return {
        id: ID,
        sort: Sort,
        createdat: Createdat,
        updatedat: Updatedat,
        p:  bin__pFBIND (bi)
    }
}

// [MOMENT] Structure


export const pMOMENT__bin = (bb:BytesBuilder) => (p:studio.pMOMENT) => {

    
    marshall.str__bin (bb) (p.Title)
    
    marshall.str__bin (bb) (p.Summary)
    
    marshall.str__bin (bb) (p.FullText)
    
    marshall.str__bin (bb) (p.PreviewImgUrl)
    
    marshall.str__bin (bb) (p.Link)
    
    marshall.int32__bin (bb) (p.Type)
    
    marshall.int32__bin (bb) (p.State)
    
    marshall.int32__bin (bb) (p.MediaType)
}

export const MOMENT__bin = (bb:BytesBuilder) => (v:studio.MOMENT) => {
    marshall.int64__bin (bb) (v.id)
    marshall.int64__bin (bb) (v.sort)
    marshall.DateTime__bin (bb) (v.createdat)
    marshall.DateTime__bin (bb) (v.updatedat)

    pMOMENT__bin (bb) (v.p)
}

export const bin__pMOMENT = (bi:BinIndexed):studio.pMOMENT => {

    let p = pMOMENT_empty()
    p.Title = marshall.bin__str (bi)
    p.Summary = marshall.bin__str (bi)
    p.FullText = marshall.bin__str (bi)
    p.PreviewImgUrl = marshall.bin__str (bi)
    p.Link = marshall.bin__str (bi)
    p.Type = marshall.bin__int32 (bi)
    p.State = marshall.bin__int32 (bi)
    p.MediaType = marshall.bin__int32 (bi)

    return p
}


export const bin__MOMENT = (bi:BinIndexed):studio.MOMENT => {

    let ID = marshall.bin__int64 (bi)
    let Sort = marshall.bin__int64 (bi)
    let Createdat = marshall.bin__DateTime (bi)
    let Updatedat = marshall.bin__DateTime (bi)
    
    return {
        id: ID,
        sort: Sort,
        createdat: Createdat,
        updatedat: Updatedat,
        p:  bin__pMOMENT (bi)
    }
}

// [LOG] Structure


export const pLOG__bin = (bb:BytesBuilder) => (p:studio.pLOG) => {

    
    marshall.str__bin (bb) (p.Location)
    
    marshall.str__bin (bb) (p.Content)
    
    marshall.str__bin (bb) (p.Sql)
}

export const LOG__bin = (bb:BytesBuilder) => (v:studio.LOG) => {
    marshall.int64__bin (bb) (v.id)
    marshall.int64__bin (bb) (v.sort)
    marshall.DateTime__bin (bb) (v.createdat)
    marshall.DateTime__bin (bb) (v.updatedat)

    pLOG__bin (bb) (v.p)
}

export const bin__pLOG = (bi:BinIndexed):studio.pLOG => {

    let p = pLOG_empty()
    p.Location = marshall.bin__str (bi)
    p.Content = marshall.bin__str (bi)
    p.Sql = marshall.bin__str (bi)

    return p
}


export const bin__LOG = (bi:BinIndexed):studio.LOG => {

    let ID = marshall.bin__int64 (bi)
    let Sort = marshall.bin__int64 (bi)
    let Createdat = marshall.bin__DateTime (bi)
    let Updatedat = marshall.bin__DateTime (bi)
    
    return {
        id: ID,
        sort: Sort,
        createdat: Createdat,
        updatedat: Updatedat,
        p:  bin__pLOG (bi)
    }
}

// [PLOG] Structure


export const pPLOG__bin = (bb:BytesBuilder) => (p:studio.pPLOG) => {

    
    marshall.str__bin (bb) (p.Ip)
    
    marshall.str__bin (bb) (p.Request)
}

export const PLOG__bin = (bb:BytesBuilder) => (v:studio.PLOG) => {
    marshall.int64__bin (bb) (v.id)
    marshall.int64__bin (bb) (v.sort)
    marshall.DateTime__bin (bb) (v.createdat)
    marshall.DateTime__bin (bb) (v.updatedat)

    pPLOG__bin (bb) (v.p)
}

export const bin__pPLOG = (bi:BinIndexed):studio.pPLOG => {

    let p = pPLOG_empty()
    p.Ip = marshall.bin__str (bi)
    p.Request = marshall.bin__str (bi)

    return p
}


export const bin__PLOG = (bi:BinIndexed):studio.PLOG => {

    let ID = marshall.bin__int64 (bi)
    let Sort = marshall.bin__int64 (bi)
    let Createdat = marshall.bin__DateTime (bi)
    let Updatedat = marshall.bin__DateTime (bi)
    
    return {
        id: ID,
        sort: Sort,
        createdat: Createdat,
        updatedat: Updatedat,
        p:  bin__pPLOG (bi)
    }
}
export const pBOOK_empty = (): studio.pBOOK => {
    return {
        Caption: "",
        Email: "",
        Message: "" }
}

export const BOOK_empty = (): studio.BOOK => {
    return {
        id: 0,
        createdat: new Date(),
        updatedat: new Date(),
        sort: 0,
        p: pBOOK_empty() }
}

export const euAuthTypeEnum_Normal = 0 // Normal
export const euAuthTypeEnum_Authorized = 1 // Authorized
export const euAuthTypeEnum_Admin = 2 // Admin

export const pEU_empty = (): studio.pEU => {
    return {
        Caption: "",
        AuthType: 0 }
}

export const EU_empty = (): studio.EU => {
    return {
        id: 0,
        createdat: new Date(),
        updatedat: new Date(),
        sort: 0,
        p: pEU_empty() }
}

export const pFILE_empty = (): studio.pFILE => {
    return {
        Caption: "",
        Desc: "",
        Suffix: "",
        Size: 0,
        Thumbnail: [],
        Owner: 0 }
}

export const FILE_empty = (): studio.FILE => {
    return {
        id: 0,
        createdat: new Date(),
        updatedat: new Date(),
        sort: 0,
        p: pFILE_empty() }
}

export const pFBIND_empty = (): studio.pFBIND => {
    return {
        File: 0,
        Moment: 0,
        Desc: "" }
}

export const FBIND_empty = (): studio.FBIND => {
    return {
        id: 0,
        createdat: new Date(),
        updatedat: new Date(),
        sort: 0,
        p: pFBIND_empty() }
}

export const momentTypeEnum_Original = 0 // 原创图文视频
export const momentTypeEnum_Repost = 1 // 转发
export const momentTypeEnum_Thread = 2 // 文章
export const momentTypeEnum_Forum = 3 // 论坛
export const momentTypeEnum_Question = 4 // 问题
export const momentTypeEnum_Answer = 5 // 回答
export const momentTypeEnum_BookmarkList = 6 // 收藏夹
export const momentTypeEnum_Poll = 7 // 投票
export const momentTypeEnum_Miles = 8 // 文贵直播文字版
export const momentTypeEnum_Dict = 9 // 辞典
export const momentTypeEnum_WebPage = 10 // 页面
export const momentTypeEnum_MediaFile = 11 // 媒体文件

export const momentStateEnum_Normal = 0 // 正常
export const momentStateEnum_Deleted = 1 // 标记删除
export const momentStateEnum_Scratch = 2 // 草稿

export const momentMediaTypeEnum_None = 0 // 无
export const momentMediaTypeEnum_Video = 1 // 视频
export const momentMediaTypeEnum_Audio = 2 // 音频

export const pMOMENT_empty = (): studio.pMOMENT => {
    return {
        Title: "",
        Summary: "",
        FullText: "",
        PreviewImgUrl: "",
        Link: "",
        Type: 0,
        State: 0,
        MediaType: 0 }
}

export const MOMENT_empty = (): studio.MOMENT => {
    return {
        id: 0,
        createdat: new Date(),
        updatedat: new Date(),
        sort: 0,
        p: pMOMENT_empty() }
}

export const pLOG_empty = (): studio.pLOG => {
    return {
        Location: "",
        Content: "",
        Sql: "" }
}

export const LOG_empty = (): studio.LOG => {
    return {
        id: 0,
        createdat: new Date(),
        updatedat: new Date(),
        sort: 0,
        p: pLOG_empty() }
}

export const pPLOG_empty = (): studio.pPLOG => {
    return {
        Ip: "",
        Request: "" }
}

export const PLOG_empty = (): studio.PLOG => {
    return {
        id: 0,
        createdat: new Date(),
        updatedat: new Date(),
        sort: 0,
        p: pPLOG_empty() }
}
