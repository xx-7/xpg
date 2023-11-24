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

# busybox 

```bash
# chroot busybox 更改密码后 记得vi /etc/shadow 把密码过期改了，在密码后面一个: 跟下面用户一样改成10933

busybox od -t x -Ax -N 16   file


```