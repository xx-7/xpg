
```bash

# 彻底删除文件 (原理就是生成一个大文件覆盖剩余可用空间将磁盘写满,再把这个文件删除)

# *********** debian ***********
# 要根据挂载目录依次操作

# 查看使用情况
df -h

# BleachBit 在菜单中选择  Wipe Free Space
# 如果提示要安装psutil
sudo apt install python3-psutil

# secure-delete
sudo apt-get install secure-delete
sfill -fllvz ./test

# *********** win ***********
# 要根据磁盘依次操作

# Super.Eraser
# https://patoghu.com/gonagon/usefull_tool/15799-doyourdata-super-eraser.html
# 安装后可以选直译替换次数自动完成

# SDelete
# https://learn.microsoft.com/en-us/sysinternals/downloads/sdelete
sdelete C:

# 查看参数
sdelete --help

# *********** kvm ***********

# 先用SDelete把空间填0
sdelete -z C:

# 转换成新img
qemu-img convert -O qcow2 old.img new.img

```