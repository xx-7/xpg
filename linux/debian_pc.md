[TOC]

# 安装

## ntpdate

```bash

sudo apt install ntpdate

sudo ntpdate cn.pool.ntp.org
sudo hwclock -w

sudo ntpdate time.windows.com && sudo hwclock -w

sudo cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

```

## kde

```bash
apt install kde-plasma-desktop

# 全局主题: Orchis Dark
# 图标: Tela circle dark

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

## ssh

```bash
# generate key
ssh-keygen -t rsa

# ssh client
ssh -i ~/.ssh/id_rsa USER@SERVER
#or
nano ~/.ssh/config
Host www.domain.com www2.domain.com
port 77
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_rsa_local

# ssh server
apt install openssh-server
mkdir -p ~/.ssh/
nano /etc/ssh/sshd_config


StrictModes no
PermitRootLogin yes

RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile      .ssh/rsa_pub #rsa_pub pub key file

PasswordAuthentication no

systemctl restart sshd

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
sudo apt install okteta flameshot gwenview keepassxc
sudo apt install nodejs npm
sudo apt install fonts-firacode
sudo apt install qbittorrent
```

## yarn 

```bash

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update 
sudo apt install yarn

yarn create vite front --template react-ts

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
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
sudo echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
sudo apt update
sudo apt install google-chrome-stable
```

## WebDav

```bash
sudo apt install davfs2 -y
sudo mount -t davfs https://10.9.9.1:9090/ /r/webdav

```