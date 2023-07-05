
[文档](http://wiki.friendlyelec.com/wiki/index.php/NanoPi_R5C)

## 启动

```bash
# eMMC为U-boot固件时会不会从TF卡启动
#       需要从TF卡启动, 按下Maskrom按键, 上电4秒后松开可从TF卡启动



# 制作全零的img 可以用来全面擦除eMMC
dd if=/dev/zero of=./empty.img bs=8M count=1

```
## build

### ubuntu cross

```bash

git clone git@github.com:friendlyarm/docker-cross-compiler-novnc.git

cd docker-cross-compiler-novnc

docker build --no-cache -t docker-ubuntu-lxde-novnc .

mkdir ./work && chown 1000:1000 ./work 

docker run --rm --privileged --name docker-ubuntu-lxde-novnc -p 6080:80 -p 5900:5900 \
                        -e HTTP_PASSWORD=password -e VNC_PASSWORD=password -e PUID=1000 -e PGID=1000 -e USER=ubuntu -e PASSWORD=ubuntu \
                        -v /dev:/dev -v ~/.gitconfig:/home/ubuntu/.gitconfig:ro -v ./work:/home/ubuntu/work -e RESOLUTION=1920x1080 \
                        docker-ubuntu-lxde-novnc:latest

```
