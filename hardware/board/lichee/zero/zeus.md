

```bash
/dev/ram0 on / type ext2 (rw,relatime,errors=continue)
devtmpfs on /dev type devtmpfs (rw,relatime,size=28020k,nr_inodes=7005,mode=755)
proc on /proc type proc (rw,relatime)
devpts on /dev/pts type devpts (rw,relatime,gid=5,mode=620,ptmxmode=666)
tmpfs on /dev/shm type tmpfs (rw,relatime,mode=777)
tmpfs on /tmp type tmpfs (rw,relatime)
tmpfs on /run type tmpfs (rw,nosuid,nodev,relatime,mode=755)
sysfs on /sys type sysfs (rw,relatime)
none on /root/PWM type debugfs (rw,relatime)
/dev/mtdblock3 on /mnt type ext2 (rw,relatime,errors=continue)

disk -l
Disk /dev/mtdblock0: 1 MB, 1048576 bytes, 2048 sectors
0 cylinders, 255 heads, 63 sectors/track
Units: cylinders of 16065 * 512 = 8225280 bytes

Disk /dev/mtdblock0 doesn't contain a valid partition table
Disk /dev/mtdblock1: 0 MB, 65536 bytes, 128 sectors
0 cylinders, 255 heads, 63 sectors/track
Units: cylinders of 16065 * 512 = 8225280 bytes

Disk /dev/mtdblock1 doesn't contain a valid partition table
Disk /dev/mtdblock2: 3 MB, 3145728 bytes, 6144 sectors
0 cylinders, 255 heads, 63 sectors/track
Units: cylinders of 16065 * 512 = 8225280 bytes

Disk /dev/mtdblock2 doesn't contain a valid partition table
Disk /dev/mtdblock3: 10 MB, 10485760 bytes, 20480 sectors
1 cylinders, 255 heads, 63 sectors/track
Units: cylinders of 16065 * 512 = 8225280 bytes

Disk /dev/mtdblock3 doesn't contain a valid partition table
Disk /dev/mtdblock4: 0 MB, 524288 bytes, 1024 sectors
0 cylinders, 255 heads, 63 sectors/track
Units: cylinders of 16065 * 512 = 8225280 bytes

Disk /dev/mtdblock4 doesn't contain a valid partition table
Disk /dev/mtdblock5: 0 MB, 524288 bytes, 1024 sectors
0 cylinders, 255 heads, 63 sectors/track
Units: cylinders of 16065 * 512 = 8225280 bytes


Linux Lichee 3.4.39 #790 PREEMPT Thu Apr 13 11:57:04 CST 2023 armv7l GNU/Linux

```

# u-boot

```bash

# 内核没有解析到这参数
bootargs=console=ttyS0,115200 panic=5 rootwait earlyprintk mtdparts=spi32766.0:1M(uboot)ro,64k(sys_config)ro,3M(kernel)ro,-(rootfs) root=31:03 rw rootfstype=jffs2

bootcmd=setenv machid 1029;sf probe 0;sf read 0x41d00000 0x100000 0x9000; sf read 0x41000000 0x110000 0x260000; bootm 0x41000000

dfu_alt_info_ram=kernel ram 0x41000000 0x800000;fdt ram 0x41800000 0x100000;ramdisk ram 0x41B00000 0x1000000

cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00100000 00010000 "u-boot"
mtd1: 00010000 00010000 "sys_config"
mtd2: 00300000 00010000 "kernel"
mtd3: 00a00000 00010000 "rootfs"
mtd4: 00080000 00010000 "config"
mtd5: 00080000 00010000 "config2"

cat /proc/partitions
major minor  #blocks  name
31        0       1024 mtdblock0
31        1         64 mtdblock1
31        2       3072 mtdblock2
31        3      10240 mtdblock3
31        4        512 mtdblock4
31        5        512 mtdblock5

# 逆向 内核 partition_register 得到
static struct mtd_partition nor_part[] = {
       [0] = {
        .name   = "uboot",
        .size   = 0x100000,
        .offset = 0,
       },
       [1] = {
        .name   = "sys_config",        
        .size   = 0x10000,
        .offset = 0x100000,
       },
       [2] = {
        .name   = "kernel",        
        .size   = 0x300000,
        .offset = 0x110000,
       },
       [3] = {
        .name   = "rootfs",        
        .size   = 0xA00000,
        .offset = 0x410000,
       },
       [4] = {
        .name   = "config",        
        .size   = 0x80000,
        .offset = 0xE10000,
       },
       [5] = {
        .name   = "config2",        
        .size   = 0x80000,
        .offset = 0xE90000,
       }
};



console=ttyO0,115200n8 root=/dev/ram0 rw ramdisk_size=65536 initrd=${rdaddr},64M rootfstype=ext2 mtdoops.mtddev=3 earlyprintk mtdparts=physmap-flash.0:512k(u-boot),128k(u-boot-env1),128k(u-boot-env2),5m(kernel),128k(fdt),-(rootfs)
```