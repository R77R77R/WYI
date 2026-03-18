module Server.Kestrel

open System
open System.IO
open System.Threading.Tasks
open Microsoft.AspNetCore.Builder
open Microsoft.AspNetCore.Http
open Microsoft.AspNetCore.Hosting
open Microsoft.Extensions.Hosting
open Microsoft.Extensions.DependencyInjection
open System.Net.WebSockets

let runServer (args: string[]) =
    let builder = WebApplication.CreateBuilder(args)

    // 1. 高性能 Kestrel 配置 (针对大文件和并发优化)
    builder.WebHost.ConfigureKestrel(fun options ->
        // 支持 10GB 大文件上传
        options.Limits.MaxRequestBodySize <- Nullable(10L * 1024L * 1024L * 1024L) 
        // 禁用最低速率限制，防止大文件传输时被断开
        options.Limits.MinRequestBodyDataRate <- null 
    ) |> ignore

    let app = builder.Build()

    // 2. 基础中间件配置
    app.UseWebSockets() |> ignore

    // --- 路由与功能实现区 ---

    // A. 根目录与健康检查 (防止 404)
    app.MapGet("/", Func<IResult>(fun () -> 
        Results.Content("F# High-Performance Server: Online", "text/plain"))) |> ignore

    // B. 二进制 Echo 服务器 (高性能流式处理)
    app.MapPost("/echo", Func<HttpContext, Task>(fun context -> task {
        context.Response.ContentType <- "application/octet-stream"
        // 直接流拷贝，内存占用极低
        do! context.Request.Body.CopyToAsync(context.Response.Body)
    })) |> ignore

    // C. 自定义文件服务 (支持断点续传)
    app.MapGet("/files/{*filepath}", Func<string, HttpContext, Task<IResult>>(fun filepath context -> task {
        // 建议路径改为你服务器上的实际目录
        let fullPath = Path.Combine("/var/www/myfiles", filepath) 
        if File.Exists(fullPath) then
            // enableRangeProcessing: true 是实现 HTTP 断点续传的关键
            return Results.File(fullPath, enableRangeProcessing = true)
        else 
            return Results.NotFound()
    })) |> ignore

    // D. 大文件上传 (流式写入本地临时文件)
    app.MapPost("/upload", Func<HttpContext, Task<IResult>>(fun context -> task {
        let tempPath = Path.Combine(Path.GetTempPath(), Guid.NewGuid().ToString() + ".tmp")
        // 使用 FileOptions.Asynchronous 优化 I/O
        use fileStream = new FileStream(tempPath, FileMode.Create, FileAccess.Write, FileShare.None, 4096, true)
        do! context.Request.Body.CopyToAsync(fileStream)
        return Results.Ok(sprintf "Saved to %s" tempPath)
    })) |> ignore

    // E. WebSocket 拦截 (显式指定委托类型修复编译错误)
    app.Use(Func<HttpContext, RequestDelegate, Task>(fun context next -> task {
        if context.Request.Path = PathString("/ws") then
            if context.WebSockets.IsWebSocketRequest then
                let! webSocket = context.WebSockets.AcceptWebSocketAsync()
                
                // 简单的消息循环示例
                let buffer = Array.create 4096 (byte 0)
                let mutable isClosed = false
                while not isClosed do
                    let! result = webSocket.ReceiveAsync(ArraySegment(buffer), Threading.CancellationToken.None)
                    if result.MessageType = WebSocketMessageType.Close then
                        do! webSocket.CloseAsync(WebSocketCloseStatus.NormalClosure, "Closed by server", Threading.CancellationToken.None)
                        isClosed <- true
                return ()
            else
                context.Response.StatusCode <- 400
                return ()
        else
            // 调用中间件管道中的下一个组件
            return! next.Invoke(context)
    })) |> ignore

    app.Run()