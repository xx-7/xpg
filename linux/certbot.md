


# certbot

```bash
sudo apt install certbot

# 先要关防火墻 证书目录 /etc/letsencrypt/live/YOUR_DOMAIN/
sudo certbot certonly -d YOUR_DOMAIN


sudo certbot certonly --standalone -d YOUR_DOMAIN --key-type rsa --rsa-key-size 4096

# 续期
sudo certbot renew


```