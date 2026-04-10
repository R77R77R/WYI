// OrmMor.ts
import { BinIndexed, BytesBuilder } from "~/lib/util/bin"
import * as binCommon from '~/lib/util/bin'
import * as binOrm from './OrmMor'
const marshall = {...binCommon, ...binOrm }

export const enum MsgEnum {
    Heartbeat = 0,//Heartbeat
    ApiRequest = 1,//ApiRequest
    ApiResponse = 2,//ApiResponse
}

export const enum ErEnum {
    ApiNotExists = 0,//ApiNotExists
    InvalideParameter = 1,//InvalideParameter
    Unauthorized = 2,//Unauthorized
    NotAvailable = 3,//NotAvailable
    Internal = 4,//Internal
    API3rdParty = 5,//API3rdParty
}


// [BillComplex] Structure

export const BillComplex_empty = (): wyi.BillComplex => { 
    return {
        cato: null,
        providero: null,
        owner: { id: 0, sort: 0, createdat: new Date(), updatedat: new Date(), p: marshall.pEU_empty() },
        unito: null,
        accto: null,
        files: [],
        bill: { id: 0, sort: 0, createdat: new Date(), updatedat: new Date(), p: marshall.pUBILL_empty() },
    } as wyi.BillComplex
}

export const BillComplex__bin = (bb:BytesBuilder) => (v:any) => {

    marshall.option__bin (marshall.UCAT__bin) (bb) (v.cato)
    marshall.option__bin (marshall.UPROVIDER__bin) (bb) (v.providero)
    marshall.EU__bin (bb) (v.owner)
    marshall.option__bin (marshall.UNIT__bin) (bb) (v.unito)
    marshall.option__bin (marshall.UACCT__bin) (bb) (v.accto)
    
    marshall.array__bin (marshall.FILE__bin) (bb) (v.files)
    marshall.UBILL__bin (bb) (v.bill)
}

export const bin__BillComplex = (bi:BinIndexed):wyi.BillComplex => {

    return {
        cato: marshall.bin__option (marshall.bin__UCAT) (bi),
        providero: marshall.bin__option (marshall.bin__UPROVIDER) (bi),
        owner: marshall.bin__EU (bi),
        unito: marshall.bin__option (marshall.bin__UNIT) (bi),
        accto: marshall.bin__option (marshall.bin__UACCT) (bi),
        files: marshall.bin__array (marshall.bin__FILE) (bi),
        bill: marshall.bin__UBILL (bi),
    }
}

// [EuComplex] Structure

export const EuComplex_empty = (): wyi.EuComplex => { 
    return {
        units: {},
        billxs: {},
        eu: { id: 0, sort: 0, createdat: new Date(), updatedat: new Date(), p: marshall.pEU_empty() },
    } as wyi.EuComplex
}

export const EuComplex__bin = (bb:BytesBuilder) => (v:any) => {

    
    marshall.dict__bin (marshall.int64__bin)(marshall.UNIT__bin) (bb) (v.units)
    
    marshall.dict__bin (marshall.int64__bin)(BillComplex__bin) (bb) (v.billxs)
    marshall.EU__bin (bb) (v.eu)
}

export const bin__EuComplex = (bi:BinIndexed):wyi.EuComplex => {

    return {
        units: marshall.bin__dict(marshall.bin__int64)(marshall.bin__UNIT) (bi),
        billxs: marshall.bin__dict(marshall.bin__int64)(bin__BillComplex) (bi),
        eu: marshall.bin__EU (bi),
    }
}

// [MomentComplex] Structure

export const MomentComplex_empty = (): wyi.MomentComplex => { 
    return {
        m: { id: 0, sort: 0, createdat: new Date(), updatedat: new Date(), p: marshall.pMOMENT_empty() },
    } as wyi.MomentComplex
}

export const MomentComplex__bin = (bb:BytesBuilder) => (v:any) => {

    marshall.MOMENT__bin (bb) (v.m)
}

export const bin__MomentComplex = (bi:BinIndexed):wyi.MomentComplex => {

    return {
        m: marshall.bin__MOMENT (bi),
    }
}

// [RuntimeData] Structure

export const RuntimeData_empty = (): wyi.RuntimeData => { 
    return {
        apiKeyGemini: "",
        aiModel: "",
        cats: {},
        providers: {},
        catproviders: [],
    } as wyi.RuntimeData
}

export const RuntimeData__bin = (bb:BytesBuilder) => (v:any) => {

    marshall.str__bin (bb) (v.apiKeyGemini)
    marshall.str__bin (bb) (v.aiModel)
    
    marshall.dict__bin (marshall.int64__bin)(marshall.UCAT__bin) (bb) (v.cats)
    
    marshall.dict__bin (marshall.int64__bin)(marshall.UPROVIDER__bin) (bb) (v.providers)
    
    marshall.array__bin (marshall.KUCP__bin) (bb) (v.catproviders)
}

export const bin__RuntimeData = (bi:BinIndexed):wyi.RuntimeData => {

    return {
        apiKeyGemini: marshall.bin__str (bi),
        aiModel: marshall.bin__str (bi),
        cats: marshall.bin__dict(marshall.bin__int64)(marshall.bin__UCAT) (bi),
        providers: marshall.bin__dict(marshall.bin__int64)(marshall.bin__UPROVIDER) (bi),
        catproviders: marshall.bin__array (marshall.bin__KUCP) (bi),
    }
}

// [ClientRuntime] Structure

export const ClientRuntime_empty = (): wyi.ClientRuntime => { 
    return {
        version: 0,
    } as wyi.ClientRuntime
}

export const ClientRuntime__bin = (bb:BytesBuilder) => (v:any) => {

    marshall.int32__bin (bb) (v.version)
}

export const bin__ClientRuntime = (bi:BinIndexed):wyi.ClientRuntime => {

    return {
        version: marshall.bin__int32 (bi),
    }
}

// [Msg] Structure

export const Msg_empty = (): wyi.Msg => { 
    return {
    e:0, val:{}
    } as wyi.Msg
}

export const Msg__bin = (bb:BytesBuilder) => (v:any) => {

    marshall.int32__bin (bb) (v.e)
    switch (v.e) {
        case 0:
            break
        case 1:
            marshall.Json__bin (bb) (v.val)
            break
        case 2:
            marshall.Json__bin (bb) (v.val)
            break
    }
}

export const bin__Msg = (bi:BinIndexed):wyi.Msg => {

    let v:wyi.Msg = { e:0, val:{} }
    v.e = marshall.bin__int32 (bi)
    switch (v.e) {
        case 2:
            v.val = marshall.bin__Json (bi) 
            break
        case 1:
            v.val = marshall.bin__Json (bi) 
            break
        case 0:
            break
    }
    return v
}

// [Er] Structure

export const Er_empty = (): wyi.Er => { 
    return {
    e:0, val:{}
    } as wyi.Er
}

export const Er__bin = (bb:BytesBuilder) => (v:any) => {

    marshall.int32__bin (bb) (v.e)
    switch (v.e) {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
    }
}

export const bin__Er = (bi:BinIndexed):wyi.Er => {

    let v:wyi.Er = { e:0, val:{} }
    v.e = marshall.bin__int32 (bi)
    switch (v.e) {
        case 5:
            break
        case 4:
            break
        case 3:
            break
        case 2:
            break
        case 1:
            break
        case 0:
            break
    }
    return v
}