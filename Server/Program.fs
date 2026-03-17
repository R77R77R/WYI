module Server.Launching

open System
open System.Text
open System.IO
open System.Diagnostics

open UtilWebServer.Common

[<EntryPoint>]
let main argv =

    // wyi/e2TpqcaTEYLfkvFMkc
    
    TypeSys.CodeRobot.go 
        output 
        @"C:\Dev\JCS\TypeSys\bin\Debug\net10.0"
        {
            ns = "WYI.Shared"
            rdbms = Util.Db.Rdbms.PostgreSql
            dbName = "wyi"
            donmainName = ""
            conn = "server=127.0.0.1; user=sa; database=Studio"
            mainDir = @"C:\Dev\WYI\WYI.Shared"
            JsDir = @"C:\Dev\WYI\vscode\src\lib\shared" }
    //JCS.BizLogics.Common.runtime.data.projectxs[234354L] 
    //|> JCS.BizLogics.CodeRobot.runProject


    WYI.BizLogics.Launcher.launch()

    Util.Runtime.halt output "" ""

    0
