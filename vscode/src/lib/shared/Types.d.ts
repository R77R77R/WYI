declare global {

namespace wyi {


// [BillComplex]
export type BillComplex = {
cato:UCAT | null,

providero:UPROVIDER | null,

owner:EU,

unito:UNIT | null,

accto:UACCT | null,

files:FILE[],

bill:UBILL
}

// [EuComplex]
export type EuComplex = {
units:{[key:number]: UNIT},

billxs:{[key:number]: BillComplex},

eu:EU
}

// [MomentComplex]
export type MomentComplex = {
m:MOMENT
}

// [RuntimeData]
export type RuntimeData = {
apiKeyGemini:string,

aiModel:string,

cats:{[key:number]: UCAT},

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
