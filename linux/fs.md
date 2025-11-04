```bash
# 批量改变权限
chmod -R 777 /home/linux
chown -R USR:GROUP /home/linux

# 解压乱码
pacman -S unarchiver
unar -e GBK test.zip

# -c 取消任务 -h 关机 -r重启 now马上
shutdown -r now

```

# 磁盘

```bash
# 查看分区
sudo fdisk -l

# 查看使用情况
df -h

# 查看盘UUID
blkid

# 查看盘UUID
ls -l /dev/disk/by-uuid/

# 查看目录占用大小
du -h  ./

# 查看目录占用大小设置遍历深度
du -h --max-depth=1 ./

# 给硬盘分区 进入m打印帮助 dos 分区表格式 ext4用主分区 w 保存退出
sudo fdisk /dev/sdb
# 格式化
sudo mkfs -t ext4 /dev/sdb1
# 临时挂载
sudo mount /dev/sdb1 /optd

# 自动挂盘
sudo nano /etc/fstab
UUID=b141d23c-0f49-48a0-aaaa-80f25b30bd8f /optd ext4 defaults 0 2
```

# nfs

```bash

sudo apt install nfs-utils

nano /etc/exports

/zfs/share 10.8.8.0/24(rw,sync,insecure)

sudo systemctl disable nfs-server
sudo systemctl restart nfs-server

sudo rpcinfo -p

```

# 坏道

```bash

# 扫描保存到 badsectors.txt
sudo badblocks -b 4096 -s -v -o badsectors.txt /dev/sda

# 针对 for ext2/ext3/ext4
sudo e2fsck -l badsectors.txt /dev/sda

# 针对其它文件系统
sudo fsck -l badsectors.txt /dev/sda

sudo apt-get install smartmontools

# 硬盘信息 使用时间, 通电次数
# -a/--all -x/-xall -H/--health
sudo smartctl -H --xall /dev/sda

```
