declare global {

namespace wyi {

// [Ca_EndUser] (EU)


export type pEU = {
[key:string]: any
    Caption: string
    AuthType: number
}

export type EU = {
id:number
createdat:Date
updatedat:Date
sort:number
p:pEU
}

// [Ca_File] (FILE)

export type pFILE = {
[key:string]: any
    Caption: string
    Desc: string
    Suffix: string
    Size: number
    Thumbnail: array
    Owner: number
}

export type FILE = {
id:number
createdat:Date
updatedat:Date
sort:number
p:pFILE
}

// [Social_FileBind] (FBIND)

export type pFBIND = {
[key:string]: any
    File: number
    Moment: number
    Desc: string
}

export type FBIND = {
id:number
createdat:Date
updatedat:Date
sort:number
p:pFBIND
}

// [Social_Moment] (MOMENT)




export type pMOMENT = {
[key:string]: any
    Title: string
    Summary: string
    FullText: string
    PreviewImgUrl: string
    Link: string
    Type: number
    State: number
    MediaType: number
}

export type MOMENT = {
id:number
createdat:Date
updatedat:Date
sort:number
p:pMOMENT
}

// [Sys_Log] (LOG)

export type pLOG = {
[key:string]: any
    Location: string
    Content: string
    Sql: string
}

export type LOG = {
id:number
createdat:Date
updatedat:Date
sort:number
p:pLOG
}

// [Sys_PageLog] (PLOG)

export type pPLOG = {
[key:string]: any
    Ip: string
    Request: string
}

export type PLOG = {
id:number
createdat:Date
updatedat:Date
sort:number
p:pPLOG
}


}

}

export {}
