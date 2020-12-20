[TOC]

# 安装

## kde
```bash
apt install kde-plasma-desktop

# 全局主题: Arc Dark, Orchis
# 图标: Papirus, Tela

# 把fex加到ssdm组才可以设置 ssdm登录界面
usermod -a -G ssdm fex

```
## 显卡
### AMD
```
# https://wiki.debian.org/AtiHowTo#Installation

sudo nano /etc/apt/sources.list
deb http://deb.debian.org/debian bullseye main contrib non-free
sudo apt update
sudo apt install firmware-amd-graphics firmware-linux-nonfree libgl1-mesa-dri libglx-mesa0 mesa-vulkan-drivers xserver-xorg-video-all

```

## 网卡
### intel 无线
```bash
# https://wiki.debian.org/WiFi
sudo nano /etc/apt/sources.list
deb http://httpredir.debian.org/debian/ bullseye main contrib non-free
sudo apt-get update 
sudo apt-get install firmware-iwlwifi
```
# 配置

## 源

有些软件只有sid源里面才有比如firefox, openjdk-8-jdk.
先添加sid 再update 一下，然后install 这时候千万不要upgrade.
安装完了,再删除sid,再update.
这种做法可能会把依赖更新成sid.

### 备份

```bash
# 源列表 https://www.debian.org/mirror/list.zh-cn.html
cp /etc/apt/sources.list /etc/apt/sources.listbak 
```

### 测试源
```bash
deb http://ftp.cn.debian.org/debian bullseye main contrib non-free
deb http://ftp.cn.debian.org/debian bullseye-updates main contrib non-free
```

### 稳定源
```bash
deb http://ftp.cn.debian.org/debian buster main contrib non-free
deb http://ftp.cn.debian.org/debian/debian-security buster-updates main contrib non-free
```
### 
```bash
deb http://ftp.cn.debian.org/debian sid main contrib non-free
```
## 网络
### NetworkConfiguration
```
# 注意用NetworkManager管理过后DNS会被清空
sudo nano /etc/network/interfaces

iface enp0s31f6 inet dhcp

iface enp0s31f6 inet static
address 10.8.8.28  
netmask 255.255.255.0
gateway 10.8.8.1

nano /etc/resolv.conf
nameserver 10.8.8.1

sudo /etc/init.d/networking restart
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
## ssh
```bash
# ssh client
nano ~/.ssh/config
Host www.domain.com
port 77
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_rsa_local
```
## profile
```bash
# System
sudo nano /etc/profile
# User
nano ~/.profile
export  JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 
export  CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib 

PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin
export PATH=$PATH:/optd/opt/gradle-5.5/bin

source ~/.profile
```

## 蓝牙音响
```bash
# https://wiki.debian.org/BluetoothUser#Can_connect.2C_but_not_to_audio
sudo apt install pulseaudio-module-bluetooth
pactl load-module module-bluetooth-discover
```
# 软件
## 常用
```bash
# srecorder qBittorrent
sudo apt install curl unar 
sudo apt install ttf-wqy-microhei fcitx-table-wbpy
sudo apt install nfs-common mpv remmina fontforge
sudo apt install sqlitebrowser shotcut gimp
sudo apt install okteta flameshot gwenview
sudo apt install nodejs npm
sudo apt install fonts-firacode
sudo apt install qbittorrent
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
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
sudo echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
sudo apt update
sudo apt install google-chrome-stable
```

## Mysql
```bash
sudo apt install mariadb-server
sudo mysql_secure_installation
sudo systemctl disable mariadb
sudo systemctl restart mariadb

# 建库
create DATABASE xxxxx CHARACTER SET utf8 COLLATE utf8_general_ci;
# 导入
mysqldump -u用户名 -p密码 -h主机 数据库 < 路径 #导入
# 导出
mysqldump -u用户名 -p密码 -h主机 数据库 > 路径
\. /path/file.sql
```