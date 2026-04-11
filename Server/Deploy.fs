module Server.Deploy

open System
open System.Diagnostics
open System.Runtime.InteropServices

let Bash output server (devDir, deployDir) (gitName, gitEmail) = 

    // ANSI 颜色处理
    let cyan (s: string) = $"\u001b[36m{s}\u001b[0m"
    let green (s: string) = $"\u001b[32m{s}\u001b[0m"
    let red (s: string) = $"\u001b[31m{s}\u001b[0m"

    /// 改进后的即时执行函数
    let exec setDir (fileName: string) (args: string) =
        $"{fileName}: {args}" |> cyan |> output

        let psi = ProcessStartInfo(fileName, args)
        if not (String.IsNullOrWhiteSpace setDir) then
            psi.WorkingDirectory <- setDir
        
        psi.RedirectStandardOutput <- true
        psi.RedirectStandardError <- true
        psi.UseShellExecute <- false
        psi.CreateNoWindow <- true

        use proc = new Process(StartInfo = psi)

        // 订阅输出事件，实现即时获取
        proc.OutputDataReceived.Add(fun e -> 
            if not (String.IsNullOrEmpty e.Data) then 
                e.Data |> output)

        proc.ErrorDataReceived.Add(fun e -> 
            if not (String.IsNullOrEmpty e.Data) then 
                // 某些工具（如 git）会将进度信息发往 stderr
                e.Data |> output)

        proc.Start() |> ignore
        
        // 开始异步读取流
        proc.BeginOutputReadLine()
        proc.BeginErrorReadLine()
        
        proc.WaitForExit()

        if proc.ExitCode <> 0 then
            $"ExitCode {proc.ExitCode}" |> red |> output

        (proc.ExitCode, "", "") // 由于是即时输出，不再返回完整的 res 字符串

    output (cyan $">>> 开始部署至 {server}...")

    // 1. 本地 Git 操作 (使用空格修复之前的 'add.' 错误)
    [|
        $"config user.name \"{gitName}\""
        $"config user.email \"{gitEmail}\""
        "add ." // 确保 add 和 . 之间有空格
        "commit -m \"auto-deploy\""
        "push"
    |]
    |> Array.iter (fun args -> exec devDir @"C:\Program Files\Git\bin\git.exe" args |> ignore)

    // 2. 远程 SSH 操作
    // 注意：远程执行 dotnet run 时建议加上 nohup 或确保你希望持续观察输出
    let remoteCommands = 
        [|
            $"cd {deployDir}"
            "git fetch --all"
            "git reset --hard origin/main"
            "sudo killall -9 dotnet || true"
            "sudo fuser -k 80/tcp || true"
            "sudo fuser -k 443/tcp || true"
            "cd Server"
            "sudo dotnet run" // 如果这里不加 &，ssh 会一直保持连接并即时回传日志
        |]
        |> String.concat " && "

    let remoteCommandsFull = 
        [|  "cd Dev"
            "rm -rf WYI"
            "rm -rf JCS"
            "rm -rf Common"
            "dotnet nuget locals all --clear"
            "git clone https://github.com/lchenmay/Common/ Common"
            "git clone https://github.com/lchenmay/JCS/ JCS"
            "git clone https://github.com/R77R77R/WYI/ WYI"
            "cd Server"
            "dotnet restore"
            "dotnet build"
            "dotnet run"
            |]

    $"root@{server} \"{remoteCommands}\"" 
    |> exec "" "ssh" 
    |> ignore