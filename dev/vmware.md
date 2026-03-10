```bash

# win7装不上tools要先装两个补丁
# https://catalog.update.microsoft.com/search.aspx?q=kb4474419
# https://catalog.update.microsoft.com/search.aspx?q=4490628

# arch
sudo pacman -S linux-headers

# 查看安装列表
sudo vmware-installer -l

# 配置网络
sudo vmware-netcfg 

# 初始化网络
sudo vmware-networks --postinstall vmware-player,0,1

# 启动网络 *注 桥接网络不会生成虚拟网卡信息 ip a看不到
sudo vmware-networks --start

# 卸载
sudo vmware-installer -u vmware-workstation

# vmware pro 针对个人已免费
paru -S vmware-keymaps
paru -S vmware-workstation


# debian
# https://wiki.debian.org/VMware#VMware_Workstation_Pro.2FPlayer_17

# hiddle tray icon
nano ~/.vmware/preferences
pref.vmware.showTrayIcon = "FALSE"


# 支持情况
# https://knowledge.broadcom.com/external/article?legacyId=80807

```


# FAQ

## 装驱动卡死

```bash

# /etc/default/grub 找到GRUB_CMDLINE_LINUX_DEFAULT="quiet"，改为以下内容：
GRUB_CMDLINE_LINUX_DEFAULT="quiet ibt=off"

# 更新initramfs
sudo update-initramfs -u
# 更新grub
sudo update-grub2
# 重启系统
sudo reboot

# arch
# Arch 如果关闭了ibt 内核会加核lts, 耍安装linux-lts-headers, N卡驱动应安装 nvidia-open-lts 
sudo mkinitcpio -P
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo reboot

```

## 不生成网卡

```bash

sudo vmware-netcfg
# An up-to-date "libaio" or "libaio1" package from your system is preferred.
# 提示还在, 但可以上网

wget https://github.com/philipl/vmware-host-modules/archive/workstation-17.6.3.tar.gz

tar -xzf vmware-host-modules-workstation-17.6.3.tar.gz

cd vmware-host-modules-workstation-17.6.3/

tar -cf vmmon.tar vmmon-only/

tar -cf vmnet.tar vmnet-only/

sudo cp -v vmmon.tar vmnet.tar  /usr/lib/vmware/modules/source/

sudo vmware-modconfig --console --install-all

```