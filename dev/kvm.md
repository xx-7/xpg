
```bash

# https://wiki.debian.org/KVM

# 图形
sudo apt install qemu-system libvirt-daemon-system

# 无图形
sudo apt install --no-install-recommends qemu-system libvirt-clients libvirt-daemon-system

# 图形管理界面
sudo apt install virt-manager

sudo apt install bridge-utils

# 桥接网络设置
# https://jamielinux.com/docs/libvirt-networking-handbook/bridged-network.html

# 原网络设置为manual 也不用自动启动加入到桥中就好
# 注意 bridge_stp bridge_fd 关闭不然时断时断的
sudo nano /etc/network/interfaces

iface eth0 inet manual

auto br0
iface br0 inet static
   address 192.168.1.28
   netmask 255.255.255.0
   gateway 192.168.1.1
   bridge_ports eth0
   bridge_stp off
   bridge_fd 0

```