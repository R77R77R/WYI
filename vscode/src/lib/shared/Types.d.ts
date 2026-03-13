declare global {

namespace studio {


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
books:Array<BOOK>
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
