# clash

```bash

# https://github.com/Dreamacro/clash/releases

curl -O https://github.com/Dreamacro/clash/releases/download/v1.15.1/clash-linux-amd64-v1.15.1.gz
mkdir -p /optd/opt/clash/
tar -xf clash-linux-amd64-v1.15.1.gz -C /optd/opt/clash/
chmod +x /optd/opt/clash/clash-linux-amd64-v1.15.1

nano ~/.config/clash/config.yaml

# dns本地请求
- DST-PORT,53,DIRECT

```

```yaml
port: 11018
socks-port: 11019

allow-lan: true
mode: rule
log-level: info

proxies:
  # trojan
  - name: "s2"
    type: trojan
    server: "s.google.com"
    port: 443
    password: "TEXDSDFEWS"

  # trojan
  - name: "w0"
    type: trojan
    server: "s.google.com"
    port: 443
    password: "TEXDSDFEWS"

  # socks5
  - name: "w1"
    type: socks5
    server: "10.8.8.28"
    port: 58089

proxy-groups:
  - name: S2
    type: select
    proxies:
      - "s2"

  - name: W0
    type: select
    proxies:
      - "w0"

rules:
  - IP-CIDR,127.0.0.0/8,W0
  - SRC-IP-CIDR,192.168.1.1/32,S2
  - MATCH,S2
```

## TUN

```bash
# https://dreamacro.github.io/clash/premium/tun-device.html
# https://github.com/Dreamacro/clash/releases/tag/premium

# clash premium 版有一个tun功能 就是虚拟一个网卡然后改路由导过去
# 虚拟网卡
# 提前创建好nic  再指定好用户 分配路由 不用root也可以运行

# 旁路由 流量走utun 直接设置如果不要nat nat完要么游戏直接走了，要么显示源ip是utun ip

# 程序管理网络权限
sudo apt install libcap2-bin
sudo setcap cap_net_admin+ep /opt/clash
sudo getcap /opt/clash

sudo ip tuntap add mode tun user pi name utun
sudo ifconfig utun up

# 删除虚拟网卡
sudo ip link delete utun

# 将某个ip段的请求路由utun
sudo ip rule add from 192.168.1.0/24 table 202

# rule添加了就有效 default route每次clash重启要设置一次
sudo ip route add default dev utun table 202

sudo ip rule show

sudo ip route show

nano ~/.config/clash/config.yaml

cd /opt/clash && nohup ./clash > nohup.log 2>&1 &

tun:
  enable: true
  dns-listen: 0.0.0.0:53
  auto-route: false
  auto-redir: false
  auto-detect-interface: false


cat > /opt/clash/route.sh << EOF
#!/bin/bash

ip rule del from 192.168.1.0/24 table 202
ip rule add from 192.168.1.0/24 table 202
ip route del default table 202
ip route add default dev utun table 202
EOF

chmod +x /opt/clash/route.sh

sudo /opt/clash/route.sh

```
