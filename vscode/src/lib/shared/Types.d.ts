declare global {

namespace wyi {


// [AcctComplex]
export type AcctComplex = {
cato:UCAT | null,

providero:UPROVIDER | null,

owner:EU,

unito:UNIT | null,

acct:UACCT
}

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

// [PoolComplex]
export type PoolComplex = {
cato:UCAT | null,

providero:UPROVIDER | null,

manager:EU,

billxs:{[key:number]: BillComplex},

pool:POOL
}

// [EuComplex]
export type EuComplex = {
units:{[key:number]: UNIT},

acctxs:{[key:number]: AcctComplex},

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

providers:{[key:number]: UPROVIDER},

poolxs:{[key:number]: PoolComplex},

catproviders:KUCP[]
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
