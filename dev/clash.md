# clash

```bash

# https://github.com/Dreamacro/clash/releases

curl -O https://github.com/Dreamacro/clash/releases/download/v1.15.1/clash-linux-amd64-v1.15.1.gz
mkdir -p /optd/opt/clash/
tar -xf clash-linux-amd64-v1.15.1.gz -C /optd/opt/clash/
chmod +x /optd/opt/clash/clash-linux-amd64-v1.15.1

nano ~/.config/clash/config.yaml

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
  - MATCH,S2
```

## TUN

```bash
# https://dreamacro.github.io/clash/premium/tun-device.html
# https://github.com/Dreamacro/clash/releases/tag/premium

# clash premium 版有一个tun功能 就是虚拟一个网卡然后改路由导过去
# 虚拟网卡
# 提前创建好nic  再指定好用户 分配路由 不用root也可以运行


sudo ip tuntap add mode tun user pi name ttun
sudo ifconfig ttun up

sudo ip route add 198.168.1.1/24 dev ttun

nano ~/.config/clash/config.yaml

tun:
    enable: true
    device-url: dev://ttun
    dns-listen: 0.0.0.0:53
    auto-route: false
    auto-redir: false
    auto-detect-interface: false



```