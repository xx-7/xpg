# 查看宏

```bash

gcc -E -dM - </dev/null

i686-w64-mingw32-gcc  -E -dM - </dev/null


# 切换默认版本
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 100 --slave /usr/bin/g++ g++ /usr/bin/g++-11

# Debian 13 装老版本gcc11

sudo nano /etc/apt/sources.list


# bookworm
deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware


sudo nano /etc/apt/preferences
Package: *
Pin: release a=bookworm
Pin-Priority: -1000


sudo apt update && sudo apt-get -t bookworm install gcc-11




```
