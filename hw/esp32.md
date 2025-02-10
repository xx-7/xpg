# 烧录

```bash

# 安装
pip install esptool

# 查看信息
esptool --port <端口> chip_id
esptool --port COM3 chip_id

# 查看闪存大小
esptool --port <端口> flash_id
esptool --port COM3 flash_id

# 读取 flash
esptool --chip esp32c3 --port <端口> read_flash <起始地址> <结束地址或大小> <完整备份文件路径>
esptool --chip esp32c3 --port COM3 read_flash 0x0 0x400000 esp32c3_firmware_backup.bin

# 写 flash
esptool --chip esp32c3 --port <端口> write_flash <起始地址> <固件文件> [<分区文件>]
esptool --chip esp32c3 --port COM3 write_flash 0x0 esp32c3_firmware_backup.bin

# 擦除 falsh
esptool --port <端口> erase_flash
esptool --port COM3 erase_flash


```