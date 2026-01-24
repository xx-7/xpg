[TOC]

- 软件很旧(要新的自己编译)
- 版本不升级,直接新安装

# 安装

## kde

```bash
apt install kde-plasma-desktop

# 全局主题: Orchis Dark
# 图标: Tela circle dark

```

## xfce

```bash
sudo apt install xfce4 xfce4-terminal

# 主题复制到 ~/.themes 目录下

# https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme

# https://github.com/habibimedwassim/Flat-Remix-GTK-Darkish

# 任务bar 改到下面
# Settings Editor -> xfce4 pannel -> position -> p=10

# 4k 2倍 放大 只能改整数倍
# Settings Editor -> xsettings -> Gdk -> WindowScalingFactor -> 2

# 图标
# https://github.com/vinceliuice/Tela-icon-theme

# 目录
# 默认theme
# 用户 ~/.themes  系统 /usr/share/themes
# 默认icons
# 用户 ~/.icons  系统 /usr/share/icons

sudo apt install light-locker
# 自动锁屏
sudo apt install xscreensaver

# 启动
xscreensaver -nosplash

# 锁定
xscreensaver-command  --lock

# 自启动
sudo nano /etc/xdg/autostart/screensaver.desktop
[Desktop Entry]
Name=Screensaver
Type=Applicaton
Exec=xscreensaver -nosplash

# dpms查询
xset q
# 关闭 dpms
xset s off -dpms
xset s off

sudo nano /etc/X11/xorg.conf.d/10-monitor.conf

Section "ServerFlags"
    Option "StandbyTime" "0"
    Option "SuspendTime" "0"
    Option "OffTime" "0"
    Option "BlankTime" "0"
EndSection


#  配置语言包
sudo apt install locales
sudo nano /etc/locale.gen
en_US.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
zh_HK.UTF-8 UTF-8
# 生成
sudo locale-gen

sudo apt install fonts-powerline
# 设置默认
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


# qt 程序 缩放
nano ~/.xsessionrc
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_SCALE_FACTOR=1.75


# xfce4-terminal 字体列表默认只显示系统中mono字体 注意设置编码


```

### 打开方式

```bash
rm ~/.config/kiorc # 删除已选择打开方式
```

## 显卡

### AMD

```bash
# https://wiki.debian.org/AtiHowTo#Installation

sudo nano /etc/apt/sources.list
deb http://deb.debian.org/debian trixie main contrib non-free
sudo apt update
sudo apt install firmware-amd-graphics firmware-linux-nonfree libgl1-mesa-dri libglx-mesa0 mesa-vulkan-drivers xserver-xorg-video-all

```

## 网卡

### intel 无线

```bash
# https://wiki.debian.org/WiFi
sudo echo "deb [arch=amd64] http://httpredir.debian.org/debian/ trixie main contrib non-free" > /etc/apt/sources.list.d/httpredir.list

sudo apt-get install firmware-iwlwifi

# e5000 网卡驱动  同 r8126
# https://www.realtek.com/Download/List?cate_id=584
```

# 配置

## 源

### 备份

```bash
# 源列表 https://www.debian.org/mirror/list.zh-cn.html
cp /etc/apt/sources.list /etc/apt/sources.listbak
```

### 测试源

```bash
deb http://ftp.cn.debian.org/debian forky main contrib non-free
deb http://ftp.cn.debian.org/debian forky-updates main contrib non-free
```

### 稳定源

```bash
deb http://ftp.cn.debian.org/debian trixie main contrib non-free
deb http://ftp.cn.debian.org/debian/debian-security trixie-updates main contrib non-free
```

```bash
deb http://ftp.cn.debian.org/debian sid main contrib non-free
```

## locales

```bash
apt install locales -y

apt install locales
apt install fonts-wqy-zenhei

nano /root/.bashrc
export LC_ALL=zh_CN.UTF-8

```

## 网络

### NetworkConfiguration

```bash
# 注意用NetworkManager管理过后DNS会被清空
sudo nano /etc/network/interfaces

iface enp0s31f6 inet dhcp

auto enp0s31f6
iface enp0s31f6 inet static
address 10.8.8.28
netmask 255.255.255.0
gateway 10.8.8.1

nano /etc/resolv.conf
nameserver 10.8.8.1

sudo /etc/init.d/networking restart
sudo systemctl restart networking
```

### NetworkManager

```bash
# 注意用NetworkManager管理过后DNS会被清空
sudo apt install plasma-nm
# managed =  false 不管理/etc/network/interfaces已定义接口
cat /etc/NetworkManager/NetworkManager.conf
[main]
plugins=ifupdown,keyfile

[ifupdown]
managed=false

sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
```

## 磁盘

```bash
# 查看分区
sudo fdisk -l

# 查看使用情况
df -h

# 查看盘UUID
ls -l /dev/disk/by-uuid/

# 查看目录占用大小
du -h  ./

# 查看目录占用大小设置遍历深度
du -h --max-depth=1 ./

# 给硬盘分区 进入m打印帮助 dos 分区表格式 ext4用主分区 w 保存退出
sudo fdisk /dev/sdb
# 格式化
sudo mkfs -t ext4 /dev/sdb1
# 临时挂载
sudo mount /dev/sdb1 /optd

# 自动挂盘
sudo nano /etc/fstab
UUID=b141d23c-0f49-48a0-aaaa-80f25b30bd8f /optd ext4 defaults 0 2
```

## apt

```bash
sudo apt update
sudo apt upgrade
sudo apt dist-upgrade
sudo apt install
sudo apt install -f *.deb
sudo apt remove
sudo apt autoremove
sudo apt clean all
sudo apt list
sudo apt list --installed

sudo dpkg -i xx_amd64.deb

sudo dpkg -l  # installed

```

## sudo

```bash
apt install sudo
nano /etc/sudoers
Defaults:USERNAME rootpw
Defaults:USERNAME timestamp_timeout=20
USERNAME	ALL=(ALL:ALL) ALL
```

## 双屏

```bash
xrandr
xrandr --output DIV-D-0 --left-of HDMI-A-0
```

```bash
sudo nano /etc/X11/xorg.conf.d/10-monitor.conf

Section "Monitor"
    Identifier  "HDMI-A-0"
    Option      "Primary" "true"
EndSection

Section "Monitor"
    Identifier  "DIV-D-0"
    Option      "LeftOf" "HDMI-A-0"
EndSection
```

## profile

```bash
# System
sudo nano /etc/profile
# User
nano ~/.profile
export  JAVA_HOME=/optd/opt/jdk1.8.0_301/
export  CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib

PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin
export PATH=$PATH:/optd/opt/gradle-5.5/bin

alias python='/usr/bin/python3'

source ~/.profile

# debian get jdk8  gz  https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html

```

## dev

```bash

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


# node.js
wget https://nodejs.org/dist/v24.11.1/node-v24.11.1-linux-x64.tar.xz
tar -zxvf node-v24.11.1-linux-x64.tar.xz
export PATH=$PATH:/ufs/opt/node-v24.11.1-linux-x64/

# jdk
wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz
tar -zxvf jdk-21_linux-x64_bin.tar.gz
export JAVA_HOME=/ufs/opt/jdk-21.0.9
export PATH=$JAVA_HOME/bin:$PATH

```

## 蓝牙音响

```bash

sudo apt install pulseaudio pulseaudio-module-bluetooth pavucontrol bluez-firmware


sudo apt install pipewire pipewire-audio pipewire-pulse xfce4-pulseaudio-plugin
# https://wiki.debian.org/BluetoothUser#Can_connect.2C_but_not_to_audio
sudo apt install pulseaudio-module-bluetooth
pactl load-module module-bluetooth-discover

# xfce4 蓝牙管理
sudo apt install blueman
```

# 软件

## 常用

```bash
# srecorder qBittorrent
sudo apt install curl unar
sudo apt install ttf-wqy-microhei fcitx-table-wbpy

# fcitx5
sudo apt-get install fcitx5 fcitx5-config-qt fcitx5-chinese-addons

sudo apt install nfs-common mpv remmina fontforge
sudo apt install sqlitebrowser shotcut gimp
sudo apt install ksnip gwenview keepassxc
sudo apt install nodejs npm
sudo apt install fonts-firacode p7zip-full
sudo apt install qbittorrent libreoffice


# 温度，硬件信息
sudo apt install psensor hardinfo lm-sensors
sudo sudo sensors-detect --auto


# 安装sid的包
sudo nano  /etc/apt/sources.list
deb http://deb.debian.org/debian bookworm-backports main

sudo apt update

apt install -t bookworm-backports kicad


# code
# https://wiki.debian.org/VisualStudioCode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/keyrings/microsoft-archive-keyring.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
```

## yarn

```bash

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update
sudo apt install yarn

yarn create vite front --template react-ts

```

## gcc

```bash
sudo apt install gcc g++
wget http://mirrors.ustc.edu.cn/gnu/gcc/gcc-11.2.0/gcc-11.2.0.tar.gz
tar -zxvf gcc-11.2.0.tar.gz
cd gcc-11.2.0
./contrib/download_prerequisites
mkdir build
cd build
 ../configure --enable-checking=release --enable-languages=c,c++ --disable-multilib
make
sudo make install
```

## smartmontools

```bash

apt install smartmontools
# 查看盘符
df -h
# 总览信息
smartctl -a /dev/sda3
# 如果 出现 SMART support is: Disabled 先 -s on打开
smartctl -s on -a /dev/sda3
# 测试健康状态
smartctl -H /dev/sda3
# 查看硬盘错误日志
smartctl -l error /dev/sda3
# 查看硬盘挂载情况
mount
# 光盘引导后，修复
fsck /dev/sda3
```

## simplescreenrecorder

```bash
sudo apt install simplescreenrecorder
# 注意录系统声音时大小是根据系统音量的设置

# 同时录系统声音和麦克风
pactl load-module module-loopback
pactl unload-module module-loopback

# 增加rate
sudo nano /etc/pulse/daemon.conf
default-sample-rate = 48000
alternate-sample-rate = 48000

systemctl --user restart pulseaudio.service
```

## Typora

```bash
# https://typora.io/#linux
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo add-apt-repository 'deb https://typora.io/linux ./'
sudo apt update
sudo apt install typora
```

## Chrome

```bash
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo tee /etc/apt/trusted.gpg.d/google.asc >/dev/null
sudo echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
sudo apt update
sudo apt install google-chrome-stable
```

## WebDav

```bash
sudo apt install davfs2 -y
sudo mount -t davfs https://10.9.9.1:9090/ /r/webdav

```

## zip

```bash
sudo apt install zip
zip -re dest.zip src        #回车，输入2次密码
zip -rP PASS dest.zip src

unzip src.zip                #按提示输入密码
unzip -P PASS src.zip
```

## mtp

```bash
sudo apt install mtp-tools kio-extras
```

## VMware

```bash
# https://www.vmware.com/products/workstation-pro/workstation-pro-evaluation.html
# https://softwareupdate.vmware.com/cds/vmw-desktop/ws/17.0.0/20800274/linux/core/

chmod +x VMware-Workstation-Full-16.2.1-18811642.x86_64.bundle

sudo ./VMware-Workstation-Full-16.2.1-18811642.x86_64.bundle

# uninstall
sudo vmware-installer -u vmware-workstation

sudo apt install build-essential linux-headers-$(uname -r)


```

## fio

```

# 测试硬盘读写

# https://manpages.debian.org/buster/fio/fio.1.en.html

sudo apt install fio


# 顺序读写
sudo fio -filename=/dev/sdb1 -direct=1 -iodepth 1 -thread -rw=readwrite -ioengine=psync -bs=4k -size=100G -numjobs=8 -runtime=180 -group_reporting -name=s100rw_4k

# 顺序读
sudo fio -filename=/dev/sdb1 -direct=1 -iodepth 1 -thread -rw=read -ioengine=psync -bs=4k -size=100G -numjobs=8 -runtime=180 -group_reporting -name=s100r_4k

# 顺序写
sudo fio -filename=/dev/sdb1 -direct=1 -iodepth 1 -thread -rw=write -ioengine=psync -bs=4k -size=100G -numjobs=8 -runtime=180 -group_reporting -name=s100w_4k

# 随机读
sudo fio -filename=/dev/sdb1 -direct=1 -iodepth 1 -thread -rw=randread -ioengine=psync -bs=4k -size=100G -numjobs=8 -runtime=180 -group_reporting -name=r100r_4k

# 随机写
sudo fio -filename=/dev/sdb1 -direct=1 -iodepth 1 -thread -rw=randwrite -ioengine=psync -bs=4k -size=100G -numjobs=8 -runtime=180 -group_reporting -name=r100w_4k

# 随机，70%读，30%写 4K
sudo fio -filename=/dev/sdb1 -direct=1 -iodepth 1 -thread -rw=randrw -rwmixread=70 -ioengine=psync -bs=4k -size=100G -numjobs=8 -runtime=180 -group_reporting -name=r_70rw_4k

```

## scrpcy

```bash

sudo apt install scrcpy

# 要安装adb 是通过adb 调试模式连接

# 投屏并录屏
scrcpy -r file.mp4

# 不投屏只录屏
scrcpy -Nr file.mp4


```

## GnuCash

```bash
# https://wiki.debian.org/GnuCash
# https://wiki.gnucash.org/wiki/Locale_Settings
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


flatpak install flathub org.gnucash.GnuCash
flatpak run org.gnucash.GnuCash

```
