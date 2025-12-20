# wifi

```bash

# 检查驱动
lspci -v | grep -A 10 "Ethernet controller"
lspci -v | grep -A 10 "Network"

# 重启网络
sudo systemctl restart networking

# 一个小时内的日志
sudo journalctl -u networking.service --since "1 hour ago"

# 开启网卡
sudo ip link set wlp132s0f0 up

# 关闭网卡
sudo ip link set wlp132s0f0 down


sudo apt install wpasupplicant

sudo systemctl stop wpa_supplicant.service
sudo systemctl disable wpa_supplicant.service

# wpa_cli 在 /usr/sbin/
export PATH=$PATH:/usr/sbin


sudo mkdir /etc/wpa_supplicant

sudo cat >> /etc/wpa_supplicant/wpa_supplicant.conf << EOF
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
EOF

sudo wpa_supplicant -B -i wlp132s0f0 -c /etc/wpa_supplicant/wpa_supplicant.conf

wpa_cli scan

wpa_cli scan_results

wpa_cli add_network
wpa_cli set_network 0 ssid '"TPLINK-12F658"'
wpa_cli set_network 0 psk '"12348765"'
wpa_cli disable_network 0
wpa_cli enable_network 0

# 状态
wpa_cli status

# 动态获取ip
sudo apt install udhcpc
sudo udhcpc -n -q -i wlp132s0f0

# 添加路由
sudo ip route add 192.168.1.0/24 dev wlp132s0f0
sudo ip route show

```

# rfkill

```bash
# 可以查看开关 硬件功能

sudo apt install rfkill

# 显示 功能开关状态
/usr/sbin/rfkill list

# 关闭
/usr/sbin/rfkill blonk 1

# 开启
/usr/sbin/rfkill unblock 1

# 要换开启关闭
/usr/sbin/rfkill toggle 1

```
