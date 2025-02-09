# zone

```bash

cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

```

# ntp

```bash

# 保存硬件时间
hwclock --systohc --localtime

# centos
yum install ntp

# debain
sudo apt install ntpdate

# arch
sudo pacman -S ntp

sudo ntpdate time.windows.com && sudo hwclock -w

sudo ntpdate us.pool.ntp.org && sudo hwclock -w

sudo ntpdate cn.pool.ntp.org && sudo hwclock -w


sudo timedatectl set-time '2025-02-14 14:30:00'

```