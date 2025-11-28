# Debian

```bash

mokutil --sb-state

lspci | grep -E "VGA|3D"

# 安装依赖
sudo apt install -y linux-headers-$(uname -r) dkms gcc acpid libglvnd-core-dev libglvnd0 libglvnd-dev pkg-config

# 如果报错，就先执行下列命令修复依赖
# sudo apt --fix-broken install

# 删除旧包
sudo apt --purge remove "*nvidia*" "*libxnvctrl*"
sudo apt autoremove

# 禁用nouveau开源驱动
sudo nano /etc/modprobe.d/blacklist.conf

blacklist nouveau
options nouveau modeset=0

# /etc/default/grub 找到GRUB_CMDLINE_LINUX_DEFAULT="quiet"，改为以下内容：
GRUB_CMDLINE_LINUX_DEFAULT="quiet rd.driver.blacklist=nouveau"

# 更新initramfs
sudo update-initramfs -u
# 更新grub
sudo update-grub2
# 重启系统
sudo reboot
# 验证是否禁用nouveau
lsmod | grep nouveau

# 32位支持 可选
sudo dpkg --add-architecture i386 # 添加32位架构支持
sudo apt update # 更新软件仓库元数据
sudo apt install libc6:i386


# https://www.nvidia.com/en-us/drivers/
# alt + ctrl + f2 切换到命令行 gui中容易出错
sudo chmod a+x NVIDIA-Linux-x86_64-570.144.run # 赋予run程序可执行权限
sudo ~/NVIDIA-Linux-x86_64-570.144.run


# 选类型  MIT
# 是否安装32位库？——选择yes
# 是否使用dkms编译内核模块源代码？——选择yes
# 是否重建initramfs？——选择yes（非强制，建议选择yes）
# 是否代替使用NVIDIA X代替默认X服务？
        # 这步即选择yes意味着生成xconf文件，使用NVIDIA显卡进行渲染图形界面。如果是单显卡，这里选择yes，即使用独立显卡渲染图形界面
        # 如果是双显卡（1块核显+1块NVIDIA独显），选择no，即使用核心显卡渲染图形界面


# 验证
nvidia-smi

```

# CUDA

```bash


# https://docs.nvidia.com/cuda/cuda-installation-guide-linux/#pre-installation-actions
wget https://developer.download.nvidia.com/compute/cuda/13.0.2/local_installers/cuda_13.0.2_580.95.05_linux.run
sudo sh cuda_13.0.2_580.95.05_linux.run

nvcc --version


```
