
# 软件

- SoftEther VPN Server  / l2tp Server

# 命令

```bash

# Win自带Hash
certutil -hashfile  <文件名>  <hash类型 SHA1/MD5/SHA256>

# 装usb驱动 https://zadig.akeo.ie/
zadig

# Wx撤回多开
# 附加 Wx -> 符号 -> WeChatWin.dll -> 搜索 -> 当前区域 -> 字符串 revokemsg -> 汇编jmp -> 字符串 WeChat_App_Instance_Identity_Mutex_Name -> 汇编ret -> 生成补丁

# 没有图片查看器 regedit
# [HKEY_LOCAL_MACHINE]\[OFTWARE]\[Microsoft]\[Windows Photo Viewer]\[Capabilities]\[FileAssociations]
# 添加 .jpg PhotoViewer.FileAssoc.Tiff

# win7 https 访问出问题安装下面页面的 Easy fix
# https://support.microsoft.com/en-us/topic/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-winhttp-in-windows-c4bd73d2-31d7-761e-0178-11268bb10392

# editplus 5
# vip 8JEQG-M5A9B-HCK8W-AJ81Y-YK00L

```

# Win10 2021 LTSC

```bash

# SHA256
# C117C5DDBC51F315C739F9321D4907FA50090BA7B48E7E9A2D173D49EF2F73A3

# KFN9B-WX6JF-FKB44-DJ93G-VCHW2
# FT2X8-FTNP4-FKYQ3-DPHCR-KBWYV
# 6F99V-3NCRG-49HKH-QQDC8-MTG2P

# C3NMT-6TP8F-CD7YH-JW482-9QD82
# NPPR9-FWDCX-D2C8J-H872K-2YT43

# 设置激活主机 官方通道可不设置
slmgr /skms s1.kms.cx

# 设置密钥
slmgr /ipk C3NMT-6TP8F-CD7YH-JW482-9QB82

# 开始激动
slmgr /ato

# 查看激活状态
slmgr /xpr

```

# Office ltsc

```bash

# https://sysin.org/blog/office-2021-iso/
# 1. 下载 "Office 部署工具" 解压得到 setup.exe 网址: https://www.microsoft.com/download/details.aspx?id=49117 

# 2. 新建 ltsc.xml
# 可以删除 ProjectPro2021Volume / VisioPro2021Volume
<Configuration>
  <Add OfficeClientEdition="64" Channel="PerpetualVL2021" AllowCdnFallback="true" OfficeMgmtCOM="False">
    <Product ID="ProPlus2021Volume">
      <Language ID="zh-cn" />
      <ExcludeApp ID="Lync" />
      <ExcludeApp ID="OneDrive" />
      <ExcludeApp ID="Teams" />
    </Product>
    <Product ID="ProjectPro2021Volume">
      <Language ID="zh-cn" />
    </Product>
    <Product ID="VisioPro2021Volume">
      <Language ID="zh-cn" />
      <ExcludeApp ID="OneDrive" />
    </Product>
  </Add>
  <Display Level="Full" AcceptEULA="TRUE" />
  <Updates Enabled="False" Channel="PerpetualVL2021" />
</Configuration>

# powershell管理员模式运行
# 3. .\setup.exe /configure ltsc.xml


# kms指定服务器激活


cd "C:\Program Files\Microsoft Office\Office16"

# 查询状态
cscript ospp.vbs /dstatus

# 卸载key XXXXX为key后五位
cscript ospp.vbs /unpkey:xxxxx

# 设置激活码
cscript ospp.vbs /inpkey:xxxxx-xxxxx-xxxxx-xxxxx

# 设置kms服务器 https://kms.cx/
cscript ospp.vbs /sethst:/sethst:s1.kms.cx

# 开始激活
cscript ospp.vbs /act

```

# ShrewVPN

* 下载并安装免费的 [Shrew Soft VPN 客户端](https://www.shrew.net/download/vpn)。在安装时请选择 Standard Edition。
    - 注： 该 VPN 客户端 不支持 Windows 10/11。
* 单击开始菜单 -> 所有程序 -> ShrewSoft VPN Client -> VPN Access Manager
* 单击工具栏中的 Add (+) 按钮。
* 在 Host Name or IP Address 字段中输入你的 VPN 服务器 IP。
* 单击 Authentication 选项卡，从 Authentication Method 下拉菜单中选择 Mutual PSK + XAuth。
* 在 Local Identity 子选项卡中，从 Identification Type 下拉菜单中选择 IP Address。
* 单击 Credentials 子选项卡，并在 Pre Shared Key 字段中输入你的 VPN IPsec PSK。
* 单击 Phase 1 选项卡，从 Exchange Type 下拉菜单中选择 main。
* 单击 Phase 2 选项卡，从 HMAC Algorithm 下拉菜单中选择 sha1。
* 单击 Save 保存 VPN 连接的详细信息。
* 选择新添加的 VPN 连接。单击工具栏中的 Connect 按钮。
* 在 Username 字段中输入你的 VPN 用户名。
* 在 Password 字段中输入你的 VPN 密码。
* 单击 Connect。

- 不用"老毛桃"装了会加一堆软件, 用UltraISO.


# FAQ

## win10关闭自动更新

```bash

# 1.禁用Windows Update服务
    # services.msc -> Windows Update
    # 启动类型 -> 禁用
    # 恢复 -> 第一次失败 -> 无操作
# 2.组策略关闭更新相关服务
    # gpedit.msc -> 计算机配置 -> 管理模板 -> Windows组件 -> Windows更新
    # 配置自动更新 -> 已禁用
    # 删除使用所有Windows更新功能的访问权限 -> 已启用
# 3.任务计划关闭自动更新
    # taskschd.msc -> 任务计划程序库 -> Microsoft -> Windows -> WindowsUpdate
    # 里面能禁用的项目全禁用
# 4.注册表关闭自动更新
    # regedit -> [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsoSvc]
    # start -> 0x4
    # FailureActions -> 0010\0018行 左起第5个数值 01 -> 00

```
