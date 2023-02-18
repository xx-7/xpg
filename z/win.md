
# 软件

- SoftEther VPN Server  / l2tp Server

# 命令

```bash

# Win自带Hash
certutil -hashfile  <文件名>  <hash类型 SHA1/MD5>

# Wx撤回多开
# 附加 Wx -> 符号 -> WeChatWin.dll -> 搜索 -> 当前区域 -> 字符串 revokemsg -> 汇编jmp -> 字符串 WeChat_App_Instance_Identity_Mutex_Name -> 汇编ret -> 生成补丁

```

# Win10 激活

```bash

# https://www.microsoft.com/zh-cn/software-download/windows10ISO/

# run cmd with administrator privileges

slmgr /unp
slmgr /ipk NPPR9-FWDCX-D2C8J-H872K-2YT43
slmgr /skms kms.digiboy.ir
slmgr /ato

```

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
