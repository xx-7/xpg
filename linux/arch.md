[TOC]

# 经常有更新包

# 安装

## 分区

```bash

sudo dd bs=4M if=./archlinux-2022.02.01-x86_64.iso  of=/dev/sdX conv=fsync oflag=direct status=progress

# https://wiki.archlinux.org/index.php/GRUB
# 注意，GPT分区表，预留一个 BIOS 启动分区
# 可以在 fdisk 或 gdisk 中创建一个从 34 扇区开始，一直到 2047
# GUID 21686148-6449-6E6F-744E-656564454649  类型 根据分区软件不同: BIOS boot/ef02/bois_grub

/boot/EFI  /dev/sdX1             #512MB 启动目录 
[SWAP]     /dev/sdX2            #交换区 内存的两倍
/          /dev/sdX3                 #剩余  根目录

cfdisk /dev/sdX

mkfs.fat /dev/sdX1
mkfs.ext4 /dev/sdX3
mkswap /dev/sdX2

mount /dev/sdX3 /mnt
mkdir -p /mnt/boot/EFI
mount /dev/sdX1 /mnt/boot/EFI
swapon /dev/sdX2
```

## 配置安装环境

```bash
# 刷新本地时间
timedatectl set-ntp true

# 镜像
sed -i '/China/!{n;/Server/s/^/#/};t;n' /etc/pacman.d/mirrorlist

nano /etc/pacman.d/mirrorlist
#1.[F6] 搜索 china
#2.[方向键] 移动光标至 Server 行
#3.[CTRL+K] 剪切该行
#4.[方向键] 移动光标至其他 Server 行前
#5.[CTRL+U] 粘贴至此行
#6.[CTRL+O] 保存，[回车键] 确定
```

## 安装系统

```bash
# 安装基本系统
pacstrap /mnt base base-devel linux linux-firmware

# Fstab
genfstab -U /mnt >> /mnt/etc/fstab

# 进到安装目录
arch-chroot /mnt

# 设置时区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 保存硬件时间
hwclock --systohc --localtime

#  配置语言包
nano /etc/locale.gen
en_US.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
zh_HK.UTF-8 UTF-8
# 生成
locale-gen
# 设置默认
nano /etc/locale.conf
LANG=en_US.UTF-8

# 主机名
echo $HOSTNAME > /etc/hostname

# dhcpd 自动获取方式启动网络
systemctl start dhcpcd@$INTERFACE

# 修改ROOT密码 后期如果忘记密码也可以通过安装盘启动arch-chroot进来直接修改密码
passwd

# UEFI with GPT 方式引导启动
pacman -S dosfstools grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader=Arch --removable
grub-mkconfig -o /boot/grub/grub.cfg

# BIOS with MBR 方式引导启动 
pacman -S grub os-prober
grub-install --target=i386-pc /dev/sdX
grub-mkconfig -o /boot/grub/grub.cfg

# 完成安装
exit
umount -R /mnt
reboot
```

# 配置

## 用户

```bash
useradd -m -g users -G wheel,lp,network,power -s /bin/bash fex
passwd fex

# fex添加到ssdm组
usermod -a -G sddm fex
nano /etc/group

# 查用户组
groups user
cat /etc/group

# sudo
EDITOR=nano visudo
Defaults:fex rootpw
Defaults:fex timestamp_timeout=20
fex ALL=(ALL) ALL
```
## 网络
```bash
# 注意用NetworkManager管理过后DNS会被清空
sudo pacman -S net-tools networkmanager plasma-nm

sudo systemctl enable NetworkManager

# managed =  false 不管理/etc/network/interfaces已定义接口
cat /etc/NetworkManager/NetworkManager.conf 
[main]
plugins=ifupdown,keyfile

[ifupdown]
managed=false

# dhcpd 自动获取方式启动网络
sudo systemctl start dhcpcd@$INTERFACE

# systemd 方式设置静态IP
sudo nano /etc/systemd/network/eth0.network
[Match]
Name=$INTERFACE

[Network]
Address=10.8.8.28/24
Gateway=10.8.8.1
DNS=10.8.8.1

systemctl restart systemd-networkd

# 启动停止网口
ip link set $INTERFACE up|down 

# 配置DNS
sudo nano /etc/resolv.conf
nameserver 10.8.8.1

```

## 显示

```bash
pacman -S bumblebee mesa xf86-video-intel nvidia
pacman -S xorg-server

# 4k 
# System Settings -> Appearance -> Fonts  check Force font DPI   default 96    150% 144  175%  168
```

## kde

```bash
pacman -S plasma-desktop
```

## 显示管理器

```bash
pacman -S sddm
pacman -S sddm-kcm
systemctl enable sddm
```

```bash
nano /etc/sddm.conf
[Theme]
Current=breeze
```

## 主题

```bash
# 安装ocs-url之后就可以在store.kde.org在线install 主题
yay -S ocs-url

# 主题目录  可以直接拷进去，也可以清理

# Plasma 主题
~ /.local/share/plasma/desktoptheme/
# Global Themes
~/.local/share/plasma/look-and-feel/
# 颜色方案
~/.local/share/color-schemes
# 应用程序风格/窗口样式
~/.local/share/aurorae/themes/
# Icons
~/.local/share/icons/
# sddm主题
/usr/share/sddm/themes/

# 头像
/usr/share/sddm/faces/$USERNAME.face.icon
```

## 中文字体

```bash
pacman -S ttf-{dejavu,liberation} wqy-microhei
```

## 输入法

```bash
pacman -S fcitx5 fcitx5-rime fcitx5-im fcitx5-configtool

sudo nano /etc/environment
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
```

## profile

```bash
# System
sudo nano /etc/profile
# User
nano ~/.profile
export  JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export  CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib 

PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin
export PATH=$PATH:/optd/opt/gradle-5.5/bin

source ~/.profile
```

## 常用软件

```bash
sudo pacman -S dolphin konsole nfs-utils
sudo pacman -S nano nodejs mpv simplescreenrecorder unarchiver ttf-fira-code  sqlitebrowser gimp gwenview evince flameshot remmina freerdp keepassxc
paru -S firefox google-chrome visual-studio-code-bin jdk8-openjdk jdk11-openjdk baidunetdisk-bin
```

## 常用命令

```bash
md5sum filename			#文件md5
sha1sum filename		#文件SHA1
sha256sum filename		#文件SHA256
puttygen ./id_rsa -o test.ppk
```

## paru

```bash
pacman -S git rust base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

## yay

```bash
pacman -S git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## pacman

[节点状态](https://www.archlinux.org/mirrors/status/)

```bash
nano /etc/pacman.d/mirrorlist
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
Server = http://mirrors.163.com/archlinux/$repo/os/$arch
```

```bash
#同步与更新
pacman -Sy                  #同步源
pacman -Su                  #更新系统
pacman -Syu                 #同步源并更新系统
pacman -Su --ignore plasma  #不更新plasma

#安装软件
pacman -S plasma-desktop
pacman -S plasma-{desktop,nm}
#Enter a selection (default=all): 1-10 15     #选中序号 1 至 10 和 15 的软件包
#Enter a selection (default=all): ^5-8 ^2     #选中除了序号 5 至 8 和 2 之外的所有软件包

pacman -Sw package_name                       #下载不安装
pacman -U /path/pkg.tar.gz                    #安装本地包

#卸载软件
pacman -R package_name                        #删除单个软件包，保留其全部已经安装的依赖关系 
pacman -Rs package_name                       #删除指定软件包，及其所有没有被其他已安装软件包使用的依赖关系

#查询
pacman -Q                   #查询已安装软件包
pacman -Q plasma            #查看plasma包是否已经安装
pacman -Qi plasma           #查看已安装的包plasma的详细信息
pacman -Ql plasma           #列出已安装包plasma的所有文件
pacman -Qo /etc/passwd      #查找某个文件属于哪个包

pacman -Ss plasma           #搜索plasma相关的包
```

## 输入设备

```bash
pacman -S xf86-input-libinput
```

## 触摸板驱动

```bash
pacman -S xf86-input-synaptics
```

## 声音软件包

```bash
pacman -S alsa-utils pulseaudio pulseaudio-alsa kmix
alsamixer
aplay -l        #得到名字
nano ~/.asoundrc or /etc/asound.conf
pcm.!default {
	type hw
	card PCH
}

ctl.!default {
	type hw           
	card PCH
}
defaults.pcm.rate_converter "samplerate_best"      #  高质量采样 先安装 alsa-plugins,libsamplerate。
```

## 切换默认声音输出

```bash
aplay -l     #查看列表
sudo nano /etc/asound.conf 
defaults.pcm.card 0
defaults.pcm.device 3
defaults.ctl.card 0
```

## 双屏位置切换

```bash
sudo pacman -S xorg-xrandr
xrandr
xrandr --output HDMI-2 --left-of eDP-1
```

```bash
sudo nano /etc/X11/xorg.conf.d/10-monitor.conf

Section "Monitor"
    Identifier  "HDMI-1"
    Option      "Primary" "true"
EndSection

Section "Monitor"
    Identifier  "DVI-D-1"
    Option      "LeftOf" "HDMI-1"
EndSection
```

## 蓝牙

```bash
pacman -S bluez bluez-utils bluedevil
systemctl enable bluetooth
bluetoothctl   #蓝牙命令行
nano /etc/bluetooth/main.conf
[Policy]
AutoEnable=true
pacman -S pulseaudio-bluetooth  #蓝牙耳机
nano /etc/pulse/system.pa
#...
load-module module-bluetooth-policy
load-module module-bluetooth-discover
#...
```

## lenovo throttling fix

```bash
yay -S lenovo-throttling-fix-git
sudo systemctl enable --now lenovo_fix.service
```

## 电池电源

```bash
sudo pacman -S acpi acpid tlp powertop tp_smapi acpi_call
sudo systemctl enable tlp
sudo systemctl enable tlp-sleep
sudo systemctl enable acpid
sudo nano /etc/systemd/system/powertop.service
[Unit]
Description=Powertop tunings

[Service]
ExecStart=/usr/bin/powertop --auto-tune
RemainAfterExit=true

[Install]
WantedBy=multi-user.target

sudo systemctl enable powertop
```

## PPTP Client

```bash
#https://wiki.archlinux.org/index.php/PPTP_Client 
sudo pacman -S pptpclient

#配置jp
sudo nano /etc/ppp/peers/jp-pptp
pty "pptp <SERVER> --nolaunchpppd"
name zxz
remotename PPTP0
require-mppe-128
file /etc/ppp/options.pptp
ipparam jp-pptp

#配置密码
sudo nano /etc/ppp/chap-secrets
zxz PPTP0 "PWD" *

#测试连接
sudo pon jp-pptp debug dump logfd 2 nodetach

#连接
sudo pon jp-pptp

#断开
sudo poff jp-pptp

#默认路由
sudo ip route add default dev ppp0

#选择路由
sudo ip route add 192.168.10.0/24 dev ppp0
```

## l2tp

```bash
yay -S networkmanager-l2tp
```

## zip

```bash
sudo pacman -S zip
zip -re dest.zip src        #回车，输入2次密码
zip -rP PASS dest.zip src

unzip src.zip                #按提示输入密码
unzip -P PASS src.zip
```

## 7Z

```bash
sudo pacman -S p7zip

7za -p -mhe -r a destOutputFileName srcFileOrDir1 srcFileOrDir2 ....
:'
-mhe 加密文件名
-p 需要设置密码 （敲完命令回车后，根据提示输入密码和确认，密码将和linux系统密码一样不显示)
-ppassword 直接设置密码
-r 读取目录及子目录所有文件
'

7za x 7zFileName [-oOutputPath]

:'
x 是安装原来的目录结构解压
e 是忽略目录结构，都解压到跟目录
-o 输出目录非必须
' 
```

## openssl

```bash
openssl enc -e -aes256 -out test.tar.gz
openssl enc -d -aes256 -in test.tar.gz
```

## 不识别U盘

```bash
#查看是否加载usb-storage
lsmod | grep usb
sudo modprobe usb-storage
```

## 文件系统

[官方说明](https://wiki.archlinux.org/index.php/File_systems)

```bash
#exFAT
sudo pacman -S exfat-utils

#NFS https://wiki.archlinux.org/index.php/NFS
sudo pacman -S nfs-utils
mount -rw 10.8.8.1:/disk/opt/share /r/share

```

## Mysql

```bash
sudo pacman -S mariadb mariadb-libs
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/optd/db/data/mysql/
sudo  /usr/bin/mysqld_safe --datadir='/optd/db/data/mysql/' --skip-grant-tables

# 要先 FLUSH PRIVILEGES; 不然设置不了密码
FLUSH PRIVILEGES;
SET PASSWORD FOR root@'localhost' = PASSWORD('XXXXXXX');
FLUSH PRIVILEGES;

sudo nano /etc/my.cnf
[mysqld]
datadir                     =/optd/db/data/mysql/
init_connect                = 'SET collation_connection = utf8_general_ci,NAMES utf8'
collation_server            = utf8_general_ci
character_set_client        = utf8
character_set_server        = utf8

sudo systemctl disable mysqld
sudo systemctl start mysqld
```

## 安装deb包

```bash
paru -S debtap
sudo debtap -u

# 使用 -q 略过除了编辑元数据之外的所有问题, -Q 略过所有的问题
debtap <package-name>.deb
sudo pacman -U <package-name>

```

## 梯子

```bash
sudo pacman -S v2ray
yay -S v2raya
```

## 图片全成pdf

```bash
sudo pacman -S imagemagick

curl -O http://url.cn/[1-100].jpg
convert {1..100}.jpg file1.pdf
```

## 安卓手机

```bash
sudo pacman -S android-tools
```

## webdav

```bash
sudo pacman -S davfs2
sudo mount -t davfs https://a.com/path /r/webdav
```

## gnucash
```
sudo pacman -S gnucash sqlite libdbi libdbi-drivers
locale -a
LANGUAGE=zh_CN.utf8 LANG=zh_CN.utf8 LC_ALL=zh_CN.utf8 gnucash
```