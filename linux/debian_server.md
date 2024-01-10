[TOC]

# 版本号

[Releases](https://www.debian.org/releases/index.zh-cn.html)

- Debian 13 "trixie"
- Debian 12 "bookworm"
- Debian 11 "bullseye"
- Debian 10 "buster"
- Debian 9 "stretch"
- Debian 8 "jessie"
- Debian 7 "wheezy"
- Debian 6.0 "squeeze"
- Debian GNU/Linux 5.0 "lenny"
- Debian GNU/Linux 4.0 "etch"
- Debian GNU/Linux 3.1 "sarge"
- Debian GNU/Linux 3.0 "woody"
- Debian GNU/Linux 2.2 "potato"
- Debian GNU/Linux 2.1 "slink"
- Debian GNU/Linux 2.0 "hamm"

# 配置

## 内核

```bash
# 查看内核版本
uname -a
# 查看源中内核
apt-cache search linux-image
# 安装内核
apt install linux-image-6.1.0-17-amd64
# 删除旧内核，如果是运行中内核会弹出窗口选No
apt remove linux-image-6.1.0-15-cloud-amd64

```

## 多 IP

```bash
nano /etc/network/interfaces

auto eno1:0
iface eno1:0 inet static
address 10.8.8.225
netmask 255.255.255.240
gateway 10.8.8.1

ifup eno1:0

```

## ssh

```bash
# generate key
ssh-keygen -t rsa

# ssh client
ssh -i ~/.ssh/id_rsa USER@SERVER
#or
nano ~/.ssh/config
Host www.domain.com www2.domain.com
port 77
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_rsa_local

# ssh server
apt install openssh-server
mkdir -p ~/.ssh/
nano /etc/ssh/sshd_config


StrictModes no
PermitRootLogin yes

RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile      .ssh/rsa_wx.pub #rsa_pub pub key file

PasswordAuthentication no

systemctl restart sshd

nano .ssh/authorized_keys

```

## Mysql

```bash
sudo apt install mariadb-server
sudo mysql_secure_installation
sudo systemctl disable mariadb
sudo systemctl restart mariadb

# 建库

# 导入
mysqldump -u用户名 -p密码 -h主机 数据库 < 路径 #导入
# 导出
mysqldump -u用户名 -p密码 -h主机 数据库 > 路径
\. /path/file.sql
```

## Redis

```bash
apt install gcc make
wget http://download.redis.io/redis-stable.tar.gz
tar -zxvf redis-stable.tar.gz
cd redis-stable
make

apt install redis-server

nano /etc/redis/redis.conf
```

## certbot

```bash
apt install certbot

# 先要关防火墻 证书目录 /etc/letsencrypt/live/
certbot certonly -d s.xxxx.com

# 续期
certbot renew

# 复制时可以直接cp链接 不用到实际目录
```

## iptables

```bash

# 添加放行
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# 查看
iptables -L -n

# 清除所有, 没有stop要关时先save然后清除所有，开时再restore回来
iptables -F
iptables -X

# 保存
iptables-save > /etc/iptables.up.rules
# 恢复
iptables-restore < /etc/iptables.up.rules

# 开机自动加载
nano /etc/network/if-pre-up.d/iptables

#!/bin/sh
/sbin/iptables-restore < /etc/iptables.up.rules

chmod +x /etc/network/if-pre-up.d/iptables

```

## rc.local

```bash
nano /etc/rc.local
#!/bin/sh


exit 0

chmod +x /etc/rc.local

systemctl enable rc.local

# startup
cd /home/$PATH && nohup ./$BIN > nohup.log 2>&1 &

```

## IpSec VPN

```bash
wget https://git.io/vpnsetup -O vpnsetup.sh
chmod 777 vpnsetup.sh
VPN_IPSEC_PSK='6fTnH5uU9beYkggEKLUN0' \
VPN_USER='zxz' \
VPN_PASSWORD='XzxTop' \
sh vpnsetup.sh
```

## sysctl.conf

```bash
nano /etc/sysctl.conf

net.ipv4.ip_forward = 0
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
kernel.sysrq = 0
kernel.core_uses_pid = 1
net.ipv4.tcp_syncookies = 1
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.shmmax = 68719476736
kernel.shmall = 4294967296
net.ipv4.tcp_max_tw_buckets = 6000
net.ipv4.tcp_sack = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_rmem = 10240 131072 12582912
net.ipv4.tcp_wmem = 10240 131072 12582912
net.core.wmem_default = 8388608
net.core.wmem_max = 16777216
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.netdev_max_backlog = 262144
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.tcp_max_syn_backlog = 262144
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_synack_retries = 1
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_fin_timeout = 15
net.ipv4.tcp_keepalive_time = 30
net.ipv4.ip_local_port_range = 2048 65000
fs.file-max = 524288
fs.inotify.max_user_watches=524288
net.ipv6.conf.all.disable_ipv6=1


# disable_ipv6 有时候系统只开ipv6自动启动，disable网卡不会随系统启动
```

## nginx

```bash
apt install nginx

```

### webdev

```bash
# 开webdev

mkdir /home/downloads
chmod 777 /home/downloads

nano /etc/nginx/conf.d/webdev.conf

server {
    listen       88;
    server_name  s.domain.com;
    error_log /var/log/nginx/webdav.error.log error;
    access_log  /var/log/nginx/webdav.access.log combined;
    location / {
        root /home/downloads;
        charset utf-8;
        autoindex on;
        dav_methods PUT DELETE MKCOL COPY MOVE;
        dav_ext_methods PROPFIND OPTIONS;
        create_full_put_path  on;
        dav_access user:rw group:r all:r;
        auth_basic "Authorized Users Only";
        auth_basic_user_file /etc/nginx/.htpasswd;
    }
    ssl on;
    ssl_certificate /etc/letsencrypt/live/s.domain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/s.domain.com/privkey.pem;
}

# 设置密码
apt install apache2-utils
htpasswd -c /etc/nginx/.htpasswd $USER

systemctl restart nginx

```

### max_user_watches

```bash

# insert the new value into the system config
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

# check that the new value was applied
cat /proc/sys/fs/inotify/max_user_watches

```

### cron

```bash

apt install cron

# 编辑crontab服务文件
crontab  -e

systemctl stop cron
systemctl restart cron

systemctl enable cron

```

### 备份删除新安装

```bash

# 安装前保存列表
dpkg --get-selections | cut -f 1 > /tmp/packages_orig.lst

# 安装后再保存列表跟前面对比删除
dpkg --get-selections | cut -f 1 > /tmp/packages_curr.lst
grep -Fxv -f /tmp/packages_orig.lst /tmp/packages_curr.lst | xargs sudo -E apt remove -y --purge

# 清除缓存
sudo -E apt -qq clean
sudo -E rm -rf /var/lib/apt/lists/* /tmp/wine-*

```
