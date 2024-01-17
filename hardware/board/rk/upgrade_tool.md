# Linux_Upgrade_Tool

```bash
# 查看连接设备
upgrade_tool ld

# 下载loader
upgrade_tool db rkxxloader.bin

# 烧录loader并重启设备
upgrade_tool ul rkxxloader.bin
# 烧录loader不重启设备
upgrade_tool ul rkxxloader.bin -noreset
# 当设备存在多个存储，需要指定loader烧录的目标存储，本例为spinor
upgrade_tool ul rkxxloader.bin SPINOR


# 烧录分区表
upgrade_tool di -p parameter.txt
# 烧录单个分区镜像
upgrade_tool di -k kernel.img
# 烧录多个分区镜像
upgrade_tool di -u uboot.img -b boot.img
# 烧录未定义缩写的分区镜像,需要用分区名来指定，这里以vendor分区为例
upgrade_tool di -vendor vendor.img
# 当使用ab分区时，也需要按未定义的情况处理，这里以boot_a和boot_b为例
upgrade_tool di -boot_a boot.img -boot_b boot.img
# 已定义缩写的分区有
-b:boot
-k:kernel
-r:recovery
-s:system
-u:uboot
-m:misc
-t:trust

# loader切换到maskrom
upgrade_tool rd 3

# 烧录升级固件并重启设备
upgrade_tool uf update.img
# 烧录升级固件不重启设备
upgrade_tool uf update.img -noreset

# 按地址写文件到LBA 0x12000
upgrade_tool wl 0x12000 oem.img
# 按地址读数据保存到文件,例子:从0x12000开始读取0x2000扇区数据到out.img
upgrade_tool rl 0x12000 0x2000 out.img


# 擦除存储的所有数据,请进入maskrom执行,不需要提前下载Boot
upgrade_tool ef rkxxloader.bin
# 按地址进行扇区擦除,只支持emmc存储,例子:从第0扇区开始擦除0x2000个扇区
upgrade_tool el 0 0x2000

# 读取存储信息
upgrade_tool rfi
# 读取芯片id
upgrade_tool rci
# 读取分区表
upgrade_tool pl

# 多设备操作
upgrade_tool ssd

# 多设备选择 对LocationID为100的设备进行loader升级
upgrade_tool -s 100 ul rkxxloader.bin

```