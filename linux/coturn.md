# install

```bash

sudo apt install coturn

cat >> /etc/turnserver.conf << EOF
tls-listening-port=7349

listening-ip=0.0.0.0
listening-port=3478

fingerprint

lt-cred-mech

user=YOUR_USER:YOUR_PASS

server-name=YOUR_DOMAIN

realm=YOUR_DOMAIN

cert=/etc/letsencrypt/live/YOUR_DOMAIN/fullchain.pem
pkey=/etc/letsencrypt/live/YOUR_DOMAIN/privkey.pem

# dh2066

min-port=49152
max-port=49500

syslog

proc-user=turnserver
proc-group=turnserver

no-tlsv1
no-tlsv1_1
no-tlsv1_2

EOF

# URI: stun:YOUR_DOMAIN:7349
# URI: turn:YOUR_USER:YOUR_PASS@YOUR_DOMAIN:7349

# 7349 防火墙要同时打开 tcp udp

sudo systemctl restart coturn
sudo systemctl enable coturn

# letsencrypt live和archive 目录默认root用户外没权限
sudo chmod 755 /etc/letsencrypt/live
sudo chmod -R 755 /etc/letsencrypt/archive

# 查看日志
sudo cat /var/log/messages | grep turnserver

# 查看日志
sudo journalctl -u coturn.service -n 50

# 清空日志
echo "" > /var/log/messages

# Test URL: https://icetest.info/

```