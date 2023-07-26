# 路由设置

```bash
# rb4011 ros
# 先给sfp接口设置IP, Addr: 192.168.1.99/24 Network: 192.168.1.0
# 注意这儿IP网段要跟 sfp 模块对上,很多固件默认IP:192.168.1.10 默认网关:192.168.2.0
# 然后给sfp设置传送速率,有时要手动有时要自动,有时候要点下 Cable Test 让其 link ok 就好
# 注意要***插上光纤***
# sfp link ok后,配置路由访问sfp模块改认证信息GPONSN\LOID\LOID密码, 状态5就是注册上. 开vlan透传
# 新建vlan CMCC本地是2001上网, 可以设置iptv这些
# 把PPPoe 拔号的接口改成vlan

# ros7 才能设置2.5G
# 设置自动2.5G
interface ethernet set sfp-sfpplus1 auto-negotiation=yes advertise=2500M-full
# 设置手动2.5G
interface ethernet set sfp-sfpplus1 auto-negotiation=no speed=2.5Gbps full-duplex=yes

```


# SFP模块刷固件

```bash

# 刷完固件可能有ssh\web更新

# 主要是刷linux分区

# TTL
# MA5671A SFP座子的2(TX)、7(RX)、10(GND)和15、16(VCC)
# G-010-S-A SFP座子的3(RX)、6(TX)、10(GND)和15、16(VCC)
# 串口速率 115200
# 启动时按ctrl-c到命令模式


loadb 0x80800000

# 通过串口传文件

sf probe 0

# 清除 740000 linux开始地址 C0000大小
sf erase C0000 740000

# 写入 740000 linux开始地址 C0000大小  80800000内存地址
sf write 80800000 C0000 740000
setenv committed_image 0
saveenv

# TFTP

setenv ipaddr 192.168.1.10
setenv serverip 192.168.1.111
setenv image_name IMAGE_NAME
saveenv

run update_openwrt


# ssh
cat /proc/mtd 

# 备份
dd if=/dev/mtd0 of=/tmp/mtd0.bin

# 刷固件
mtd -e linux write /tmp/FILE linux

```