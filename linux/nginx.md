# 安装

```bash
rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm

rpm -ivh http://nginx.org/packages/centos/7/x86_64/RPMS/nginx-1.14.0-1.el7_4.ngx.x86_64.rpm

yum -y install nginx
systemctl enable nginx
useradd nginx -s /sbin/nologin -M
mkdir /home/nginx
chown nginx:nginx /home/nginx
```

# 认证证书设置

```bash
vi /etc/nginx/nginx.conf

worker_processes  2;
user nginx nginx;
error_log  /home/nginx/error.log;
pid        /run/nginx.pid;

events {
    use epoll;
    worker_connections  1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
    access_log  /home/nginx/access.log  main;

    sendfile        on;
    tcp_nopush     on;
    keepalive_timeout  65;
    gzip  on;

    include /etc/nginx/conf.d/*.conf;
}
```

# java 站点

```bash

# nano /etc/nginx/conf.d/test.conf

server {
    listen       443;
    server_name  domain.com;

    charset utf-8;
    access_log  /home/nginx/ssl-access.log  main;

    location / {
        root   html;
        index  login.shtml;

        proxy_pass        http://127.0.0.1:88;
        proxy_redirect off;
        proxy_set_header  Host  $host;
        proxy_set_header  X-Real-IP  $remote_addr;
        proxy_set_header  X-Forwarded-For  $proxy_add_x_forwarded_for;
        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
    }

    location /ws/ {
        proxy_pass        http://127.0.0.1:88;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

    location ~ ^/(WEB-INF)/ {
        deny all;
    }

    ssl_certificate /etc/letsencrypt/live/domain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/domain.com/privkey.pem;

}

```

# java 站点 2

```bash

# nano /etc/nginx/conf.d/test.conf

server {
    listen       443    ssl;
    server_name  a.domain.com;

    charset utf-8;
    access_log  /home/nginx/ssl-access.log  main;

    location / {
        root /home/www;
        index index.html index.htm;
    }

    location /ws1 {
        proxy_pass        http://127.0.0.1:9002;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
    ssl_certificate /etc/letsencrypt/live/a.domain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/a.domain.com/privkey.pem;
}

```

# 删除默认站点

```bash

mv /etc/nginx/sites-available/default /home/nginx/default_bak

touch /etc/nginx/sites-available/default
```

# access_log main 出错

```bash

# log_format 写到http头
nano /etc/nginx/nginx.conf

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                   '$status $body_bytes_sent "$http_referer" '
                     '"$http_user_agent" "$http_x_forwarded_for"';

```
