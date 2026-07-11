

# debian

```bash
# 查看内核版本
uname -a
# 查看源中内核
apt-cache search linux-image
# 安装内核
apt install linux-image-6.1.0-17-amd64
# 删除旧内核，如果是运行中内核会弹出窗口选No
apt remove linux-image-6.1.0-15-cloud-amd64

```

# arch

```bash

# 查看内核版
uname -a

# lts 长期支持更新会少点
sudo pacman -S linux-lts linux-lts-headers

sudo mkinitcpio -p linjx-lts && sudo grub-mkconfig -o /boot/grub/grub.cfg


```