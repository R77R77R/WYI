module WYI.BizLogics.Launcher

open System
open System.Text
open System.IO
open System.Diagnostics

open Util.Bash
open Util.Perf
open Util.Runtime
open Util.Json
open Util.Http
open Util.HttpServer

open UtilKestrel.Common
open UtilKestrel.SSR

open WYI.Shared.Types
open WYI.Shared.CustomMor

open WYI.BizLogics.Common
open WYI.BizLogics.Init
open WYI.BizLogics.Branch
open WYI.BizLogics.SSR


let launch() =

    init runtime |> ignore

    let devRoot,fsRoot,vueDistPath = runtime.host.VsDirSolution,runtime.host.fsDir,runtime.host.VsDirSolution + "/vscode/dist"
    let cert = runtime.host.cert
    let certpwd = runtime.host.certpwd

    devRoot,fsRoot,vueDistPath,cert,certpwd
    (*
    runtime.listener.echo <- echo
    runtime.listener.h404o <- Some(fun _ -> 
        "404"
        |> System.Text.Encoding.ASCII.GetBytes
        |> bin__StandardResponse "text/html")
    runtime.listener.wsHandler <- fun json -> None
    
    startEngine runtime.listener
    *)
