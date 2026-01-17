# 三方

```bash


wget http://releases.linaro.org/components/toolchain/binaries/7.2-2017.11/arm-linux-gnueabi/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabi.tar.xz
wget http://releases.linaro.org/components/toolchain/binaries/7.2-2017.11/arm-linux-gnueabihf/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabihf.tar.xz
tar -vxJf gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabi.tar.xz
cp -r ./gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabi /opt/

export PATH=$PATH:/opt/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabi/bin


make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- uImage -j16

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -j16 INSTALL_MOD_PATH=out modules

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -j16 INSTALL_MOD_PATH=out modules_install

# 出错无法找到 linux/compiler-gcc7.h
cp include/linux/compiler-gcc4.h include/linux/compiler-gcc7.h


# -s 代表页大小，普通spi nor flash的页大小是256字节，即0x100
# -e 表示擦除的块大小，普通spi nor flash的块大小是64K字节，即0x10000
# -p 表示分区大小，在生成时会擦除分区大小的flash初始化。
# 这里必须和uboot里指定的分区大小一致，否则会出现脏页。
mkfs.jffs2 -s 0x100 -e 0x10000 -p 0xAF0000 -d root -o jffs2.img


```

# 官方 bsp 包

```bash


unar buildroot/dl/gcc-linaro.tar.bz2 -o /project/linaro

export PATH=$PATH:/opt/gcc-linaro/bin

rm /opt/gcc-linaro/bin/arm-linux-gnueabi-ar
ln -s /opt/gcc-linaro/arm-linux-gnueabi/bin/ar /opt/gcc-linaro/bin/arm-linux-gnueabi-ar

rm /opt/gcc-linaro/bin/arm-linux-gnueabi-objdump
ln -s /opt/gcc-linaro/arm-linux-gnueabi/bin/objdump /opt/gcc-linaro/bin/arm-linux-gnueabi-objdump

rm /opt/gcc-linaro/bin/arm-linux-gnueabi-objcopy
ln -s /opt/gcc-linaro/arm-linux-gnueabi/bin/objcopy /opt/gcc-linaro/bin/arm-linux-gnueabi-objcopy

rm /opt/gcc-linaro/bin/arm-linux-gnueabi-strip
ln -s /opt/gcc-linaro/arm-linux-gnueabi/bin/strip /opt/gcc-linaro/bin/arm-linux-gnueabi-strip

rm /opt/gcc-linaro/bin/arm-linux-gnueabi-ld
ln -s /opt/gcc-linaro/arm-linux-gnueabi/bin/ld /opt/gcc-linaro/bin/arm-linux-gnueabi-ld

rm /opt/gcc-linaro/bin/arm-linux-gnueabi-nm
ln -s /opt/gcc-linaro/arm-linux-gnueabi/bin/nm /opt/gcc-linaro/bin/arm-linux-gnueabi-nm


apt install u-boot-tools

cd /project/lichee/linux-3.4
./scripts/build_tiger-cdr.sh


# 解压编译 fex 文件
apt install sunxi-tools

fex2bin sys_config.fex script.bin
bin2fex script.bin sys_config.fex


# 修改 ion预留内存
Device Drivers -> Graphics support -> Ion Memory Manager -> memory size(in MB) -> 4m,4m

# 关闭android支持
Device Drivers -> Staging Drivers -> 取消  Android Drivers


# 关闭DISP
Device Drivers -> Graphics support -> Support for frame buffer devices -> Video support for sunxi -> 取消  DISP Driver Support(sunxi-disp2)

# 关 ALSA
Device Drivers -> 取消 Sound card Support
#  Device Drivers -> 取消 Common Clock Framework 不关编译CLK出错  或: 开 Generic sound devices -> Generic loopback driver (PCM)  # 不开编译CLK出错

# Watchdog
Device Drivers -> Watchdog Timer Support -> 取消 SUNXI Watchdog

# 关部分usb 支持
Device Drivers -> USB Support -> 取消 USB Gadget Support
                                取消 SUNXI USB2.0 Dual Role Controller support



```

## csi lcd 端口复用

```bash

# 正常设置为csi pe 端口复用寄存器值
# 配置错会打印日志 request pinctrl handle for device [csi1] failed!

# 详细数据在 v3s 数据手册 230页 基地址: 0x01c20800

devmem 0x01c20890
0x22222222
devmem 0x01c20894
0x22222222
devmem 0x01c20898
0x02277777

# 问题定位到在 linux-3.4/drivers/pinctrl/pinctrl-sun8iw8.c pe21, 22端口配置成csi0 实际在使用中是csi1 要过来重新编译就可以
# pinctrl 是调用 pinctrl-sun8iw8.c 初始化信息, 然后读取sys_config fex.bin 根据名字配置

```
