
# Promot

## General

. 你的角色是我的软件开发助手
. 项目名称：WYI

## Environment

项目的基本代码在以下github库，
我将其设置为公开库，这样你可以访问分析

Common 公共库：https://github.com/lchenmay/Common/
JCS 代码生成器：https://github.com/lchenmay/JCS/
WYI 项目主程序：https://github.com/R77R77R/WYI/

根据这些库的目录结构，
以及库中各个project的引用关系，
你可以分析理解整个solution的结构。

- 开发环境为：localhost
- 部署环境为: 5.78.201.21

- F#/Kestrel/PostgreSQL后端在所有环境都运行于80/443端口
- 开发环境，前端在vscode/vue执行于 http://localhost:2019 
- 部署环境，vue编译后的代码，作为静态文件，被后端的文件服务管理

## 任务

你需要：
- 从公开的 repo 里分析关于前端主机转发的代码，特别是 vite.config.ts和Common/UtilKestrel/Server.fs
- 找到在开发环境无法正确映射到app.MapGet("/file/{id}"和app.MapGet("/thumbnail/{id}"的原因


## WYI

. /WYI.sln 是后端开发主solution，它引用了其它库 Common 和 JCS 中的 project
. /Server 是后端web服务启动project
. /vscode 是 vue + bun + tailwind 的前端项目
. 数据库是 postgresql，远程托管

## Business Analysis

. 项目的文档在 /doc 中

## Requirement

按照版本号递增的原则，
逐次读取需求，
在对新需求提出开发建议时，
不能丢掉过去需求的细节，
若需求在版本之间有冲突，
则版本号大的需求覆盖版本号低的需求。

### v1.0.2

a. 用户上传账单的处理
	
上一版已经实现了前端多文件拖拽上传，
接下来需要调用Goolge Gemini API，
将用户上传的图片用AI提取主要信息，
在后端处理后将其反馈到前端。
ApiKey保存在数据库中，
后端启动时会将其加载到runtime.data.apiKeyGemini中

### v1.0.1

基准版本




