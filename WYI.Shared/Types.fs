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

type EuComplex = {
eu: EU }

type MomentComplex = {
m: MOMENT }

type BillComplex = {
mutable cato: UCAT option
mutable providero: UPROVIDER option
mutable cliento: CLIENT option
mutable unito: UNIT option
mutable accto: UACCT option
bill: UBILL }

type RuntimeData = {
mutable apiKeyGemini: string
aiModel: string
cats: ModDictInt64<UCAT>
bills: ModDictInt64<BillComplex>
providers: ModDictInt64<UPROVIDER> }

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

//}



