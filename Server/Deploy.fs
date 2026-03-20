module Server.Deploy

open System
open System.Diagnostics
open System.Runtime.InteropServices



let Bash output server (devDir,deployDir) (gitName,gitEmail) = 

    (*
    // ssh root@5.78.201.21 免密码登录，本地配置

    ssh-keygen -t ed25519
    $pubKey = Get-Content "$HOME\.ssh\id_ed25519.pub"
    ssh root@5.78.201.21 "mkdir -p ~/.ssh && echo '$pubKey' >> ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"
    *)

    // ANSI 颜色处理
    let cyan (s: string) = $"\u001b[36m{s}\u001b[0m"
    let green (s: string) = $"\u001b[32m{s}\u001b[0m"
    let red (s: string) = $"\u001b[31m{s}\u001b[0m"

    /// 在本地执行指令（如 ssh）
    let exec setDir (fileName: string) (args: string) =

        fileName + ": " + args |> cyan |> output

        let psi = ProcessStartInfo(fileName, args)
        if setDir <> "" then
            psi.WorkingDirectory <- setDir
        psi.RedirectStandardOutput <- true
        psi.RedirectStandardError <- true
        psi.UseShellExecute <- false
        psi.CreateNoWindow <- true
        
        use proc = Process.Start(psi)
        let res = proc.StandardOutput.ReadToEnd()
        let error = proc.StandardError.ReadToEnd()
        proc.WaitForExit()

        if proc.ExitCode = 0 then
            "OK: " + res |> green |> output
        else
            "ExitCode " + proc.ExitCode.ToString() + ": " + error |> red |> output

        (proc.ExitCode, res, error)

    /// 执行远程部署
    printfn "%s" (cyan $">>> 开始部署至 {server}...")

    /// 提交git
    [|  "config user.name \"" + gitName + "\""
        "config user.email \"" + gitEmail + "\""
        "add ."
        "commit -m \".\""
        "push" |]
    |> Array.map(exec devDir "git")
    |> ignore

    let remoteCommands = 
        [|  $"cd {deployDir}"
            "git pull"
            "sudo fuser -k 443/tcp || true" // 如果没有进程在跑，也继续执行
            "cd Server"
            "sudo dotnet run" |]
        |> String.concat " && "

    let cmd = $"root@{server} \"{remoteCommands}\""
    exec "ssh" cmd
    |> ignore


