# u-boot

```bash

git clone -b v3s-spi-experimental https://github.com/Lichee-Pi/u-boot.git

cd u-boot
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LicheePi_Zero_defconfig

make ARCH=arm menuconfig

Device Drivers > SPI Flash Support
                                > [*] Enable Driver Model for SPI flash
                                > [*] Legacy SPI Flash Interface support
                                > [*] Winbond SPI flash support
                                > [*] Use small 4096 B erase sectors
                                > [*] Support for SPI Flash on Allwinner SoCs in SPL
# 16MB以上 选中 SPI flash Bank/Extended address register support


# xt25f128f flash 支持
# 上面开启的是 Winbond 支持 在 CONFIG_SPI_FLASH_WINBOND 节点加入 0x0b4018 没添加前会报id未识别错误
nano drivers/mtd/spi/spi_flash_ids.c
{"xt25f128f",      INFO(0x0b4018, 0x0,  64 * 1024,   256, RD_FULL | WR_QPP | SECT_4K) },

nano arch/arm/dts/sun8i-v3s-licheepi-zero.dts

&spi0 {
        status ="okay";
        flash@0 {
               compatible = "windbond,xt25f128b", "jedec,spi-nor";
                reg = <0x0>;
                spi-max-frequency = <50000000>;
                #address-cells = <1>;
                #size-cells = <1>;
        };
};


# 加到 #include <configs/sunxi-common.h> 前面
# /dev/mtdblock3 31:03 都可以
nano ./include/configs/sun8i.h

#define CONFIG_BOOTCOMMAND "setenv machid 1029; sf probe 0; " \
        "sf read 0x41d00000 0x100000 0x9000; " \
        "sf read 0x41000000 0x110000 0x260000; " \
        "bootm 0x41000000"

#define CONFIG_BOOTARGS "console=ttyS0,115200 root=31:03 rw rootfstype=jffs2 earlyprintk panic=5 rootwait " \
        "mtdparts=spi0.0:1M(uboot)ro,64k(sys_config)ro,3M(kernel)ro,10M(rootfs),512k(config),-(config2)"

time make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- 2>&1 | tee build.log
cp u-boot-sunxi-with-spl.bin /project/dist/uboot.bin

```
