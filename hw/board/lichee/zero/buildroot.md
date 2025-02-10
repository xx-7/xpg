# buildroot

```bash

wget https://buildroot.org/downloads/buildroot-2023.02.9.tar.xz
tar xvf buildroot-2023.02.9.tar.xz
cd buildroot-2023.02.9

# 查找 arm-linux-gnueabihf-gcc 位置
which arm-linux-gnueabihf-gcc
/opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc

# 看 toolchain linux 版本 264707 十六进制 40A03 版本就是 4.10.3
cat /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/linux/version.h

make clean
make menuconfig

Target Option >
                > Target Architecture (ARM (little endian))
                > Target Architecture Variant (cortex-A7)
                > Target ABI (EABIhf)
                > Floating point strategy (VFPv4-D16)
                > ARM instruction set (ARM)
                > Target Binary Format (ELF)

Toolchain >
                > Toolchain type (External toolchain)
                > Toolchain (Custom toolchain)
                > Toolchain origin (Pre-installed toolchain)  
                        > (/opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/) Toolchain path
                        > ($(ARCH)-linux-gnueabihf) Toolchain prefix
                > External toolchain gcc version (7.x)
                > External toolchain kernel headers series (4.10.x)  # 上面看toolchain version.h获得
                > External toolchain C library (glibc)

Build Options >
                > ($(CONFIG_DIR)/zero_defconfig) Location to save buildroot config
                > [*] strip target binaries

make

ls -lah ./output/images
cp ./output/images/rootfs.tar /project/dist/rootfs.tar

cp ./output/images/rootfs.jffs2 /project/dist/0.rootfs.jffs2

```