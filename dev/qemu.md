# 安装设置

```bash

# arch
# https://wiki.archlinux.org/title/QEMU#
sudo pacman -S qemu-desktop libvirt virt-manager bridge-utils
sudo systemctl start libvirtd
sudo systemctl start spice-vdagentd

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

sudo usermod -aG libvirt $USER

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

# arch

sudo nano /etc/systemd/network/25-br0.netdev

[NetDev]
Name=br0
Kind=bridge

sudo nano /etc/systemd/network/br0.network

[Match]
Name=br0

[Network]
Address=10.8.8.21/24
Gateway=10.8.8.1
DNS=10.8.8.1

sudo nano /etc/systemd/network/enp89s0.network

[Match]
Name=enp89s0

[Network]
Bridge=br0

sudo systemctl restart systemd-networkd


# https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe
# https://wiki.debian.org/BridgeNetworkConnections#Manual_bridge_setup
# windows 客户端装 spice-guest-tools 同步复制粘贴
```
# 虚拟机管理

```bash
virsh list                  # 查看在运行的虚拟机
virsh dumpxml vm-name       # 查看kvm虚拟机配置文件
virsh start vm-name         # 启动kvm虚拟机
virsh shutdown vm-name      # 正常关机

virsh destroy vm-name       # 非正常关机，强制关闭虚拟机（相当于物理机直接拔掉电源）
virsh undefine vm-name      # 删除vm的配置文件

ls  /etc/libvirt/qemu       # 默认虚拟机配置文件目录

virsh define file-name.xml  # 根据配置文件定义虚拟机
virsh suspend vm-name       # 挂起，终止
virsh resume vm-name        # 恢复被挂起的虚拟机
virsh autostart vm-name     # 开机自启动vm
virsh console vm-name       # 连接虚拟机
```

# 磁盘管理

```bash

qemu-img create -f qcow2 test.img 100G                          #创建虚拟盘
qemu-img info test.img                                          #查看虚拟盘信息
qemu-img resize test.img +100G                                  #调整虚拟盘大小
qemu-img convert -f vmdk -O qcow2 test.vmdk test.img            #格式转换 vmdk -> qcow2


sdelete -z C:                                                   #先碎片整理以c盘再sdel清零,非系统盘不用sdel直接可转换
qemu-img convert -O qcow2 old.img new.img                       #转换调整大小

```