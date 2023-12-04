```bash

# https://rocm.docs.amd.com/en/latest/deploy/linux/os-native/install.html

# 信用证书
sudo mkdir --parents --mode=0755 /etc/apt/keyrings
wget https://repo.radeon.com/rocm/rocm.gpg.key -O - | gpg --dearmor | sudo tee /etc/apt/keyrings/rocm.gpg > /dev/null

# 添加AMDGPU源

ver=5.6.1

echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/rocm.gpg] https://repo.radeon.com/amdgpu/$ver/ubuntu jammy main" \
    | sudo tee /etc/apt/sources.list.d/amdgpu.list
sudo apt update

sudo apt install amdgpu-dkms
sudo reboot

# 添加ROCm源

ver=5.6.1

echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/rocm.gpg] https://repo.radeon.com/rocm/apt/$ver jammy main" \
    | sudo tee --append /etc/apt/sources.list.d/rocm.list

echo -e 'Package: *\nPin: release o=repo.radeon.com\nPin-Priority: 600' \
    | sudo tee /etc/apt/preferences.d/rocm-pin-600
sudo apt update

# rocm-hip-libraries
sudo apt install rocm-hip-sdk5.6.1


# 验证安装
sudo dkms status

sudo /opt/rocm/bin/rocminfo



# 卸载
# https://rocm.docs.amd.com/en/latest/deploy/linux/os-native/uninstall.html
sudo apt autoremove rocm-hip-libraries
sudo apt autoremove rocm-core
sudo apt autoremove amdgpu-dkms
sudo rm /etc/apt/sources.list.d/amdgpu.list
sudo rm /etc/apt/sources.list.d/rocm.list

sudo rm -rf /var/cache/apt/*
sudo apt-get clean all



```