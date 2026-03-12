
# Docker

```bash

mkdir -p ./simplex/{xftp,smp}/{config,logs} && mkdir -p ./simplex/xftp/files


certbot certonly --standalone -d YOURDOMAINNAME --key-type rsa --rsa-key-size 4096
cp /etc/letsencrypt/live/YOURDOMAINNAME/fullchain.pem ./simplex/smp/config/YOURDOMAINNAME.crt
cp /etc/letsencrypt/live/YOURDOMAINNAME/privkey.pem ./simplex/smp/config/YOURDOMAINNAME.key

# 通过日志看地址
docker ps --all
docker logs

docker run -d \
    -e "ADDR=YOURDOMAINNAME" \
    -e "PASS=YOURPASSWORD" \
    -p 5223:5223 \
    -v ./simplex/smp/config:/etc/opt/simplex:z \
    -v ./simplex/smp/logs:/var/opt/simplex:z \
    simplexchat/smp-server:latest


docker run -d \
    -e "ADDR=YOURDOMAINNAME" \
    -e "QUOTA=10gb" \
    -e "PASS=YOURPASSWORD" \
    -p 443:443 \
    -v ./simplex/xftp/config:/etc/opt/simplex-xftp:z \
    -v ./simplex/xftp/logs:/var/opt/simplex-xftp:z \
    -v ./simplex/xftp/files:/srv/xftp:z \
    simplexchat/xftp-server:latest



```