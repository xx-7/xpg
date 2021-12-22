# ips

```bash

/ip firewall address-list remove [/ip firewall address-list find list=VPN]
/ip firewall address-list

sudo pacman -S bind-tools
nslookup -q=TXT _netblocks[1-5].google.com 8.8.8.8

ip firewall address-list
add list=VPN comment=_netblocks5.google.com address=209.85.218.92/30
add list=VPN address=209.85.161.92/30
add list=VPN address=209.85.210.220/30
add list=VPN address=35.190.247.0/24
add list=VPN address=64.233.160.0/19
add list=VPN address=66.102.0.0/20

```

# 安装固件

```bash
# https://wiki.mikrotik.com/wiki/Manual:Netinstall
# https://mikrotik.com/product/rb4011igs_rm#fndtn-downloads
# https://mikrotik.com/download

# 设置ip为 192.168.88.2 gateway 192.168.88.1
# 打开netinstall 设置 net booting server: 192.168.88.3
# 断开路由电源, 有线连接到路由第一个口, 按信复位键插入电源, 直到 netinstall drives 里出现设备松开
# 浏览目录，选择包进行安装

```