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

# squashfs 文件系统解包
unsquashfs


```