```bash
sudo groupadd git
sudo useradd git -m -g git -s /bin/bash

cd /home/git
wget https://dl.gogs.io/0.13.0/gogs_0.13.0_linux_amd64.tar.gz
tar -zxvf gogs_0.13.0_linux_amd64.tar.gz


sudo cp gogs/scripts/systemd/gogs.service /lib/systemd/system/
sudo systemctl enable gogs
sudo systemctl start gogs

mkdir -p /disk/store
mkdir -p /disk/gogs

sudo chown -R git:git /disk/store
sudo chown -R git:git /disk/gogs

gogs/

# 数据库里重置用户密码为123456
update user set passwd='b4af39cca17a2231fead3c06908d352fd367c123fceb7256caeedf032b0d87c8a00a0e86a72f1003622baccbaa6cb511ea57',rands='FPU4fPdLbK',salt='6sQ8yJ1aGz' where id==2;

```

```conf
# INSTALL_LOCK = false 才可以打开/install页面
# 默认配置: https://github.com/gogs/gogs/blob/main/conf/app.ini

RUN_USER   = git
RUN_MODE   = prod
APP_NAME   = Hyx
BRAND_NAME = Hyx

[server]
PROTOCOL         = http
DOMAIN           = $DOMAIN
HTTP_ADDR        = 127.0.0.1
HTTP_PORT        = 3001
DISABLE_SSH      = false
SSH_PORT         = 5022
START_SSH_SERVER = true
OFFLINE_MODE     = false
EXTERNAL_URL     = $PUBURL

[repository]
ROOT           = /disk/store
DEFAULT_BRANCH = main

[database]
HOST     = 127.0.0.1:3306
NAME     = gogsdb
USER     = gogs
PASSWORD = $PASSWORD
TYPE     = mysql
SSL_MODE = disable
SCHEMA   = public
PATH     = /home/git/gogs/data/gogs.db

[mailer]
ENABLED = false

[picture]
DISABLE_GRAVATAR        = false
ENABLE_FEDERATED_AVATAR = false

[session]
PROVIDER = file

[log]
MODE      = file
LEVEL     = Info
ROOT_PATH = /disk/gogs/log

[security]
INSTALL_LOCK            = true
SECRET_KEY              = RYf7P9xxxx
LOCAL_NETWORK_ALLOWLIST = *

[auth]
REQUIRE_EMAIL_CONFIRMATION  = false
DISABLE_REGISTRATION        = true
ENABLE_REGISTRATION_CAPTCHA = false
REQUIRE_SIGNIN_VIEW         = false


```