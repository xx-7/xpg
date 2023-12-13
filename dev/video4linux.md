
# ioctl

```bash

# int ioctl(int fd, int cmd, arg

# 2bit  +   14bit  +  8bit +  8bit
# dir   |   size   |  type |   nr

# dir 访问模式 _IOC_NONE, _IOC_READ, _IOC_WRITE, _IOC_READ | _IOC_WRITE，分别指：无数据、读数据、写数据、读写数据
# size 第三个参数 arg的数据类型 及 长度
# type 设备类型 可以为任意 char 型字符，例如‘a’、’b’、’c’ 等, video4linux 一般为 'V' 0x56
# nr 命令编号 https://github.com/torvalds/linux/blob/master/include/uapi/linux/videodev2.h 最后有定义


```