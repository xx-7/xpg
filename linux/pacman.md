# Basic

[节点状态](https://www.archlinux.org/mirrors/status/)

```bash
nano /etc/pacman.d/mirrorlist
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
Server = http://mirrors.163.com/archlinux/$repo/os/$arch
```

```bash
# 同步与更新
pacman -Sy                  #同步源
pacman -Su                  #更新系统
pacman -Syu                 #同步源并更新系统
pacman -Su --ignore plasma  #不更新plasma

# 安装软件
pacman -S plasma-desktop
pacman -S plasma-{desktop,nm}
#Enter a selection (default=all): 1-10 15     #选中序号 1 至 10 和 15 的软件包
#Enter a selection (default=all): ^5-8 ^2     #选中除了序号 5 至 8 和 2 之外的所有软件包

pacman -Sw package_name                       #下载不安装
pacman -U /path/pkg.tar.gz                    #安装本地包

# 卸载软件
pacman -R package_name                        #删除单个软件包，保留其全部已经安装的依赖关系
pacman -Rs package_name                       #删除指定软件包，及其所有没有被其他已安装软件包使用的依赖关系

# 查询
pacman -Q                   #查询已安装软件包
pacman -Q plasma            #查看plasma包是否已经安装
pacman -Qi plasma           #查看已安装的包plasma的详细信息
pacman -Ql plasma           #列出已安装包plasma的所有文件
pacman -Qo /etc/passwd      #查找某个文件属于哪个包

pacman -Ss plasma           #搜索plasma相关的包

# 忽略不更新
sudo nano /etc/pacman.conf
IgnorePkg = package1 package2 package3

```

# 清除缓存

```bash
sudo rm -rf /var/cache/pacman/
rm -rf ~/.cache/paru/

```

# 更新证书报错

```bash

# 两种处理方式可以试
# 1. 刷新证书
sudo pacman -S archlinux-keyring
sudo pacman-key --refresh-keys
sudo pacman-key --init
sudo pacman-key --populate

# 2. 忽略报错软件
pacman -Syu --ignore package1,package2


```


## paru

```bash

pacman -S git rust base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

```


## yay

```bash
pacman -S git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```