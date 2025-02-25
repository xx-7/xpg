```bash

sudo apt install stlink-tools

# 图形
sudo apt install stlink-gui

# st-info

st-info --version	# 打印版本信息
st-info --flash	    # 显示设备中可用的 flash 数量
st-info --sram	    # 显示设备中可用的 sram 内存量
st-info --descr	    # 显示设备的文字描述
st-info --pagesize	# 显示设备的页面大小
st-info --chipid	# 显示设备的芯片ID
st-info --serial	# 显示设备的序列号
st-info --probe	    # 显示连接的编程器和设备的汇总信息

# st-flash

# 烧录 bin 文件 默认 --format binary
st-flash write file.bin 0x08000000

# 烧录 hex 文件
st-flash --format ihex write file.hex

# 从 FLASH 读取 0x1000 个字节
st-flash read firmware.bin 0x08000000 0x1000

# 擦除 FLASH
st-flash erase

```