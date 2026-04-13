module Server.Deploy

open System
open System.Diagnostics
open System.Runtime.InteropServices

open Util.Bash

let Bash output server 
    (devDir, deployDir) 
    (gitName, gitEmail) = 

    output (cyan $">>> 开始部署至 {server}...")

    // 1. 本地 Git 操作 (使用空格修复之前的 'add.' 错误)
    [|
        $"config user.name \"{gitName}\""
        $"config user.email \"{gitEmail}\""
        "add ." // 确保 add 和 . 之间有空格
        "commit -m \"auto-deploy\""
        "push"
    |]
    |> Array.iter (fun args -> exec output devDir @"C:\Program Files\Git\bin\git.exe" args |> ignore)

    // 2. 远程 SSH 操作
    // 注意：远程执行 dotnet run 时建议加上 nohup 或确保你希望持续观察输出
    let remoteCommands = 

        if false then
            [|
                $"cd ~/{deployDir}"
                "git fetch --all"
                "git reset --hard origin/main"
                "sudo killall -9 dotnet || true"
                "sudo fuser -k 80/tcp || true"
                "sudo fuser -k 443/tcp || true"
                $"cd ~/{deployDir}/vscode"
                "/root/.bun/bin/bun install"
                "/root/.bun/bin/bun add vite @vitejs/plugin-vue @vitejs/plugin-vue-jsx @vitejs/plugin-basic-ssl -D"
                "/root/.bun/bin/bun generateRoutes.cjs"
                "/root/.bun/bin/bunx --/root/.bun/bin/bun vite build --emptyOutDir"
                "cd .."
                "cd Server"
                "sudo dotnet run"
                |]
        else
            [|  "cd ~/Dev"
                "rm -rf WYI"
                "rm -rf JCS"
                "rm -rf Common"
                "dotnet nuget locals all --clear"
                "git clone https://github.com/lchenmay/Common/ Common"
                "git clone https://github.com/lchenmay/JCS/ JCS"
                "git clone https://github.com/R77R77R/WYI/ WYI"
                $"cd ~/{deployDir}/vscode"
                "/root/.bun/bin/bun install"
                "/root/.bun/bin/bun add vite @vitejs/plugin-vue @vitejs/plugin-vue-jsx @vitejs/plugin-basic-ssl -D"
                "/root/.bun/bin/bun generateRoutes.cjs"
                "/root/.bun/bin/bunx --/root/.bun/bin/bun vite build --emptyOutDir"
                "cd .."
                "cd Server"
                "dotnet restore --no-cache"
                "dotnet build"
                "dotnet run"
                |]

    remoteCommands
    |> bash output "root" server 