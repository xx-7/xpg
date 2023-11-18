```bash

# 转发直接装iptables 不要装firewalld, 不要装firewalld nat and filter也是用的iptables
# 查到是否有ap功能
sudo iw list | grep "Supported interface modes" -A 8
# 查看已连接用户
sudo iw dev wlan0 station dump
# 已经连接对应mac ip
sudo awk '$4~/[1-9a-f]+/&&$6~/^wl/{print "ip: "$1" mac: "$4}' /proc/net/arp

sudo apt install hostapd dnsmasq

sudo systemctl unmask hostapd.service

sudo service dnsmasq restart
sudo service hostapd restart

# 调试模式启动
sudo hostapd -d /etc/hostapd/hostapd.conf

nano /etc/network/interfaces

auto wlan0
iface wlan0 inet static
address 192.168.1.1
netmask 255.255.255.0

cat > /etc/hostapd/hostapd.conf << EOF
interface=wlan0
ssid=NAMENAME
hw_mode=g
channel=6
country_code=IN
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=12345678
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
EOF

cat > /etc/dnsmasq.conf << EOF
interface=wlan0
dhcp-range=192.168.1.2,192.168.1.199,255.255.255.0,12h
dhcp-option=option:router,192.168.1.1
dhcp-option=option:dns-server,192.168.1.1
EOF

# dhcp 开放端口: 67,68,546

# 开启转发

nano /etc/sysctl.conf
net.ipv4.ip_forward = 1

sudo systemctl restart networking

# wifi 已经可以连上 需要设置nat才能上网
# 也可以跟本地网卡桥接, dnsmasq也可以不装

# 禁用 NetworkManager 管理接口

sudo systemctl restart NetworkManager
sudo nano /etc/NetworkManager/NetworkManager.conf
[main]
plugins=ifupdown,keyfile

[ifupdown]
managed=false

[keyfile]
unmanaged-devices=interface-name:wlan0


```
