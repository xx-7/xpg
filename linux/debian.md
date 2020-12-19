[TOC]

# 安装

## kde
```bash
apt install kde-plasma-desktop

# 全局主题: Arc Dark, Orchis
# 图标: Papirus, Tela

```

# 配置

## 源

### 备份

```bash
# 源列表 https://www.debian.org/mirror/list.zh-cn.html
cp /etc/apt/sources.list /etc/apt/sources.listbak 
```

### 测试源
```bash
deb http://ftp.cn.debian.org/debian/ bullseye main contrib non-free
deb http://ftp.cn.debian.org/debian/ bullseye-updates main contrib non-free
```

### 稳定源
```bash
deb http://ftp.cn.debian.org/debian/ buster main contrib non-free
deb http://ftp.cn.debian.org/debian/debian-security buster-updates main contrib non-free
```

## apt
```bash
sudo apt update
sudo apt upgrade
sudo apt dist-upgrade
sudo apt install
sudo apt remove
sudo apt autoremove
sudo apt clean all
sudo apt list
```

## sudo
```bash
apt install sudo
nano /etc/sudoers
Default:USERNAME rootpw
Default:USERNAME timestamp_timeout=20
USERNAME	ALL=(ALL:ALL) ALL
```

# 软件
## 常用
```bash
sudo apt install curl unar 
sudo apt install ttf-wqy-microhei fcitx-table-wbpy
```