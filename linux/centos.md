```bash
rpm -qa postfix
rpm -e --nodeps postfix
```

```bash
vi /etc/selinux/config 
SELINUX=disabled

vi /etc/sysctl.conf
net.ipv6.conf.all.disable_ipv6=1

echo "ulimit -SHn 102400" >> /etc/rc.local
cat >> /etc/security/limits.conf << EOF
 *           soft   nofile       102400
 *           hard   nofile       102400
 *           soft   nproc        102400
 *           hard   nproc        102400
EOF

chmod +x /etc/rc.d/rc.local

```

## 更新内核
```bash
uname -sr
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
yum --disablerepo="*" --enablerepo="elrepo-kernel" list available
yum --enablerepo=elrepo-kernel install kernel-ml

vi /etc/default/grub # GRUB_DEFAULT=0

grub2-mkconfig -o /boot/grub2/grub.cfg

cat /boot/grub2/grub.cfg |grep menuentry    #查看系统可用内核
rpm -qa |grep kernel                        #查看系统安装内核
yum remove kernel-3.10.0-862.14.4.el7       #删除内核
```
## 时区
```bash
yum install ntp
ntpdate us.pool.ntp.org
cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ntpdate cn.pool.ntp.org
hwclock -w

ntpdate time.windows.com && hwclock -w
hwclock -w
```

## OpenJDK
```bash
rpm -qa | grep java

yum install -y wget java-1.8.0-openjdk

cat >> /etc/rc.local << EOF

export  JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk
export  CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export  PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH:$HOMR/bin

cd /usr/local/tomcat7/bin/ &&./startup.sh > /home/tomcat/tomcat7
EOF
```

## Mysql5
```bash
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm

rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum install mysql-server
systemctl start mysqld
update mysql.user set password=PASSWORD('密码') where User='root';
flush privileges;
GRANT USAGE ON *.* TO 'user1'@'localhost' IDENTIFIED BY 'passwd' WITH GRANT OPTION;
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP ON db1.*  TO 'user1'@'localhost' IDENTIFIED BY 'passwd';
FLUSH PRIVILEGES;
vi /etc/my.cnf
skip-external-locking
#skip-name-resolve=0
character-set-server=utf8
max_connections=500
max_connect_errors=1500
explicit_defaults_for_timestamp=true
max_allowed_packet=64M
wait_timeout=600
tmp_table_size=256M
max_heap_table_size=128M
query_cache_size=0
sort_buffer_size=6M
key_buffer_size=384M

back_log=384

sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES

thread_stack=256k
thread_cache_size=64

#BINARY LOG GING#
log-bin=ysql-bin
binlog_cache_size=2M
expire-logs-days=7
sync-binlog=1

#INNODB#
innodb-flush-method=O_DIRECT
innodb_write_io_threads=2
innodb_read_io_threads=2
innodb-log-files-in-group=2
innodb-log-file-size=1024M
innodb-flush-log-at-trx-commit=2
innodb-file-per-table=1
innodb-buffer-pool-size=12G

systemctl restart mysqld

```

## letsencrypt
```bash
yum -y install git-core python
git clone https://github.com/letsencrypt/letsencrypt
cd letsencrypt
./letsencrypt-auto certonly --standalone --email email@gmail.com -d domian.com
./letsencrypt-auto certonly --renew-by-default --email email@gmail.com  -d domian.com
```
```bash
cd /home
wget https://github.com/certbot/certbot/archive/v0.27.1.tar.gz
tar -zxf v0.27.1.tar.gz
cd certbot-0.27.1
./certbot-auto certonly --standalone
```

## 防水墙
```bash
firewall-cmd --get-active-zones
firewall-cmd --zone=public --add-port=443/tcp --permanent
firewall-cmd --zone=public --remove-port=88/tcp --permanent
firewall-cmd --zone=public --remove-service=ftp --permanent
firewall-cmd --zone=public --add-service=ssh --permanent
firewall-cmd --list-all
systemctl restart firewalld
```

## Redis
```bash
#old redis server redis-cli
bgsave
lastsave
tar -zcf data.tar.gz data
scp data.tar.gz root@10.8.6.228:/home/redis

wget http://download.redis.io/releases/redis-5.0.4.tar.gz
tar -xzf redis-5.0.4.tar.gz
cd redis-5.0.4
make MALLOC=libc
make install
./utils/install_server.sh
cd /home/redis
tar zxf data.tar.gz
vi /etc/redis/6380.conf

/etc/init.d/redis_6380 start | stop | restart

nano /etc/init.d/redis_6380 
$CLIEXEC -a "$PWD" -p $REDISPORT shutdown
```

## OpenSSL
```bash
wget https://www.openssl.org/source/openssl-1.1.0h.tar.gz
tar -zxvf openssl-1.1.0h.tar.gz
cd openssl-1.1.0h
./config --prefix=/usr/local/openssl
make
make install
ln -sf /usr/local/openssl/bin/openssl /usr/bin/openssl
echo "/usr/local/openssl/lib" >> /etc/ld.so.conf
ldconfig -v
openssl version -a
```

## GLIBC 编译
```bash
strings /lib64/libc.so.6 |grep GLIBC_
wget http://mirrors.ustc.edu.cn/gnu/glibc/glibc-2.32.tar.gz
tar -zxf glibc-2.32.tar.gz 
cd glibc-2.32/
mkdir build
cd build/
../configure --prefix=/usr
make -j2
make install
```

## Make 编译
```bash 
wget http://mirrors.ustc.edu.cn/gnu/make/make-4.3.tar.gz
tar xf make-4.3.tar.gz
cd make-4.3/
./configure
make
make install
make -v
/usr/local/bin/make -v
mv /usr/bin/make /usr/bin/make.bak
ln -sv /usr/local/bin/make /usr/bin/make
```

## GCC 编译
```bash
yum -y install gcc+ gcc-c++
wget http://mirrors.ustc.edu.cn/gnu/gcc/gcc-8.4.0/gcc-8.4.0.tar.gz
tar xf gcc-8.4.0.tar.gz
cd gcc-8.4.0
./contrib/download_prerequisites
mkdir build
cd build
 ../configure --enable-checking=release --enable-languages=c,c++ --disable-multilib
make
make install
```

## 证书
```bash
wget http://curl.haxx.se/ca/cacert.pem -O /etc/pki/tls/certs/cacert.pem
```

## zfs
### 安装使用
[官方wiki](https://github.com/zfsonlinux/zfs/wiki/RHEL-and-CentOS)  
[zfs命令](https://docs.oracle.com/cd/E26926_01/html/E29115/zfs-1m.html)  
[zpool命令](https://docs.oracle.com/cd/E26926_01/html/E29115/zpool-1m.html)  
```bash
yum install epel-release -y
yum install http://download.zfsonlinux.org/epel/zfs-release.el7_6.noarch.rpm -y
yum makecache
yum install zfs
modprobe zfs
systemctl preset zfs-import-cache zfs-import-scan zfs-mount zfs-share zfs-zed zfs.target

zfs list                            #查看zfs列表
zfs set mountpoint=/disk/w d1t      #设置d1t挂载到/disk/w目录,可继承
zfs create -o mountpoint=/test d2t/test
zpool list                          #查看当前存储池列表
zpool status                        #查看当前存储池状态
zpool create d1t mirror sda sdb     #使用 sda、sdb、两块硬盘创建一个名为d1t的r1池 
zpool get all d1t                   #查看存储池d1t的一些信息 
zpool add d1t sdc                   #将硬盘sdc添加到池d1t中 
zpool replace d1t sdb sde           #使用硬盘sde替换d1t池中的sdb
zpool scrub d1t                     #检测池 d1t 是否存在问题
zpool iostat d1t                    #查看池 d1t 的IO使用状况，可以加 -v 来详细到池所拥有的每块磁盘
zpool upgrade d1t                   #更新d1t池
zpool upgrade -a                    #更新全部池
```

### 无法加载zfs内核
```bash
rm -rf /lib/modules/4.18.9-1.el7.elrepo.x86_64/extra
dkms remove -m zfs -v 0.7.12 --all
dkms remove -m spl -v 0.7.12 --all
dkms add -m spl -v 0.7.12
dkms add -m zfs -v 0.7.12
dkms install -m spl -v 0.7.12
dkms install -m zfs -v 0.7.12
```

## kvm
### 安装

```bash
yum -y install qemu-kvm libvirt virt-install bridge-utils
lsmod | grep kvm 
systemctl start libvirtd
systemctl enable libvirtd

wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo -O /etc/yum.repos.d/virtio-win.repo
yum install virtio-win -y   #安装win io增强

#https://docs.fedoraproject.org/en-US/quick-docs/creating-windows-virtual-machines-using-virtio-drivers/index.html

```

### 虚拟机管理
```bash
virsh list                  # 查看在运行的虚拟机
virsh dumpxml vm-name       # 查看kvm虚拟机配置文件
virsh start vm-name         # 启动kvm虚拟机
virsh shutdown vm-name      # 正常关机

virsh destroy vm-name       # 非正常关机，强制关闭虚拟机（相当于物理机直接拔掉电源）
virsh undefine vm-name      # 删除vm的配置文件

ls  /etc/libvirt/qemu       # 默认虚拟机配置文件目录

virsh define file-name.xml  # 根据配置文件定义虚拟机
virsh suspend vm-name       # 挂起，终止
virsh resume vm-name       # 恢复被挂起的虚拟机
virsh autostart vm-name     # 开机自启动vm
virsh console vm-name       # 连接虚拟机
```

### 磁盘管理

```bash
qemu-img create -f qcow2 test.img 100G                          #创建虚拟盘
qemu-img info test.img                                          #查看虚拟盘信息
qemu-img resize test.img +100G                                  #调整虚拟盘大小
qemu-img convert -f vmdk -O qcow2 test.vmdk test.img            #格式转换 vmdk -> qcow2


sdelete -z C:                                                   #先碎片整理以c盘再sdel清零
qemu-img convert -O qcow2 old.img new.img                       #转换调整大小
```

```bash
modprobe nbd max_part=8

qemu-nbd -c /dev/nbd0 test.img
qemu-nbd -d /dev/nbd0

ls /dev/nbd0*  -l

mount /dev/nbd0p1 /disk/img/
umount /disk/img

fdisk /dev/nbd0
mkfs.ext4 /dev/nbd0p1
```

### 桥接网络

```bash

#新建桥接网络
vi /etc/sysconfig/network-scripts/ifcfg-br0
DEVICE="br0"
ONBOOT="yes"
TYPE="Bridge"
BOOTPROTO=static
IPADDR=10.8.6.197
NETMASK=255.255.255.0
GATEWAY=10.8.6.1
DEFROUTE=yes

vi /etc/sysconfig/network-scripts/ifcfg-enp0s25
BRIDGE=br0

```

```bash
virt-install --name win7t --ram 4096 --vcpus 2 \
 --cdrom /disk/opt/pkg/cn_windows_7_ultimate_with_sp1_x86_dvd_u_677486.iso \
 --disk path=/usr/share/virtio-win/virtio-win_amd64.vfd,device=floppy \
 --disk /disk/opt/vms/vhdd/win7t.img,format=qcow2 \
 --network bridge=br0 --graphics vnc,listen=0.0.0.0,port=9667 --os-variant rhel5.4


```

```bash
virt-install --name centos7 --ram 4096 --vcpus 2 \
--cdrom /disk/opt/pkg/CentOS-7-x86_64-Minimal-1804.iso \
--disk /disk/opt/vms/vhdd/centos7.img,format=qcow2 \
--network bridge=br0 --graphics vnc,listen=0.0.0.0,port=9667 
```

## IpSec Vpn
```bash
wget https://git.io/vpnsetup-centos -O vpnsetup.sh
chmod 777 vpnsetup.sh

./vpnsetup.sh

VPN_IPSEC_PSK='6fTnH5uU9beYkggEKLUN0' \
VPN_USER='zxz' \
VPN_PASSWORD='XzxTop' \
./vpnsetup.sh


wget https://git.io/vpnsetup -O vpnsetup.sh
chmod 777 vpnsetup.sh
VPN_IPSEC_PSK='6fTnH5uU9beYkggEKLUN' \
VPN_USER='zxz' \
VPN_PASSWORD='XzxTop' \
sh vpnsetup.sh

vi /etc/ipsec.secrets
%any  %any  : PSK "6fTnH5uU9beYkggEKLUN0"

vi /etc/ppp/chap-secrets
"zxz" l2tpd "XzxTop" *


openssl passwd -1 'XzxTop' #GET PWDHASH

vi /etc/ipsec.d/passwd
zxz:PWDHASH:xauth-psk

systemctl restart ipsec
systemctl restart xl2tpd

service ipsec restart
service xl2tpd restart
```

```bash
cd dst && nohup ./dst &


cat >> /etc/environment << EOF
LANG=en_US.utf-8
LC_ALL=
EOF
 
source /etc/environment
localedef -v -c -i en_US -f UTF-8 en_US.UTF-8
```
