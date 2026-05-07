


# certbot

```bash
sudo apt install certbot

# 先要关防火墻 证书目录 /etc/letsencrypt/live/YOUR_DOMAIN/
sudo certbot certonly -d YOUR_DOMAIN


sudo certbot certonly --standalone -d YOUR_DOMAIN --key-type rsa --rsa-key-size 4096

# 续期
sudo certbot renew



sudo certbot delete --cert-name example.com

# 续期不显示输出
/usr/bin/certbot renew --quiet


```

# timer

```bash


cat >> /usr/lib/systemd/system/cert.timer << EOF
[Timer]
OnBootSec=10s
OnUnitActiveSec=30day
AccuracySec=1ms
Unit=cert-timerd.service

[Install]
WantedBy=multi-user.target
EOF


cat >> /usr/lib/systemd/system/cert-timerd.service << EOF
[Unit]
Description=cert timer.sh

[Service]
ExecStart=/bin/bash /zfs/opt/cert_timer.sh
EOF

cat >> /usr/lib/systemd/system/cert-timerd.service << EOF
[Unit]
Description=cert timer.sh

[Service]
ExecStart=/bin/bash /zfs/opt/cert_timer.sh
EOF


cat >> /zfs/opt/cert_timer.sh << EOF
#!/bin/bash
echo "`date` run cert timer!!!"  >> /tmp/timer.log


/usr/bin/certbot renew --quiet 

systemctl reload nginx 

sleep 5s
EOF

sudo systemctl enable cert.timer

```