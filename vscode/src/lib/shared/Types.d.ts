declare global {

namespace wyi {


// [EuComplex]
export type EuComplex = {
eu:EU
}

// [MomentComplex]
export type MomentComplex = {
m:MOMENT
}

// [BillComplex]
export type BillComplex = {
cato:UCAT | null,

providero:UPROVIDER | null,

cliento:CLIENT | null,

unito:UNIT | null,

accto:UACCT | null,

bill:UBILL
}

// [RuntimeData]
export type RuntimeData = {
apiKeyGemini:string,

aiModel:string,

cats:{[key:number]: UCAT},

bills:{[key:number]: BillComplex},

providers:{[key:number]: UPROVIDER}
}

// [ClientRuntime]
export type ClientRuntime = {
version:number
}

// [Msg]
export type Msg = {
e: number,

val: any
}

// [Er]
export type Er = {
e: number,

val: any
}

}

}

export {}
