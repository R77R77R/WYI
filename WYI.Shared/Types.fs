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

type BillComplex = {
mutable cato: UCAT option
mutable providero: UPROVIDER option
mutable owner: EU
mutable unito: UNIT option
mutable accto: UACCT option
mutable files: FILE[]
bill: UBILL }

type EuComplex = {
units: ModDictInt64<UNIT>
billxs: ModDictInt64<BillComplex>
eu: EU }

type MomentComplex = {
m: MOMENT }


type RuntimeData = {
mutable apiKeyGemini: string
aiModel: string
cats: ModDictInt64<UCAT>
providers: ModDictInt64<UPROVIDER>
mutable catproviders: KUCP[] }

type ClientRuntime = {
mutable version: int }

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



