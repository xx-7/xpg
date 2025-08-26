# 下载写U盘

```bash

# https://archlinux.org/download/#http-downloads
sudo dd bs=4M if=./archlinux-2025.07.01-x86_64.iso of=/dev/sdX conv=fsync oflag=direct status=progress

lsblk

# 蜂鸣
rmmod pcspkr

# 有这个文件夹即 UEFI启动
ls /sys/firmware/efi/efivars

```


# 分区

```bash

# 分区方案
/boot  # 512MB 启动目录 
[SWAP] # 16G swap
/      # 剩余  根目录(加密)

# 查看已加载硬盘
lsblk

# 分区
fdisk /dev/sda

# 扇区 34 - 2047 创建gpt分区表
g

# 重复创建分区

# 新建 
# 分区类型选 p primary
# first不选就默认, last不选全用
n +512M
n +16G

# 显示已创建
p

# 写入
w


# 设置 efi标志
# 先输入命令 t -> 选择分区 -> L 显示代码 -> ef00
gdisk /dev/sda


# 加密硬盘
# 性能测试
cryptsetup benchmark

# yes 要输入大写
cryptsetup luksFormat -s 256 /dev/sda3

# 挂载 /dev/mapper/$DM_NAME -> /dev/mapper/arch-rootfs
cryptsetup open /dev/sda3 arch-rootfs

ls -l /dev/mapper/

# 提高SSD性能，禁用工作队列
cryptsetup --perf-no_read_workqueue --perf-no_write_workqueue --persistent refresh arch-rootfs


mkfs.fat -F 32 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/mapper/arch-rootfs

mount /dev/mapper/arch-rootfs /mnt
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/sda2


```

# 配置安装环境

```bash
# 刷新本地时间
timedatectl set-ntp true

# 镜像
nano /etc/pacman.d/mirrorlist
#1.[F6] 搜索 china
#2.[方向键] 移动光标至 Server 行
#3.[CTRL+K] 剪切该行
#4.[方向键] 移动光标至其他 Server 行前
#5.[CTRL+U] 粘贴至此行
#6.[CTRL+O] 保存，[回车键] 确定

```

# 安装系统

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

locale -a

nano /etc/locale.conf
LANG=en_US.UTF-8

# 主机名
echo $HOSTNAME > /etc/hostname


# 修改ROOT密码 后期如果忘记密码也可以通过安装盘启动arch-chroot进来直接修改密码
passwd

nano /etc/vconsole.conf
KEYMAP=us
XKBLAYOUT=us


# 安装微码更新 intel-ucode (amd请安装amd-ucode)
pacman -S intel-ucode

# 使用systemd-boot (systemd包)
bootctl --path=/boot install

# 查看根目录 uuid
blkid /dev/sda3

# 4. 新增systemd-boot的引导配置，并增加相关内核参数
# options 解释 cryptdevice=UUID=加密容器的UUID，可以通过 blkid 命令查看:映射设备名 root=根分区"
cat /boot/loader/entries/arch.conf   
title Arch Linux
linux vmlinuz-linux
initrd intel-ucode.img
initrd initramfs-linux.img
options cryptdevice=UUID=bc31f0a4-436b-4849-a28c-46ae6c608643:arch-rootfs root=/dev/mapper/arch-rootfs quiet rw

# 查看配置
bootctl list

# 内核 HOOKS
/etc/mkinitcpio.conf
HOOKS=(base udev autodetect modconf kms keyboard keymap consolefont block encrypt filesystems fsck)

# 重新构建镜像
mkinitcpio -P

# 完成安装
exit
umount -R /mnt
reboot

```

# 配置安装软件 

```bash

# 设置用户

useradd -m -g users -G wheel,lp,network,power -s /bin/bash fex
passwd fex

pacman -S sudo
# sudo
EDITOR=nano visudo
Defaults:fex rootpw
Defaults:fex timestamp_timeout=20
fex ALL=(ALL) ALL

# 安装桌面环境

sudo pacman -S xorg xfce4 xorg-server lightdm lightdm-gtk-greeter xscreensaver
# 不装桌面管理器,直接 startxfce4 启动

sudo systemctl enable lightdm

sudo pacman -S firefox mpv unarchiver gimp gwenview evince flameshot remmina

paru -S ttf-fira-code adobe-source-code-pro-fonts ttf-lxgw-wenkai-mono-lite

paru -S google-chrome visual-studio-code-bin jdk8-openjdk jdk11-openjdk

# systemd 方式设置静态IP
sudo nano /etc/systemd/network/eth0.network
[Match]
Name=$INTERFACE

[Network]
Address=10.8.8.28/24
Gateway=10.8.8.1
DNS=10.8.8.1

systemctl enable systemd-networkd
systemctl restart systemd-networkd


# paru
pacman -S git rust base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si


```