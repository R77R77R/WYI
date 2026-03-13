module Studio.Shared.Types

open System
open System.Collections.Generic
open System.Collections.Concurrent

open Util.Text
open Util.Json
open Util.CollectionModDict
open Util.Stat

open Studio.Shared.OrmTypes

//[TypeManaged]{

type EuComplex = {
eu: EU }

type MomentComplex = {
m: MOMENT }

type RuntimeData = {
books: List<BOOK> }

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



