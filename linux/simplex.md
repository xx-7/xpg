
# install

```bash

# simplex 可在创建聊天后选择切换服务器进行通信
# ios notifications 是要从 smp -> simplex.chat -> apple 所以服务器被墙情况下通知用不了
# 最优方案是 smp, xtfp放墙外, webrtx coturn放墙内加速通话
# https://status.simplex.chat/status/public

mkdir -p /var/simplex/{xftp,smp}/{config,logs} && mkdir -p /var/simplex/xftp/files


certbot certonly --standalone -d YOUR_DOMAIN --key-type rsa --rsa-key-size 4096

sudo cp /etc/letsencrypt/live/YOUR_DOMAIN/fullchain.pem /var/simplex/smp/config/cert.crt
sudo cp /etc/letsencrypt/live/YOUR_DOMAIN/privkey.pem /var/simplex/smp/config/key.key

# 通过日志看地址
docker ps --all
docker logs smp

docker pull simplexchat/xftp-server:latest
docker pull simplexchat/smp-server:latest

docker restart smp

# https://simplex.chat/docs/server.html

docker run -d \
    --name smp \
    -e "ADDR=YOUR_DOMAIN" \
    -e "PASS=YOURPASSWORD" \
    -p 7223:7223 \
    -v /var/simplex/smp/config:/etc/opt/simplex:z \
    -v /var/simplex/smp/logs:/var/opt/simplex:z \
    simplexchat/smp-server:latest

 
# 修改配置
nano >> /var/simplex/smp/config/smp-server.ini << EOF

[TRANSPORT]
port: 7223,443

[WEB]
cert: /etc/opt/simplex/cert.crt
key: /etc/opt/simplex/key.key

EOF

# https://simplex.chat/docs/xftp-server.html#configuration

docker run -d \
    --name xftp \
    -e "ADDR=YOUR_DOMAIN" \
    -e "QUOTA=10gb" \
    -e "PASS=YOURPASSWORD" \
    -p 7443:7443 \
    -v /var/simplex/xftp/config:/etc/opt/simplex-xftp:z \
    -v /var/simplex/xftp/logs:/var/opt/simplex-xftp:z \
    -v /var/simplex/xftp/files:/srv/xftp:z \
    simplexchat/xftp-server:latest


# 修改配置
nano >> /var/simplex/xftp/config/file-server.ini << EOF

[TRANSPORT]
port: 7443

EOF

docker restart xftp


```