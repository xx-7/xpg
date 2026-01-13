```bash

# 新建
sudo mke2fs -vm0 /dev/ram 10240

# 从文件到 ram
sudo  dd if=rootfs of=/dev/ram bs=1k

# 从 ram 到文件
sudo dd if=/dev/ram of=rootfs bs=1k count=10240

# 挂载
sudo mount -t ext2 /dev/ram /mnt/fs1

# 卸载
sudo umount /mnt/fs1

# 复制文件
sudo cp -af ./rootfs/* /mnt/fs1


sudo unlink /dev/ram


```
