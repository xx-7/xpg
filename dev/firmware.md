```bash

# 固件分析可以用 binwalk
# https://github.com/ReFirmLabs/binwalk

# 可以解压固件包, 带linux系统的可以直接看到目录文件这些
binwalk -e xx.bin

# 可以用 losetup 加载文件系统 
losetup /dev/loop0 /path/to/data
mount /dev/loop0 /mnt
# 直接加载并mount
mount -o loop /path/to/data /mnt

# 识别文件类型
file $FILENAME

# https://man7.org/linux/man-pages/man1/dmesg.1.html
# 内核日志
dmesg

# linux 固件4大件
# 1. bootloader -> uboot
# 2. dtb 文件
# 3. linux 内核
# 4. rootfs 根文件系统

```

# elf

```bash
# 读elf版本
readelf -A FILE

# 动态依赖
readelf -d FILE

# 导出表
readelf --dyn-syms FILE

# 导入表
objdump -T FILE

```

# u-boot

```bash

#  mkimage - dumpimage - mksunxiboot - mkenvimage 
sudo apt u-boot-tools



# image 文件头 具体还要看版本
# define IH_MAGIC    0x27051956    /* Image Magic Number     */
# define IH_NMLEN    32            /* Image Name Length      */

# typedef struct image_header {
#     uint32_t    ih_magic;         /* Image Header Magic Number */
#     uint32_t    ih_hcrc;          /* Image Header CRC Checksum */
#     uint32_t    ih_time;          /* Image Creation Timestamp  */
#     uint32_t    ih_size;          /* Image Data Size           */
#     uint32_t    ih_load;          /* Data     Load  Address    */
#     uint32_t    ih_ep;            /* Entry Point Address       */
#     uint32_t    ih_dcrc;          /* Image Data CRC Checksum   */
#     uint8_t     ih_os;            /* Operating System          */
#     uint8_t     ih_arch;          /* CPU architecture          */
#     uint8_t     ih_type;          /* Image Type                */
#     uint8_t     ih_comp;          /* Compression Type          */
#     uint8_t     ih_name[IH_NMLEN];    /* Image Name            */
# } image_header_t;

# 跳过64字节 导出 kernel.uImage
dd if=p.uImage of=kernel.uImage bs=1 skip=64

```

# usb接线

```bash
4 -  黑
3 d+ 绿
2 d- 白
1 +  红


```

# busybox 

```bash
# chroot busybox 更改密码后 记得vi /etc/shadow 把密码过期改了，在密码后面一个: 跟下面用户一样改成10933

busybox od -t x -Ax -N 16   file

# 查看支持libc版本
busybox strings /lib/libm.so.6 | grep GLIBC_


```

# squashfs

```bash

# 

sudo apt install squashfs-tools


# https://elinux.org/Squash_FS_Howto
# 打包
mksquashfs ./usr usr.sqsh -b 65536 -comp xz

# mount
sudo mount -t squashfs -o loop ./usr.img /ext/usr

# squashfs 文件系统解包
unsquashfs

# 查看信息
unsquashfs -s ./usr.sqsh

```

# jffs2

```bash

# 挂载
sudo apt install mtd-utils

# total_size 容量 8m
modprobe mtdram total_size=8192 erase_size=128

cat /proc/mtd

modprobe mtdblock

dd if=jffs2.img of=/dev/mtdblock0

mount -t jffs2 /dev/mtdblock0 /ext/1

mkfs.jffs2 -b 
   -r <source_dir>
   -o <output_file>
   -e <blocksize>
   -p <padsize>
   -d <image_dir>

mkfs.jffs2 -lqn -e128 -s2048 -p0x10000000 -r <directory> -o <jffs2 file>

mkfs.jffs2 -lqn -e128 -s2048 -p0x440000 -r ./data -o ./data1.jffs2

# 0x10000 = 64 x 1024  64 block
mkfs.jffs2 -n -e0x10000 -p0x440000 -d ./data -o data1.jffs2

# 验证
sumtool -n -e 0x10000 -p -i ./data1.jffs2 -o ./data2.jffs2

```