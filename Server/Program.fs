module Server.Program

open System
open System.Text
open System.IO
open System.Diagnostics

open UtilKestrel.Types
open UtilKestrel.Common
open UtilKestrel.Server

open WYI.BizLogics.Common

(*
在ubuntu上，我把名为WYI的项目放在 /Dev/WYI 下，
/Dev/WYI/Server/bin/Debug/net10.0 是Kestrel的运行目录，
/Dev/WYI/vscode/dist 是Vue的打包目录，
/FsRoot/WYI 是文件服务的根目录。
需求改进要点：
1. 对于 /api/{module}/{api} 类型的请求，分发到 Kestrel 的 echo服务中，
对请求以 UTF8 获取字符串，返回为 UTF8 字符串，
具体的请求/响应逻辑，调用我写的其它库来实现；
2. 对于 /file/{id} 类型的请求，调用我写的文件服务，并返回文件，可能是很大的文件；
3. 其它请求转入 Vue 的打包目录，并以静态文件方式返回
*)


[<EntryPoint>]
let main argv =

    let deployHost = "5.78.201.21"
    let devOrDeploy = 
        match Environment.MachineName with
        | "ubuntu-2gb-hil-1" -> false
        | _ -> true

    if devOrDeploy then
        TypeSys.CodeRobot.go 
            output 
            @"C:\Dev\JCS\TypeSys\bin\Debug\net10.0"
            {
                ns = "WYI.Shared"
                rdbms = Util.Db.Rdbms.PostgreSql
                dbName = "wyi"
                donmainName = ""
                conn = @"Host=" + deployHost + ";Port=5432;Database=wyi;Username=wyi;Password=e2TpqcaTEYLfkvFMkc"
                mainDir = @"C:\Dev\WYI\WYI.Shared"
                JsDir = @"C:\Dev\WYI\vscode\src\lib\shared" }
        //JCS.BizLogics.Common.runtime.data.projectxs[234354L] 
        //|> JCS.BizLogics.CodeRobot.runProject

    let devRoot,fsRoot,vueDistPath,cert,certpwd = 
        WYI.BizLogics.Launcher.launch()

    "DevRoot: " + devRoot |> output
    "FsRoot: " + fsRoot |> output
    "VueDistPath: " + vueDistPath |> output

    "Cert: " + cert |> output
    "CertPwd: " + certpwd |> output

    if false then
    //if devOrDeploy then
        async {
            Server.Deploy.Bash
                output 
                deployHost
                (devRoot,"Dev/WYI")
                ("R","siduochen@hotmail.com")
        } |> Async.Start // 立即在线程池开始执行


    // https://5.78.201.21
    // https://localhost/api/public/ping
    
    runServer 
        runtime
        (devRoot,fsRoot,vueDistPath) 
        (cert,certpwd)
        WYI.BizLogics.Branch.branch
        (80,443)
        output
        [||]

    Util.Runtime.halt output "" ""

    0
