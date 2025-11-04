## zfs

### 安装使用

[官方 wiki](https://openzfs.github.io/openzfs-docs/)  
[命令](https://openzfs.github.io/openzfs-docs/man/master/8/index.html)

```bash
# centos
yum install epel-release -y
yum install http://download.zfsonlinux.org/epel/zfs-release.el7_6.noarch.rpm -y
yum makecache
yum install zfs
modprobe zfs
systemctl preset zfs-import-cache zfs-import-scan zfs-mount zfs-share zfs-zed zfs.target

# debian
sudo apt update
sudo apt install linux-headers-amd64
sudo apt install -t stable-backports zfsutils-linux

# 出错 E: The value 'stable-backports' is invalid for APT::Default-Release as such a release is not available in the sources"
codename=$(lsb_release -cs);echo "deb http://deb.debian.org/debian $codename-backports main contrib non-free"|sudo tee -a /etc/apt/sources.list && sudo apt update

zfs list                            #查看zfs列表
zfs set mountpoint=/disk/w d1t      #设置d1t挂载到/disk/w目录,可继承
zfs create -o mountpoint=/test d2t/test
zpool list                          #查看当前存储池列表
zpool status                        #查看当前存储池状态

zpool create d1t mirror sda sdb     #使用 sda、sdb、两块硬盘创建一个名为d1t的Raid1池
# Example: https://openzfs.github.io/openzfs-docs/man/master/8/zpool-create.8.html#Virtual_Devices
zpool create d1t sda1 sdb2          # Raid0
zpool create d1t mirror sda sdb spare sdc # ssd 缓存加速

zpool get all d1t                   #查看存储池d1t的一些信息

# Example: https://openzfs.github.io/openzfs-docs/man/master/8/zpool-add.8.html
zpool add d1t sdc                   #将硬盘sdc添加到池d1t中
zpool add d1t mirror sdc sdd

zpool replace d1t sdb sde           #使用硬盘sde替换d1t池中的sdb
zpool scrub d1t                     #检测池 d1t 是否存在问题
zpool iostat d1t                    #查看池 d1t 的IO使用状况，可以加 -v 来详细到池所拥有的每块磁盘
zpool upgrade d1t                   #更新d1t池
zpool upgrade -a                    #更新全部池

zpool destroy d1t

zpool import                        #重新安装读取硬盘中的配置信息
zpool import NAME -f                #导入修复

# 重建替换坏盘
sudo zpool import
sudo zpool import d8t -f
sudo wipefs -a /dev/sda
sudo zpool replace d8t 5604343330525282977 /dev/sda
```

### 无法加载 zfs 内核

```bash
rm -rf /lib/modules/4.18.9-1.el7.elrepo.x86_64/extra
dkms remove -m zfs -v 0.7.12 --all
dkms remove -m spl -v 0.7.12 --all
dkms add -m spl -v 0.7.12
dkms add -m zfs -v 0.7.12
dkms install -m spl -v 0.7.12
dkms install -m zfs -v 0.7.12
```
