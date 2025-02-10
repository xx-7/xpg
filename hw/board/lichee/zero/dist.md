

# pack

```bash

cd /project/dist/

rm -rf ./rootfs
mkdir ./rootfs 
tar -xvf ./rootfs.tar -C ./rootfs
mkfs.jffs2 -n -e 0x10000 -s 0x100 -p0xA00000 -d ./rootfs -o ./rootfs.jffs2

rm -rf flashimg.bin
dd if=/dev/zero of=flashimg.bin bs=1M count=16
dd if=u-boot-sunxi-with-spl.bin of=flashimg.bin bs=1K conv=notrunc
dd if=sun8i-v3s-licheepi-zero.dtb of=flashimg.bin bs=1K seek=1024  conv=notrunc
dd if=zImage of=flashimg.bin bs=1K seek=1088  conv=notrunc
dd if=rootfs.jffs2 of=flashimg.bin  bs=1K seek=5184  conv=notrunc

```

# 烧写

```bash

# flash为空会自动进入 fel 烧写模式
# 不为空里要先将 SPI-MISO接GND 进入fel 模式后断开 断开才能显示或者烧写
sudo sunxi-fel version

# 显示flash信息 SPI-MISO断接GND不显示信息
sudo sunxi-fel spiflash-info

# 烧写
sudo sunxi-fel -p spiflash-write 0 flashimg.bin

sudo sunxi-fel -p spiflash-write 0 ./u-boot-sunxi-with-spl.bin 
sudo sunxi-fel -p spiflash-write 0x0100000 ./sun8i-v3s-licheepi-zero.dtb
sudo sunxi-fel -p spiflash-write 0x0110000 ./zImage 
sudo sunxi-fel -p spiflash-write 0x0510000 ./rootfs.jffs2


```