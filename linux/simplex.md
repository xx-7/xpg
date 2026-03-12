
# Docker

```bash

mkdir -p ./simplex/{xftp,smp}/{config,logs} && mkdir -p ./simplex/xftp/files


certbot certonly --standalone -d YOUR_DOMAIN --key-type rsa --rsa-key-size 4096
cp /etc/letsencrypt/live/YOUR_DOMAIN/fullchain.pem ./simplex/smp/config/YOUR_DOMAIN.crt
cp /etc/letsencrypt/live/YOUR_DOMAIN/privkey.pem ./simplex/smp/config/YOUR_DOMAIN.key

# 通过日志看地址
docker ps --all
docker logs

docker run -d \
    -e "ADDR=YOUR_DOMAIN" \
    -e "PASS=YOURPASSWORD" \
    -p 5223:5223 \
    -v ./simplex/smp/config:/etc/opt/simplex:z \
    -v ./simplex/smp/logs:/var/opt/simplex:z \
    simplexchat/smp-server:latest


docker run -d \
    -e "ADDR=YOUR_DOMAIN" \
    -e "QUOTA=10gb" \
    -e "PASS=YOURPASSWORD" \
    -p 443:443 \
    -v ./simplex/xftp/config:/etc/opt/simplex-xftp:z \
    -v ./simplex/xftp/logs:/var/opt/simplex-xftp:z \
    -v ./simplex/xftp/files:/srv/xftp:z \
    simplexchat/xftp-server:latest



```