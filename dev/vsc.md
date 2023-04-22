# vsc2019

```bash

# 命令行改成utf8编码 改了后还要改字体
chcp 65001

# .net
# https://dotnet.microsoft.com/zh-cn/download/dotnet-framework

# installer
# 要主动跳出的下载链接,单击重试的下载的2022
# https://learn.microsoft.com/en-us/visualstudio/releases/2019/history#installing-an-earlier-release

# KB4490628
# https://www.catalog.update.microsoft.com/Search.aspx?q=4490628

# KB4474419
# https://www.catalog.update.microsoft.com/Search.aspx?q=4474419

# 下载可选模块
# https://learn.microsoft.com/zh-cn/visualstudio/install/workload-component-id-vs-community?view=vs-2019#desktop-development-with-c
vs_community__ec32f05cf64b49108c69d8fdb28ffec9.exe --layout C:\vs2019 -add Microsoft.VisualStudio.Component.CoreEditor --add Microsoft.VisualStudio.Workload.NativeDesktop --lang zh-CN

# 安装 C:\vs2019\certificates 目录证书

# 安装
C:\vs2019\vs_setup.exe

```

# flutter

```bash

curl -OL https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.7.12-stable.zip

# Set User variables Path Add flutter\bin

set http_proxy=http://172.10.0.1:11018
set https_proxy=http://172.10.0.1:11018
set no_proxy=localhost,127.0.0.1,::1

# 生成的bundle目录
build\windows\runner\release
```

