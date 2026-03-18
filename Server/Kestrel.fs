module Server.Kestrel

open System
open System.IO
open System.Text
open System.Threading.Tasks
open Microsoft.AspNetCore.Builder
open Microsoft.AspNetCore.Http
open Microsoft.AspNetCore.Hosting
open Microsoft.Extensions.Hosting
open Microsoft.Extensions.DependencyInjection
open Microsoft.Extensions.FileProviders
open System.Net.WebSockets

let runServer 
    (devRoot,fsRoot,vueDistPath)
    (port80,port443)
    output (args: string[]) =

    let builder = WebApplication.CreateBuilder(args)

    // 强制监听标准端口 80 和 443
    // 注意：0.0.0.0 允许外部公网访问
    builder.WebHost.UseUrls("http://0.0.0.0:" + port80.ToString() + ";https://0.0.0.0:" + port443.ToString()) |> ignore

    // 1. 高性能 Kestrel 配置
    builder.WebHost.ConfigureKestrel(fun options ->
        options.Limits.MaxRequestBodySize <- Nullable(10L * 1024L * 1024L * 1024L) 
        options.Limits.MinRequestBodyDataRate <- null 
    ) |> ignore

    let app = builder.Build()

    // 启用 WebSocket 支持
    app.UseWebSockets() |> ignore

    // --- 路由与功能实现区 ---

    // 1. API 分发：/api/{scheme}/{api}
    app.MapPost("/api/{scheme}/{api}",
        Func<string, string, HttpContext, Task>(fun scheme api context -> task {
        context.Response.ContentType <- "application/json; charset=utf-8"
        
        use reader = new StreamReader(context.Request.Body, Encoding.UTF8)
        let! requestBody = reader.ReadToEndAsync()

        // 依然对接你的业务库逻辑
        let responseJson = 
            sprintf "{\"scheme\": \"%s\", \"api\": \"%s\", \"data\": %s}" scheme api requestBody
        let responseBytes = Encoding.UTF8.GetBytes(responseJson)
        
        do! context.Response.Body.WriteAsync(ReadOnlyMemory(responseBytes))
    })) |> ignore

    // 2. 文件服务：/file/{id} 映射到动态计算的 fsRoot
    app.MapGet("/file/{id}", Func<string, HttpContext, Task<IResult>>(fun id context -> task {
        let fullPath = Path.Combine(fsRoot, id) 
        if File.Exists(fullPath) then
            // 支持大文件断点续传
            return Results.File(fullPath, enableRangeProcessing = true)
        else 
            return Results.NotFound()
    })) |> ignore

    // 3. Vue 静态文件托管
    if Directory.Exists(vueDistPath) then
        let fileServerOptions = StaticFileOptions()
        fileServerOptions.FileProvider <- new PhysicalFileProvider(vueDistPath)
        app.UseStaticFiles(fileServerOptions) |> ignore

        // 4. 兜底处理：SPA 路由支持
        app.MapFallback(Func<HttpContext, Task>(fun context -> task {
            let indexPath = Path.Combine(vueDistPath, "index.html")
            if File.Exists(indexPath) then
                context.Response.ContentType <- "text/html"
                do! context.Response.SendFileAsync(indexPath)
            else
                context.Response.StatusCode <- 404
        })) |> ignore

    app.Run()