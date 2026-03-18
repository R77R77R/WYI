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

// [RuntimeData]
export type RuntimeData = {
desc:string
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
