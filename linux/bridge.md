```bash

# https://wiki.debian.org/BridgeNetworkConnections
sudo apt install bridge-utils

sudo pacman -S bridge-utils

iface eth0 inet manual

auto br0
iface br0 inet static
   address 192.168.1.28
   netmask 192.168.1.0
   gateway 192.168.1.1
   bridge_ports eth0
   bridge_stp off
   bridge_fd 0


# 重启网络
sudo systemctl restart networking

# brctl 配置重启会失效
# show br0
sudo brctl show br0
sudo brctl show 
# 添加桥
sudo brctl addbr br0
# 删除桥
sudo brctl delbr br0
# 网卡加入桥
sudo brctl addif br0 eth0 eth1
# 网卡移出桥
sudo brctl delif br0 eth0

# kvm docker 同时使用bridge 默认会有冲突 
# docker 启动时会创建 docker0 共享物理网卡 如br0共享同一网卡就会起冲突导致kvm虚拟桥接上不网 nat可以

# 设置docker 也使用br0
sudo nano /etc/docker/daemon.json

{
  "bridge": "br0",
  "default-gateway": "192.168.1.1"
}

sudo systemctl restart docker 



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

```