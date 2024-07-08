

# debian

## apt文件被lock

```bash
sudo rm -rf /var/lib/dpkg/lock
sudo rm -rf /var/cache/apt/archives/lock
sudo apt update
sudo dpkg --configure -a
```

## 卡死在/dev/sdaX clean files
## 禁用nomodeset图形

```bash

# 临时禁用
# Grub 启动菜单按 `e` 进入编辑模式 在最后第二行看到 `ro quiet` 改成  `ro quiet nomodeset` F10引导系统

# 永久禁用
sudo nano /etc/default/grub
# 修改 GRUB_CMDLINE_LINUX_DEFAULT="quiet" 为
GRUB_CMDLINE_LINUX_DEFAULT="quiet nomodeset"
sudo update-grub

```

## /sbin/init缺失

```bash
# 1. 安装盘启动
# 2. 高级进入
# 3. mount系统盘 mount /dev/sda5 /mnt
# 4. sudo cp /sbin/init /mnt/sbin/
```

## 修复坏道

```bash
# 会出现{DRDY ERR} {UNC} 这样的关键字

fsck -y /dev/sda2 
```

## 其它

```bash

# 修复依赖
sudo apt install -f

```