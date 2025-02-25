# 安装

```bash

sudo apt install openocd

```
## 读固件

```bash

openocd -f /usr/share/openocd/scripts/interface/stlink.cfg  -f /usr/share/openocd/scripts/board/stm32f0discovery.cfg

telnet localhost 4444
halt

#  读固件 STM32F030F4P6TR
dump_image flash.bin 0x8000000 0x10000

```