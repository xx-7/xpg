
# 软件

- SoftEther VPN Server  / l2tp Server

# 命令

```bash

# Win自带Hash
certutil -hashfile  <文件名>  <hash类型 SHA1/MD5/SHA256>

# Wx撤回多开
# 附加 Wx -> 符号 -> WeChatWin.dll -> 搜索 -> 当前区域 -> 字符串 revokemsg -> 汇编jmp -> 字符串 WeChat_App_Instance_Identity_Mutex_Name -> 汇编ret -> 生成补丁


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

# NPPR9-FWDCX-D2C8J-H872K-2YT43

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

# 3. setup /configure ltsc.xml

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

- 不用"老毛桃"装了会加一堆软件, 用UltraISO或dd.
