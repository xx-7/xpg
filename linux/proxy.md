# use

```bash
export {http,https,ftp,rsync,all}_proxy=socks5://127.0.0.1:11028
export {HTTP,HTTPS,FTP,RSYNC,ALL}_PROXY=socks5://127.0.0.1:11028

export {http,https,ftp,rsync,all}_proxy=http://172.17.0.1:11018
export {http,https,ftp,rsync,all}_proxy=http://127.0.0.1:11018

```

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

proxy-groups:
  - name: S2
    type: select
    proxies:
      - "s2"

rules:
  - MATCH,S2

```