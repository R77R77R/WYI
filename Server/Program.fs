module Server.Launching

open System
open System.Text
open System.IO
open System.Diagnostics

open UtilWebServer.Common

[<EntryPoint>]
let main argv =

    "Machine Name: " + Environment.MachineName
    |> System.Console.WriteLine 

    //WYI.BizLogics.Launcher.launch()

    //Util.Runtime.halt output "" ""

    0
