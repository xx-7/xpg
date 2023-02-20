## 常见问题

### terminal operation not permitted

System Preferences -> Security & Privacy -> Privacy -> Full Disk Access
Click the lock to make changes -> add Terminal.app
默认Terminal没有Documents权限

### MonkeyDev ld: file not found: /usr/lib/libstdc++.dylib

https://github.com/devdawei/libstdc-

### 无法进入Recovery模式

```bash
# 尝试快捷键
# Command + R
# Option + Command + R
# Shift + Option + Command + R
# Option + Command + R + P

# 如无法进入, 要用启动盘启动
# virtualbox 挂载安装iso, 按F2、Del 选择 Boot Manger 进入EFI Internal Shell操作

```

### EFI Internal Shell

引导启动出现 Press ESC in 1 seconds to skip startup .nsh or any other key to continue
说明进入了EFI Internal Shell

```bash

# 先看 CDROM 在哪个 FS 类似 PciRoot(0x0)/Pci(0x1F,0x2)/Sata(0x1,0xFFFF,0x0)/CDROM(0x0)
fs0:

# 直接运行efi文件 可用 CD LS命令
System\Library\CoreServices\boot.efi

```

### 关闭rootless/System Integrity Protection

```bash
# 设置状态要Recovery模式才能进行 Utilities -> Terminal
# 查看状态
csrutil status
# 开启
csrutil enable
# 关闭
csrutil disable
```

### virtualbox guest additions不起作用

System Preferences -> Security & Privacy -> General -> Details 勾选 Oracle America,Inc

## 常用软件

* The Unarchiver
* Geekbench 4
* MultiBeast
* UniBeast

## brew

brew.sh/index

## VNC

```bash
sudo nano /System/Library/LaunchDaemons/com.apple.screensharing.plist  # vnc-server -> port 
sudo launchctl unload /System/Library/LaunchDaemons/com.apple.screensharing.plist
sudo launchctl load /System/Library/LaunchDaemons/com.apple.screensharing.plist
```
## XCode

```bash
# 先到 https://xcodereleases.com/ 查询对应系统能装的版本
# 再到 https://developer.apple.com/download/all?q=xcode%2013.2.1 下载

# 编译输出目录: Xcode -> Preferences -> Locations
```

## Mysql

```bash
# https://dev.mysql.com/downloads/mysql/
# unpack to /opt/db/mysql-5.7.23-macos10.13-x86_64
vi ~/.bash_profile
PATH=$PATH:/opt/db/mysql-5.7.23-macos10.13-x86_64/bin
source ~/.bash_profile
mysqld --initialize-insecure --basedir=/opt/db/mysql-5.7.23-macos10.13-x86_64 --datadir=/opt/db/mysqldata

mysqld_safe --datadir=/opt/db/mysqldata

mysql -uroot
SET PASSWORD = PASSWORD('mima');
flush privileges;
```

## Redis

```bash
wget http://download.redis.io/releases/redis-4.0.11.tar.gz
tar xzf redis-4.0.11.tar.gz
cd redis-4.0.11
make

mkdir bin
cp src/redis-server bin/redis-server 
cp src/redis-cli bin/redis-cli

vi redis.conf

vi ~/.bash_profile
PATH=$PATH:/opt/db/redis-4.0.11/bin
source ~/.bash_profile

redis-server /opt/db/redis-4.0.11/redis.conf
redis-cli -p 6380
```

## Ext4

```bash
# 安装 ExtFS for Mac by Paragon 最近这个软件免费了
mount -t ufsd_ExtFs /dev/disk4s3 /t
```


## Nfs

```bash
sudo vi /etc/exports
/Users/fex/test -rw -network 10.8.6.0 -mask 255.255.255.0

sudo nfsd enable
sudo nfsd update
sudo nfsd restart
```

## Mount

```bash
diskutil list
diskuilt info disk1s1  # get UUID
sudo vi /etc/fstab
UUID=C0A8F81F-88E6-4078-B699-C9040A493F97 /opt apfs auto   
# apfs or hfs
```

## SSH KEY

```bash
ssh-keygen -t rsa -C "text@test.com"

vi ~/.ssh/config

# github
Host github.com
HostName github.com
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_rsa_github

# test
host test.a.com test.b.com
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_rsa_pri
```

## BCM94352z

AirportBrcmFixup.kext to /EFI/CLOVER/kexts/Other [链接](https://github.com/acidanthera/AirportBrcmFixup/releases)  
FakePCIID_Broadcom_WiFi.kext,FakePCIID.kext to /EFI/CLOVER/kexts/Other [链接](https://bitbucket.org/RehabMan/os-x-fake-pci-id/downloads)  
BrcmFirmwareData.kext BrcmPatchRAM2.kext to /Library/Extensions [链接](https://bitbucket.org/RehabMan/os-x-brcmpatchram/downloads)  

## 重建缓存

```bash
sudo chmod -Rf 755 /S*/L*/E*
sudo chown -Rf 0:0 /S*/L*/E*
sudo chmod -Rf 755 /L*/E*
sudo chown -Rf 0:0 /L*/E*
sudo rm -Rf /S*/L*/PrelinkedKernels/*
sudo rm -Rf /S*/L*/Caches/com.apple.kext.caches/*
sudo touch -f /S*/L*/E*
sudo touch -f /L*/E*
sudo kextcache -Boot -U
```