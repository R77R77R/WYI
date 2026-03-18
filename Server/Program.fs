module Server.Launching

open System
open System.Text
open System.IO
open System.Diagnostics

open UtilWebServer.Common

[<EntryPoint>]
let main argv =

    TypeSys.CodeRobot.go 
        output 
        @"C:\Dev\JCS\TypeSys\bin\Debug\net10.0"
        {
            ns = "WYI.Shared"
            rdbms = Util.Db.Rdbms.PostgreSql
            dbName = "wyi"
            donmainName = ""
            conn = @"Host=178.156.223.41;Port=5432;Database=wyi;Username=wyi;Password=e2TpqcaTEYLfkvFMkc"
            mainDir = @"C:\Dev\WYI\WYI.Shared"
            JsDir = @"C:\Dev\WYI\vscode\src\lib\shared" }
    //JCS.BizLogics.Common.runtime.data.projectxs[234354L] 
    //|> JCS.BizLogics.CodeRobot.runProject


    WYI.BizLogics.Launcher.launch()

    Util.Runtime.halt output "" ""

    0
