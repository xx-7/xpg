# FAQ

## disagrees about version of symbol module_layout

```bash

# https://blog.csdn.net/Longyu_wlz/article/details/109546013

# 原因是内核编译过程有crc校验，换环境换机器都要重新编译
# 会生成 类似 8723bs.mod.c 里面有 	{ 0x5be74996, "module_layout" }的信息
# 两种解决方式

# 可以看下 vermagic 能不能对上
modinfo 8723bs.ko

modprobe --dump-modversions 8723bs.ko | grep module_layout


# 1.手动修改，单独编译驱动

cd .tmp_versions/
rename 's/\.mod$/.bak/' *.mod
cd ../
mv ./vmlinux vmlinux-bak
sed -i '/module_layout/ s/0x[0-9a-f][0-9a-f]*/0x5be74996/' Module.symvers

cd drivers/net/wireless/rtl8723bs
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j16 -C /zfs/bsp-zero/linux-3.4 INSTALL_MOD_PATH=out M=$PWD modules

# 2.手动修改.ko文件

arm-linux-gnueabihf-objcopy --dump-section __version=versions ./8723bs.ko
hexedit versions
arm-linux-gnueabihf-objcopy --update-section __versions=versions ./8723bs.ko


```
