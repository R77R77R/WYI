declare global {

namespace wyi {

// [Ca_EndUser] (EU)


export type pEU = {
[key:string]: any
    Caption: string
    Username: string
    Email: string
    Avatar: string
    ClerkUserID: string
    Pwd: string
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
    Path: string
    State: number
    ContentType: string
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

// [Kernel_Client] (CLIENT)

export type pCLIENT = {
[key:string]: any
    Caption: string
}

export type CLIENT = {
id:number
createdat:Date
updatedat:Date
sort:number
p:pCLIENT
}

// [Kernel_Unit] (UNIT)

export type pUNIT = {
[key:string]: any
    Caption: string
}

export type UNIT = {
id:number
createdat:Date
updatedat:Date
sort:number
p:pUNIT
}

// [Kernel_UtilBill] (UBILL)

export type pUBILL = {
[key:string]: any
    Cat: number
    Provider: number
    client: number
    Unit: number
    Amout: number
}

export type UBILL = {
id:number
createdat:Date
updatedat:Date
sort:number
p:pUBILL
}

// [Kernel_UtilCat] (UCAT)

export type pUCAT = {
[key:string]: any
    Caption: string
}

export type UCAT = {
id:number
createdat:Date
updatedat:Date
sort:number
p:pUCAT
}

// [Kernel_UtilProvider] (UPROVIDER)

export type pUPROVIDER = {
[key:string]: any
    Caption: string
    Cat: number
}

export type UPROVIDER = {
id:number
createdat:Date
updatedat:Date
sort:number
p:pUPROVIDER
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

// [Sys_Config] (CONFIG)

export type pCONFIG = {
[key:string]: any
    Key: string
    Val: string
}

export type CONFIG = {
id:number
createdat:Date
updatedat:Date
sort:number
p:pCONFIG
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
