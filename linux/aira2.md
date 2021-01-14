# aira2

```bash

apt install aria2

mkdir /etc/aria2
touch /etc/aria2/aria2.session
chmod 777 /etc/aria2/aria2.session
nano /etc/aria2/aria2.conf

dir=/home/downloads

disk-cache=16M

continue=true

log=aria2.log

max-concurrent-downloads=100
max-connection-per-server=16

max-overall-download-limit=0
max-download-limit=0
max-overall-upload-limit=0
max-upload-limit=0
disable-ipv6=true
min-split-size=10M
split=16

input-file=/etc/aria2/aria2.session
save-session=/etc/aria2/aria2.session
save-session-interval=60

enable-rpc=true
rpc-allow-origin-all=true
rpc-listen-all=true

rpc-listen-port=8899
rpc-secret=6fTnH5uU9beYkggEKLUN0


rpc-secure=true
rpc-certificate=/etc/letsencrypt/live/s.domain.com/fullchain.pem
rpc-private-key=/etc/letsencrypt/live/s.domain.com/privkey.pem

follow-torrent=true
listen-port=51413
enable-dht=true
enable-dht6=false
dht-listen-port=6881-6999

bt-enable-lpd=true
enable-peer-exchange=true
bt-request-peer-speed-limit=50K

peer-id-prefix=-TR2770-
user-agent=Transmission/2.77

seed-ratio=0

force-save=true
bt-seed-unverified=true
bt-save-metadata=true
bt-max-peers=0
bt-detach-seed-only=true
bt-tracker=udp://tracker.coppersurfer.tk:6969/announce,udp://tracker.internetwarriors.net:1337/announce,udp://tracker.opentrackr.org:1337/announce





# 测试
aria2c --conf-path=/etc/aria2/aria2.conf
# 后台启动
aria2c --conf-path=/etc/aria2/aria2.conf -D

# 某前端 http://webui-aria2.ghostry.cn/
# https://github.com/ziahamza/webui-aria2
```