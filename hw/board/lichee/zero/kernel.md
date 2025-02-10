# kernel

```bash
git clone -b zero-5.2.y https://github.com/Lichee-Pi/linux.git

make ARCH=arm licheepi_zero_defconfig
make ARCH=arm menuconfig

General setup
        > Kernel compression mode (XZ)

Device Drivers > Memory Technology Device (MTD) support
                                        > [*] Command line partition table parsing
                                        > [*] Caching block device access to MTD devices
                                        > [*] SPI-NOR device support
                                                > [ ] Use small 4096 B erase sectors  #选中会出错

#  注意这儿是*号状态
File systems > Miscellaneous filesystems > [*] Journalling Flash File System v2 (JFFS2) support
                                                > (0) JFFS2 debugging verbosity (0 = quiet, 2 = noisy)
                                                > [*] JFFS2 write-buffering support

# 修改设备树 加到 usb_otg 后面
nano arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts

&spi0 { 
        status ="okay";
        spi-nor@0 { 
                compatible = "jedec,spi-nor";
                reg = <0x0>;
                spi-max-frequency = <50000000>;
                #address-cells = <1>;
                #size-cells = <1>;
        };
};

# nano ./drivers/mtd/devices/m25p80.c

# spi_nor_ids 中添加 类型ID
nano ./drivers/mtd/spi-nor/spi-nor.c
{ "xt25f128f", INFO(0x0b4018, 0, 64 * 1024, 256,  SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },

# 查找 spi_nor_ids 在哪个文件
grep -r "spi_nor_ids" ./

make clean
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j16
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- dtbs

# multiple definition of `yylloc'
sed -i "s/YYLTYPE yylloc;/extern YYLTYPE yylloc;/g" ./scripts/dtc/dtc-lexer.lex.c

# zImage
ls -lah ./arch/arm/boot/

cp ./arch/arm/boot/zImage /project/dist/

# dtb
ls -lah ./arch/arm/boot/dts/ | grep "zero"

cp ./arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dtb /project/dist/

```