
# fel模式

```bash

# 全志v3s 进fel flash为空/刷了fel-sdboot.sunxi卡/spi_miSO拉低
# lichee pi zero 启动时短接 flash 1,4针可以进 fel模式

sudo apt install libusb-1.0-0-dev libz-dev libfdt-dev

git clone git@github.com:linux-sunxi/sunxi-tools.git
cd sunxi-tools

# 默认 make tools
make

make install-tools

# 连接信息
sudo sunxi-fel version
# flash信息
sudo sunxi-fel spiflash-info

# 刷写到0x0处
sudo sunxi-fel -p spiflash-write 0 998.bin

# zero 刷写各个分区
sudo sunxi-fel -p spiflash-write 0x0 u-boot-sunxi-with-spl.bin
sudo sunxi-fel -p spiflash-write 0x100000 sun8i-v3s-licheepi-zero-dock.dtb
sudo sunxi-fel -p spiflash-write 0x110000 zImage
sudo sunxi-fel -p spiflash-write 0x510000 jffs2.img

# 读
sudo sunxi-fel -p spiflash-read 0 0x510000 999.bin

# 生成全0文件
dd if=/dev/zero of=all.bin bs=1M count=16



```