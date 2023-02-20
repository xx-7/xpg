# 常用软件

- Strongbox / 密码管理
- Working Copy / git客户端
- Exif Viewer / 图片元数据读取
- iSH / 命令行
- Money Pro / 记账
- nPlayer / 播放器
- Shadowrocket / 梯子
- Termius / ssh客户端
- Acrobat / pdf阅读
- Xmind / 思维导图
- 不背单词 / 单词记忆、英语字典
- 训记 / 锻练记录
- 以观书法 / 查字
- FE文件管理器

# MonkeyDev

```bash
# https://github.com/AloneMonkey/MonkeyDev
# 有时会出问题，清除编译目录试试

```

# 碎片知识

- Cydia / 越狱后app store, 安装后默认安装OpenSSH,默认密码:alpine
- Frida / 跨平台动态注入工具
- IPA分析前要先砸壳解密,助手工具下载的大部分是解密的,可以otool(xcode自动工具)进一步确认

# 分析IPA


# 越狱

- 硬件漏洞 [checkra1n](https://checkra.in/) 越狱后会安装Cydia
- 软件漏洞(重启后要再越狱) [Unc0ver](https://unc0ver.dev/)

# 砸壳

- [dumpdecrypted](https://github.com/stefanesser/dumpdecrypted)
- [Clutch](https://github.com/KJCracks/Clutch)
- [frida-ios-dump](https://github.com/AloneMonkey/frida-ios-dump)

```bash

# 手机端
# -----------------
# 1.先root
# 2.Cydia 添加源 https://build.frida.re
#       搜索 Frida 并安装

# 电脑端
# -----------------
git clone https://github.com/AloneMonkey/frida-ios-dump.git
cd frida-ios-dump
sudo pip3 install -r requirements.txt --upgrade

# 可以在dump.py中直接改 User/Password/Host/Port
# 也可以 -H HOST -p PORT -u USER -P PASS

# 查看进程
./dump.py -l
# 或
frida-ps --usb

# 砸壳 参数可以是名称或者 pid
# -o 设置软件出本地文件名
./dump.py test

# 查壳 otool是xcode自带工具
# cryptid 0 已砸壳
otool -l Payload/test.app/test | grep "crypt"

# 也可以用usbmuxd把ios连接映射到2222端口
# mac
brew install usbmuxd
# arch
sudo pacman -S usbmuxd

# mac iproxy 把 2222 映射到 22
iproxy 2222 22


```
# class-dump

```bash



# 支持（ObjC+）swift混淆的class-dump
# https://github.com/AloneMonkey/MonkeyDev/blob/master/bin/class-dump

# Down: https://raw.githubusercontent.com/AloneMonkey/MonkeyDev/master/bin/class-dump


```


# 常见问题解决

## Untrusted Developer

Settings -> General -> Device Management -> 信任证书

## VirtualBox 无法连接iPhone

开个人热点后再试

