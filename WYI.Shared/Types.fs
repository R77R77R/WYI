module WYI.Shared.Types

open System
open System.Collections.Generic
open System.Collections.Concurrent

open Util.Text
open Util.Json
open Util.CollectionModDict
open Util.Stat

open WYI.Shared.OrmTypes

//[TypeManaged]{

type AcctComplex = {
mutable cato: UCAT option
mutable providero: UPROVIDER option
mutable owner: EU
mutable unito: UNIT option 
acct: UACCT }

type BillComplex = {
mutable cato: UCAT option
mutable providero: UPROVIDER option
mutable owner: EU
mutable unito: UNIT option
mutable accto: UACCT option
mutable files: FILE[]
mutable poolo: POOL option
bill: UBILL }

type PoolComplex = {
mutable providero: UPROVIDER option
mutable manager: EU
mutable billxs: ModDictInt64<BillComplex>
pool: POOL }

type EuComplex = {
units: ModDictInt64<UNIT>
acctxs: ModDictInt64<AcctComplex>
billxs: ModDictInt64<BillComplex>
eu: EU }

type MomentComplex = {
m: MOMENT }

type RuntimeData = {
mutable apiKeyGemini: string
aiModel: string
cats: ModDictInt64<UCAT>
providers: ModDictInt64<UPROVIDER>
poolxs: ModDictInt64<PoolComplex>
mutable catproviders: KUCP[] }

type ClientRuntime = {
mutable version: int }

type ProviderView = {
cat: UCAT
billxs: BillComplex[]
pools: POOL[]
uprovider: UPROVIDER }

type Msg = 
| Heartbeat
| ApiRequest of Json
| ApiResponse of Json

type Er = 
| ApiNotExists
| InvalideParameter
| Unauthorized
| NotAvailable
| Internal
| API3rdParty

//}



