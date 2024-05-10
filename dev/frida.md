# frida

跨平台，动态注入、hook工具

# install

```bash

# https://github.com/frida/frida

# python 
sudo pip3 install frida-tools

# debian
sudo apt install frida -y

# ios frida server
# Cydia 添加源 https://build.frida.re 搜索 Frida 并安装
# ssh 到 ios 监听端口启动
/usr/sbin/frida-server -l 0.0.0.0:6666

```

# command

```bash
# 脚本
# https://github.com/interference-security/frida-scripts

# 注入文件
frida -U -n NAME--no-pause -l FILE

```