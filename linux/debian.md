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

有些软件只有 sid 源里面才有比如 firefox, openjdk-8-jdk.
先添加 sid 再 update 一下，然后 install 这时候千万不要 upgrade.
安装完了,再删除 sid,再 update.
这种做法可能会把依赖更新成 sid.

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

```
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
export  JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export  CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib

PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin
export PATH=$PATH:/optd/opt/gradle-5.5/bin

alias python='/usr/bin/python3'

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

## certbot
```
apt install certbot

# 先要关防火墻 证书目录 /etc/letsencrypt/live/
certbot certonly -d s.xxxx.com

# 续期
certbot renew

```

## iptables
```bash

# 添加放行
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# 查看
iptables -L -n

# 清除所有, 没有stop要关时先save然后清除所有，开时再restore回来
iptables -F
iptables -X

# 保存
iptables-save > /etc/iptables.up.rules
# 恢复 
iptables-restore < /etc/iptables.up.rules

# 开机自动加载
nano /etc/network/if-pre-up.d/iptables

#!/bin/sh
/sbin/iptables-restore < /etc/iptables.up.rules

chmod +x /etc/network/if-pre-up.d/iptables

```

## rc.local
```bash
nano /etc/rc.local
#!/bin/sh


exit 0

chmod +x /etc/rc.local

systemctl enable rc.local


```

## IpSec VPN
```bash
wget https://git.io/vpnsetup -O vpnsetup.sh
chmod 777 vpnsetup.sh
VPN_IPSEC_PSK='6fTnH5uU9beYkggEKLUN0' \
VPN_USER='zxz' \
VPN_PASSWORD='XzxTop' \
sh vpnsetup.sh
```

## sysctl.conf
```bash
nano /etc/sysctl.conf

net.ipv4.ip_forward = 0
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
kernel.sysrq = 0
kernel.core_uses_pid = 1
net.ipv4.tcp_syncookies = 1
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.shmmax = 68719476736
kernel.shmall = 4294967296
net.ipv4.tcp_max_tw_buckets = 6000
net.ipv4.tcp_sack = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_rmem = 10240 131072 12582912
net.ipv4.tcp_wmem = 10240 131072 12582912
net.core.wmem_default = 8388608
net.core.wmem_max = 16777216
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.netdev_max_backlog = 262144
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.tcp_max_syn_backlog = 262144
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_synack_retries = 1
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_fin_timeout = 15
net.ipv4.tcp_keepalive_time = 30
net.ipv4.ip_local_port_range = 2048 65000
fs.file-max = 102400
net.ipv6.conf.all.disable_ipv6=1


/sbin/sysctl -p


# disable_ipv6 有时候系统只开ipv6自动启动，disable网卡不会随系统启动
```
## nginx
```bash
apt install nginx

```
### webdev
```bash
# 开webdev

mkdir /home/downloads
chmod 777 /home/downloads

nano /etc/nginx/conf.d/webdev.conf

server {
    listen       88; 
    server_name  s.domain.com;
    error_log /var/log/nginx/webdav.error.log error;
    access_log  /var/log/nginx/webdav.access.log combined;
    location / {
        root /home/downloads;
        charset utf-8;
        autoindex on;
        dav_methods PUT DELETE MKCOL COPY MOVE;
        dav_ext_methods PROPFIND OPTIONS;
        create_full_put_path  on;
        dav_access user:rw group:r all:r;
        auth_basic "Authorized Users Only";
        auth_basic_user_file /etc/nginx/.htpasswd;
    }
    ssl on; 
    ssl_certificate /etc/letsencrypt/live/s.domain.com/fullchain.pem;    
    ssl_certificate_key /etc/letsencrypt/live/s.domain.com/privkey.pem; 
}

# 设置密码
apt install apache2-utils
htpasswd -c /etc/nginx/.htpasswd $USER

systemctl restart nginx

```