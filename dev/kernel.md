
# Log

```c
# 级别
#    0  pr_emerg / KERN_EMERG 
#    1  pr_alert / KERN_ALERT
#    2  pr_crit / KERN_CRIT
#    3  pr_err / KERN_ERR
#    4  pr_warning / pr_warn/ KERN_WARNING
#    5  pr_notice / KERN_NOTICE
#    6  pr_info / KERN_INFO
#    7  pr_debug / KERN_DEBUG


#define MINIMUM_CONSOLE_LOGLEVEL 1 /*可以使用的最小日志级别*/
#define DEFAULT_CONSOLE_LOGLEVEL 7 /*默认的控制台级别*/
#define DEFAULT_MESSAGE_LOGLEVEL 4 /* 默认的日志级别 */

int console_printk[4] = {
    DEFAULT_CONSOLE_LOGLEVEL,/*控制台日志级别：优先级高于该值的消息将被打印至控制台*/
    DEFAULT_MESSAGE_LOGLEVEL,/*缺省的消息日志级别：将用该优先级来打印没有优先级的消息*/
    MINIMUM_CONSOLE_LOGLEVEL,/*最低的控制台日志级别：控制台日志级别可被设置的最小值（最高优先级）*/
    DEFAULT_CONSOLE_LOGLEVEL,/*缺省的控制台日志级别：控制台日志级别的缺省值*/
};

#define console_loglevel (console_printk[0])             // 当前窗口级别 手动: Echo 7 > /proc/sys/kernel/printk
#define default_message_loglevel (console_printk[1])     // printk 未指定级别时级别
#define minimum_console_loglevel (console_printk[2])     // 后台记录最小级别
#define default_console_loglevel (console_printk[3])     // 内核启动时会默认为这个

// 查看级别 输出的上面4个loglevel
// cat /proc/sys/kernel/printk


// dmesg 查看后台日志
// -c 查看后清除
// -s 缓存区大小
// -n 级别

```

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
