// OrmMor.ts
import { BinIndexed, BytesBuilder } from "~/lib/util/bin"
import * as binCommon from '~/lib/util/bin'
const marshall = {...binCommon }


// [EU] Structure


export const pEU__bin = (bb:BytesBuilder) => (p:wyi.pEU) => {

    
    marshall.str__bin (bb) (p.Caption)
    
    marshall.str__bin (bb) (p.Username)
    
    marshall.str__bin (bb) (p.Email)
    
    marshall.str__bin (bb) (p.Avatar)
    
    marshall.str__bin (bb) (p.ClerkUserID)
    
    marshall.str__bin (bb) (p.Pwd)
    
    marshall.int32__bin (bb) (p.AuthType)
}

export const EU__bin = (bb:BytesBuilder) => (v:wyi.EU) => {
    marshall.int64__bin (bb) (v.id)
    marshall.int64__bin (bb) (v.sort)
    marshall.DateTime__bin (bb) (v.createdat)
    marshall.DateTime__bin (bb) (v.updatedat)

    pEU__bin (bb) (v.p)
}

export const bin__pEU = (bi:BinIndexed):wyi.pEU => {

    let p = pEU_empty()
    p.Caption = marshall.bin__str (bi)
    p.Username = marshall.bin__str (bi)
    p.Email = marshall.bin__str (bi)
    p.Avatar = marshall.bin__str (bi)
    p.ClerkUserID = marshall.bin__str (bi)
    p.Pwd = marshall.bin__str (bi)
    p.AuthType = marshall.bin__int32 (bi)

    return p
}


export const bin__EU = (bi:BinIndexed):wyi.EU => {

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


export const pFILE__bin = (bb:BytesBuilder) => (p:wyi.pFILE) => {

    
    marshall.str__bin (bb) (p.Caption)
    
    marshall.str__bin (bb) (p.Path)
    
    marshall.int32__bin (bb) (p.State)
    
    marshall.str__bin (bb) (p.ContentType)
    
    marshall.str__bin (bb) (p.Suffix)
    
    marshall.int64__bin (bb) (p.Size)
    
    marshall.int32__bin (bb) (p.Thumbnail.length)
    bb.append(p.Thumbnail)
    
    marshall.int64__bin (bb) (p.Owner)
    
    marshall.int64__bin (bb) (p.Cat)
    
    marshall.int64__bin (bb) (p.Provider)
    
    marshall.int64__bin (bb) (p.Unit)
    
    marshall.int64__bin (bb) (p.Bill)
}

export const FILE__bin = (bb:BytesBuilder) => (v:wyi.FILE) => {
    marshall.int64__bin (bb) (v.id)
    marshall.int64__bin (bb) (v.sort)
    marshall.DateTime__bin (bb) (v.createdat)
    marshall.DateTime__bin (bb) (v.updatedat)

    pFILE__bin (bb) (v.p)
}

export const bin__pFILE = (bi:BinIndexed):wyi.pFILE => {

    let p = pFILE_empty()
    p.Caption = marshall.bin__str (bi)
    p.Path = marshall.bin__str (bi)
    p.State = marshall.bin__int32 (bi)
    p.ContentType = marshall.bin__str (bi)
    p.Suffix = marshall.bin__str (bi)
    p.Size = marshall.bin__int64 (bi)
    
    let lengthThumbnail = binCommon.bin__int32(bi)
    p.Thumbnail = bi.bin.slice(bi.index,lengthThumbnail)
    bi.index += lengthThumbnail
    
    p.Owner = marshall.bin__int64 (bi)
    p.Cat = marshall.bin__int64 (bi)
    p.Provider = marshall.bin__int64 (bi)
    p.Unit = marshall.bin__int64 (bi)
    p.Bill = marshall.bin__int64 (bi)

    return p
}


export const bin__FILE = (bi:BinIndexed):wyi.FILE => {

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

// [UNIT] Structure


export const pUNIT__bin = (bb:BytesBuilder) => (p:wyi.pUNIT) => {

    
    marshall.str__bin (bb) (p.Caption)
    
    marshall.int64__bin (bb) (p.Owner)
    
    marshall.str__bin (bb) (p.UnitNum)
    
    marshall.str__bin (bb) (p.AcctNum)
    
    marshall.str__bin (bb) (p.Address)
    
    marshall.str__bin (bb) (p.Town)
    
    marshall.str__bin (bb) (p.State)
    
    marshall.str__bin (bb) (p.Zip)
}

export const UNIT__bin = (bb:BytesBuilder) => (v:wyi.UNIT) => {
    marshall.int64__bin (bb) (v.id)
    marshall.int64__bin (bb) (v.sort)
    marshall.DateTime__bin (bb) (v.createdat)
    marshall.DateTime__bin (bb) (v.updatedat)

    pUNIT__bin (bb) (v.p)
}

export const bin__pUNIT = (bi:BinIndexed):wyi.pUNIT => {

    let p = pUNIT_empty()
    p.Caption = marshall.bin__str (bi)
    p.Owner = marshall.bin__int64 (bi)
    p.UnitNum = marshall.bin__str (bi)
    p.AcctNum = marshall.bin__str (bi)
    p.Address = marshall.bin__str (bi)
    p.Town = marshall.bin__str (bi)
    p.State = marshall.bin__str (bi)
    p.Zip = marshall.bin__str (bi)

    return p
}


export const bin__UNIT = (bi:BinIndexed):wyi.UNIT => {

    let ID = marshall.bin__int64 (bi)
    let Sort = marshall.bin__int64 (bi)
    let Createdat = marshall.bin__DateTime (bi)
    let Updatedat = marshall.bin__DateTime (bi)
    
    return {
        id: ID,
        sort: Sort,
        createdat: Createdat,
        updatedat: Updatedat,
        p:  bin__pUNIT (bi)
    }
}

// [UACCT] Structure


export const pUACCT__bin = (bb:BytesBuilder) => (p:wyi.pUACCT) => {

    
    marshall.int64__bin (bb) (p.Cat)
    
    marshall.int64__bin (bb) (p.Provider)
    
    marshall.int64__bin (bb) (p.client)
    
    marshall.int64__bin (bb) (p.Unit)
    
    marshall.str__bin (bb) (p.AcctNum)
}

export const UACCT__bin = (bb:BytesBuilder) => (v:wyi.UACCT) => {
    marshall.int64__bin (bb) (v.id)
    marshall.int64__bin (bb) (v.sort)
    marshall.DateTime__bin (bb) (v.createdat)
    marshall.DateTime__bin (bb) (v.updatedat)

    pUACCT__bin (bb) (v.p)
}

export const bin__pUACCT = (bi:BinIndexed):wyi.pUACCT => {

    let p = pUACCT_empty()
    p.Cat = marshall.bin__int64 (bi)
    p.Provider = marshall.bin__int64 (bi)
    p.client = marshall.bin__int64 (bi)
    p.Unit = marshall.bin__int64 (bi)
    p.AcctNum = marshall.bin__str (bi)

    return p
}


export const bin__UACCT = (bi:BinIndexed):wyi.UACCT => {

    let ID = marshall.bin__int64 (bi)
    let Sort = marshall.bin__int64 (bi)
    let Createdat = marshall.bin__DateTime (bi)
    let Updatedat = marshall.bin__DateTime (bi)
    
    return {
        id: ID,
        sort: Sort,
        createdat: Createdat,
        updatedat: Updatedat,
        p:  bin__pUACCT (bi)
    }
}

// [UBILL] Structure


export const pUBILL__bin = (bb:BytesBuilder) => (p:wyi.pUBILL) => {

    
    marshall.str__bin (bb) (p.ShownProvider)
    
    marshall.str__bin (bb) (p.ShownUnitNum)
    
    marshall.str__bin (bb) (p.ShownAcctNum)
    
    marshall.str__bin (bb) (p.ShownAcctName)
    
    marshall.str__bin (bb) (p.ShownAddr)
    
    marshall.str__bin (bb) (p.ShownTown)
    
    marshall.str__bin (bb) (p.ShownState)
    
    marshall.str__bin (bb) (p.ShownZip)
    
    marshall.int64__bin (bb) (p.Cat)
    
    marshall.int64__bin (bb) (p.Provider)
    
    marshall.int64__bin (bb) (p.Owner)
    
    marshall.int64__bin (bb) (p.Unit)
    
    marshall.str__bin (bb) (p.UnitText)
    
    marshall.int64__bin (bb) (p.UAcct)
    
    marshall.float__bin (bb) (p.Amt)
}

export const UBILL__bin = (bb:BytesBuilder) => (v:wyi.UBILL) => {
    marshall.int64__bin (bb) (v.id)
    marshall.int64__bin (bb) (v.sort)
    marshall.DateTime__bin (bb) (v.createdat)
    marshall.DateTime__bin (bb) (v.updatedat)

    pUBILL__bin (bb) (v.p)
}

export const bin__pUBILL = (bi:BinIndexed):wyi.pUBILL => {

    let p = pUBILL_empty()
    p.ShownProvider = marshall.bin__str (bi)
    p.ShownUnitNum = marshall.bin__str (bi)
    p.ShownAcctNum = marshall.bin__str (bi)
    p.ShownAcctName = marshall.bin__str (bi)
    p.ShownAddr = marshall.bin__str (bi)
    p.ShownTown = marshall.bin__str (bi)
    p.ShownState = marshall.bin__str (bi)
    p.ShownZip = marshall.bin__str (bi)
    p.Cat = marshall.bin__int64 (bi)
    p.Provider = marshall.bin__int64 (bi)
    p.Owner = marshall.bin__int64 (bi)
    p.Unit = marshall.bin__int64 (bi)
    p.UnitText = marshall.bin__str (bi)
    p.UAcct = marshall.bin__int64 (bi)
    p.Amt = marshall.bin__float (bi)

    return p
}


export const bin__UBILL = (bi:BinIndexed):wyi.UBILL => {

    let ID = marshall.bin__int64 (bi)
    let Sort = marshall.bin__int64 (bi)
    let Createdat = marshall.bin__DateTime (bi)
    let Updatedat = marshall.bin__DateTime (bi)
    
    return {
        id: ID,
        sort: Sort,
        createdat: Createdat,
        updatedat: Updatedat,
        p:  bin__pUBILL (bi)
    }
}

// [UCAT] Structure


export const pUCAT__bin = (bb:BytesBuilder) => (p:wyi.pUCAT) => {

    
    marshall.str__bin (bb) (p.Caption)
}

export const UCAT__bin = (bb:BytesBuilder) => (v:wyi.UCAT) => {
    marshall.int64__bin (bb) (v.id)
    marshall.int64__bin (bb) (v.sort)
    marshall.DateTime__bin (bb) (v.createdat)
    marshall.DateTime__bin (bb) (v.updatedat)

    pUCAT__bin (bb) (v.p)
}

export const bin__pUCAT = (bi:BinIndexed):wyi.pUCAT => {

    let p = pUCAT_empty()
    p.Caption = marshall.bin__str (bi)

    return p
}


export const bin__UCAT = (bi:BinIndexed):wyi.UCAT => {

    let ID = marshall.bin__int64 (bi)
    let Sort = marshall.bin__int64 (bi)
    let Createdat = marshall.bin__DateTime (bi)
    let Updatedat = marshall.bin__DateTime (bi)
    
    return {
        id: ID,
        sort: Sort,
        createdat: Createdat,
        updatedat: Updatedat,
        p:  bin__pUCAT (bi)
    }
}

// [UPROVIDER] Structure


export const pUPROVIDER__bin = (bb:BytesBuilder) => (p:wyi.pUPROVIDER) => {

    
    marshall.str__bin (bb) (p.Caption)
    
    marshall.int64__bin (bb) (p.Cat)
}

export const UPROVIDER__bin = (bb:BytesBuilder) => (v:wyi.UPROVIDER) => {
    marshall.int64__bin (bb) (v.id)
    marshall.int64__bin (bb) (v.sort)
    marshall.DateTime__bin (bb) (v.createdat)
    marshall.DateTime__bin (bb) (v.updatedat)

    pUPROVIDER__bin (bb) (v.p)
}

export const bin__pUPROVIDER = (bi:BinIndexed):wyi.pUPROVIDER => {

    let p = pUPROVIDER_empty()
    p.Caption = marshall.bin__str (bi)
    p.Cat = marshall.bin__int64 (bi)

    return p
}


export const bin__UPROVIDER = (bi:BinIndexed):wyi.UPROVIDER => {

    let ID = marshall.bin__int64 (bi)
    let Sort = marshall.bin__int64 (bi)
    let Createdat = marshall.bin__DateTime (bi)
    let Updatedat = marshall.bin__DateTime (bi)
    
    return {
        id: ID,
        sort: Sort,
        createdat: Createdat,
        updatedat: Updatedat,
        p:  bin__pUPROVIDER (bi)
    }
}

// [FBIND] Structure


export const pFBIND__bin = (bb:BytesBuilder) => (p:wyi.pFBIND) => {

    
    marshall.int64__bin (bb) (p.File)
    
    marshall.int64__bin (bb) (p.Moment)
    
    marshall.str__bin (bb) (p.Desc)
}

export const FBIND__bin = (bb:BytesBuilder) => (v:wyi.FBIND) => {
    marshall.int64__bin (bb) (v.id)
    marshall.int64__bin (bb) (v.sort)
    marshall.DateTime__bin (bb) (v.createdat)
    marshall.DateTime__bin (bb) (v.updatedat)

    pFBIND__bin (bb) (v.p)
}

export const bin__pFBIND = (bi:BinIndexed):wyi.pFBIND => {

    let p = pFBIND_empty()
    p.File = marshall.bin__int64 (bi)
    p.Moment = marshall.bin__int64 (bi)
    p.Desc = marshall.bin__str (bi)

    return p
}


export const bin__FBIND = (bi:BinIndexed):wyi.FBIND => {

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


export const pMOMENT__bin = (bb:BytesBuilder) => (p:wyi.pMOMENT) => {

    
    marshall.str__bin (bb) (p.Title)
    
    marshall.str__bin (bb) (p.Summary)
    
    marshall.str__bin (bb) (p.FullText)
    
    marshall.str__bin (bb) (p.PreviewImgUrl)
    
    marshall.str__bin (bb) (p.Link)
    
    marshall.int32__bin (bb) (p.Type)
    
    marshall.int32__bin (bb) (p.State)
    
    marshall.int32__bin (bb) (p.MediaType)
}

export const MOMENT__bin = (bb:BytesBuilder) => (v:wyi.MOMENT) => {
    marshall.int64__bin (bb) (v.id)
    marshall.int64__bin (bb) (v.sort)
    marshall.DateTime__bin (bb) (v.createdat)
    marshall.DateTime__bin (bb) (v.updatedat)

    pMOMENT__bin (bb) (v.p)
}

export const bin__pMOMENT = (bi:BinIndexed):wyi.pMOMENT => {

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


export const bin__MOMENT = (bi:BinIndexed):wyi.MOMENT => {

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

// [CONFIG] Structure


export const pCONFIG__bin = (bb:BytesBuilder) => (p:wyi.pCONFIG) => {

    
    marshall.str__bin (bb) (p.Key)
    
    marshall.str__bin (bb) (p.Val)
}

export const CONFIG__bin = (bb:BytesBuilder) => (v:wyi.CONFIG) => {
    marshall.int64__bin (bb) (v.id)
    marshall.int64__bin (bb) (v.sort)
    marshall.DateTime__bin (bb) (v.createdat)
    marshall.DateTime__bin (bb) (v.updatedat)

    pCONFIG__bin (bb) (v.p)
}

export const bin__pCONFIG = (bi:BinIndexed):wyi.pCONFIG => {

    let p = pCONFIG_empty()
    p.Key = marshall.bin__str (bi)
    p.Val = marshall.bin__str (bi)

    return p
}


export const bin__CONFIG = (bi:BinIndexed):wyi.CONFIG => {

    let ID = marshall.bin__int64 (bi)
    let Sort = marshall.bin__int64 (bi)
    let Createdat = marshall.bin__DateTime (bi)
    let Updatedat = marshall.bin__DateTime (bi)
    
    return {
        id: ID,
        sort: Sort,
        createdat: Createdat,
        updatedat: Updatedat,
        p:  bin__pCONFIG (bi)
    }
}

// [LOG] Structure


export const pLOG__bin = (bb:BytesBuilder) => (p:wyi.pLOG) => {

    
    marshall.str__bin (bb) (p.Location)
    
    marshall.str__bin (bb) (p.Content)
    
    marshall.str__bin (bb) (p.Sql)
}

export const LOG__bin = (bb:BytesBuilder) => (v:wyi.LOG) => {
    marshall.int64__bin (bb) (v.id)
    marshall.int64__bin (bb) (v.sort)
    marshall.DateTime__bin (bb) (v.createdat)
    marshall.DateTime__bin (bb) (v.updatedat)

    pLOG__bin (bb) (v.p)
}

export const bin__pLOG = (bi:BinIndexed):wyi.pLOG => {

    let p = pLOG_empty()
    p.Location = marshall.bin__str (bi)
    p.Content = marshall.bin__str (bi)
    p.Sql = marshall.bin__str (bi)

    return p
}


export const bin__LOG = (bi:BinIndexed):wyi.LOG => {

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


export const pPLOG__bin = (bb:BytesBuilder) => (p:wyi.pPLOG) => {

    
    marshall.str__bin (bb) (p.Ip)
    
    marshall.str__bin (bb) (p.Request)
}

export const PLOG__bin = (bb:BytesBuilder) => (v:wyi.PLOG) => {
    marshall.int64__bin (bb) (v.id)
    marshall.int64__bin (bb) (v.sort)
    marshall.DateTime__bin (bb) (v.createdat)
    marshall.DateTime__bin (bb) (v.updatedat)

    pPLOG__bin (bb) (v.p)
}

export const bin__pPLOG = (bi:BinIndexed):wyi.pPLOG => {

    let p = pPLOG_empty()
    p.Ip = marshall.bin__str (bi)
    p.Request = marshall.bin__str (bi)

    return p
}


export const bin__PLOG = (bi:BinIndexed):wyi.PLOG => {

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
export const euAuthTypeEnum_Normal = 0 // Normal
export const euAuthTypeEnum_Authorized = 1 // Authorized
export const euAuthTypeEnum_Admin = 2 // Admin

export const pEU_empty = (): wyi.pEU => {
    return {
        Caption: "",
        Username: "",
        Email: "",
        Avatar: "",
        ClerkUserID: "",
        Pwd: "",
        AuthType: 0 }
}

export const EU_empty = (): wyi.EU => {
    return {
        id: 0,
        createdat: new Date(),
        updatedat: new Date(),
        sort: 0,
        p: pEU_empty() }
}

export const fileStateEnum_Normal = 0 // Normal
export const fileStateEnum_Failed = 1 // Failed

export const pFILE_empty = (): wyi.pFILE => {
    return {
        Caption: "",
        Path: "",
        State: 0,
        ContentType: "",
        Suffix: "",
        Size: 0,
        Thumbnail: [],
        Owner: 0,
        Cat: 0,
        Provider: 0,
        Unit: 0,
        Bill: 0 }
}

export const FILE_empty = (): wyi.FILE => {
    return {
        id: 0,
        createdat: new Date(),
        updatedat: new Date(),
        sort: 0,
        p: pFILE_empty() }
}

export const pUNIT_empty = (): wyi.pUNIT => {
    return {
        Caption: "",
        Owner: 0,
        UnitNum: "",
        AcctNum: "",
        Address: "",
        Town: "",
        State: "",
        Zip: "" }
}

export const UNIT_empty = (): wyi.UNIT => {
    return {
        id: 0,
        createdat: new Date(),
        updatedat: new Date(),
        sort: 0,
        p: pUNIT_empty() }
}

export const pUACCT_empty = (): wyi.pUACCT => {
    return {
        Cat: 0,
        Provider: 0,
        client: 0,
        Unit: 0,
        AcctNum: "" }
}

export const UACCT_empty = (): wyi.UACCT => {
    return {
        id: 0,
        createdat: new Date(),
        updatedat: new Date(),
        sort: 0,
        p: pUACCT_empty() }
}

export const pUBILL_empty = (): wyi.pUBILL => {
    return {
        ShownProvider: "",
        ShownUnitNum: "",
        ShownAcctNum: "",
        ShownAcctName: "",
        ShownAddr: "",
        ShownTown: "",
        ShownState: "",
        ShownZip: "",
        Cat: 0,
        Provider: 0,
        Owner: 0,
        Unit: 0,
        UnitText: "",
        UAcct: 0,
        Amt: 0.0 }
}

export const UBILL_empty = (): wyi.UBILL => {
    return {
        id: 0,
        createdat: new Date(),
        updatedat: new Date(),
        sort: 0,
        p: pUBILL_empty() }
}

export const pUCAT_empty = (): wyi.pUCAT => {
    return {
        Caption: "" }
}

export const UCAT_empty = (): wyi.UCAT => {
    return {
        id: 0,
        createdat: new Date(),
        updatedat: new Date(),
        sort: 0,
        p: pUCAT_empty() }
}

export const pUPROVIDER_empty = (): wyi.pUPROVIDER => {
    return {
        Caption: "",
        Cat: 0 }
}

export const UPROVIDER_empty = (): wyi.UPROVIDER => {
    return {
        id: 0,
        createdat: new Date(),
        updatedat: new Date(),
        sort: 0,
        p: pUPROVIDER_empty() }
}

export const pFBIND_empty = (): wyi.pFBIND => {
    return {
        File: 0,
        Moment: 0,
        Desc: "" }
}

export const FBIND_empty = (): wyi.FBIND => {
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

export const pMOMENT_empty = (): wyi.pMOMENT => {
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

export const MOMENT_empty = (): wyi.MOMENT => {
    return {
        id: 0,
        createdat: new Date(),
        updatedat: new Date(),
        sort: 0,
        p: pMOMENT_empty() }
}

export const pCONFIG_empty = (): wyi.pCONFIG => {
    return {
        Key: "",
        Val: "" }
}

export const CONFIG_empty = (): wyi.CONFIG => {
    return {
        id: 0,
        createdat: new Date(),
        updatedat: new Date(),
        sort: 0,
        p: pCONFIG_empty() }
}

export const pLOG_empty = (): wyi.pLOG => {
    return {
        Location: "",
        Content: "",
        Sql: "" }
}

export const LOG_empty = (): wyi.LOG => {
    return {
        id: 0,
        createdat: new Date(),
        updatedat: new Date(),
        sort: 0,
        p: pLOG_empty() }
}

export const pPLOG_empty = (): wyi.pPLOG => {
    return {
        Ip: "",
        Request: "" }
}

export const PLOG_empty = (): wyi.PLOG => {
    return {
        id: 0,
        createdat: new Date(),
        updatedat: new Date(),
        sort: 0,
        p: pPLOG_empty() }
}
