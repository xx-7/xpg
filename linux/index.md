# bash
```bash
# 批量改变权限
chmod -R 777 /home/linux

# 解压乱码
pacman -S unarchiver
unar -e GBK test.zip

# 查看分区
sudo fdisk -l

# 查看使用情况
df -h

# 查看目录占用大小
du -h  ./

# 查看盘UUID
ls -l /dev/disk/by-uuid/

# -c 取消任务 -h 关机 -r重启 now马上
shutdown -r now

```


# proc
```bash

cat /proc/[pid]/status
```

| 字段   | 居中对齐                                                 |
| :----- | :------------------------------------------------------- |
| VmPeak | 进程所使用的虚拟内存的峰值                               |
| VmSize | 进程当前使用的虚拟内存的大小                             |
| VmLck  | 已经锁住的物理内存的大小（锁住的物理内存不能交换到硬盘） |
| VmHWM  | 进程所使用的物理内存的峰值                               |
| VmRSS  | 进程当前使用的物理内存的大小                             |
| VmData | 进程占用的数据段大小                                     |
| VmStk  | 进程占用的栈大小                                         |
| VmExe  | 进程占用的代码段大小（不包括库）                         |
| VmLib  | 进程所加载的动态库所占用的内存大小（可能与其它进程共享） |
| VmPTE  | 进程占用的页表大小（交换表项数量）                       |
| VmSwap | 进程所使用的交换区的大小                                 |

# 终端样式
```bash
PATH=$PATH:/opt/db/redis-4.0.11/bin
PATH=$PATH:/optd/opt/gradle-5.5/bin

PS1='\033[01;33m\]\u@\h \033[01;34m\]\w\033[01;36m\]\$\033[01;00m\] '
```

`source ~/.bash_profile`

## 转义
> \h--主机名
> \u--用户名
> \w--当前工作目录的绝对路径 如：/usr/bin
> \W--当前工作目录的基址名 如上例中的bin
> \t--当前的系统时间：HH:MM:SS（24小时制）
> \@--当前的系统时间，12小时制， 如：07:14 PM
> \d--如“Wed May 28”格式的日期
> \n--换行符
> \>$?--上以命令执行后的返回值，成功执行返回0，否则返回一个非零的数
> \!--该条命令在历史命令中的编号
> \#--该条命令在这个shell中的编号

## 颜色
• 黑色 0;30
• 红色 0;31
• 绿色 0;32
• 棕色 0;33
• 蓝色 0;34
• 紫色 0;35
• 蓝绿色 0;36
• 白色 0;37

## 磁盘

```bash
# 查看分区
sudo fdisk -l

# 查看使用情况
df -h

# 查看盘UUID
blkid

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

## ssh

```bash
nano ~/.ssh/config
Host www.domain.com
port 77
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_rsa_local
```

## trojan

```bash
wget https://github.com/trojan-gfw/trojan/releases/download/v1.16.0/trojan-1.16.0-linux-amd64.tar.xz

tar -zxvf trojan-1.16.0-linux-amd64.tar.xz

cd ./trojan

cp ./examples/client.json-example config.json

# log_level 0: ALL; 1: INFO; 2: WARN; 3: ERROR; 4: FATAL; 5: OFF

./trojan

```


## 010Editor

```bash
# https://www.sweetscape.com/download/010editor/
```

## journalctl

```bash
sudo journalctl --vacuum-time=1s
sudo journalctl
sudo journalctl -p err
sudo rm -rf /var/log/journal
```

## Single User

```bash
# grub 启动菜单 按 e 编辑 kernel参数加上 s 然后 ctrl + x 运行
```

## systemctl

```bash
# 列出正在运行的 Unit
systemctl list-units

# 列出所有Unit，包括没有找到配置文件的或者启动失败的
systemctl list-units --all

# 列出所有没有运行的 Unit
systemctl list-units --all --state=inactive

# 列出所有加载失败的 Unit
systemctl list-units --failed

# 列出所有正在运行的、类型为 service 的 Unit
systemctl list-units --type=service

# 显示系统状态
systemctl status

# 立即启动一个服务
sudo systemctl start apache.service

# 立即停止一个服务
sudo systemctl stop apache.service

# 重启一个服务
sudo systemctl restart apache.service

# 杀死一个服务的所有子进程
sudo systemctl kill apache.service

# 重新加载一个服务的配置文件
sudo systemctl reload apache.service

# 重载所有修改过的配置文件
sudo systemctl daemon-reload

# 显示某个 Unit 的所有底层参数
sudo systemctl show httpd.service
```