
```bash

sudo deluser --remove-home admin

# 查询已登录用户
w

# 显示用户信息
id

# 查看用户所属组
groups fex

# 查看所有用户组
cat /etc/group

# 增加组
sudo groupadd usbfs
#查看组id
cat /etc/group | grep usbfs

# 用户添加组
sudo usermod -a -G usbfs fex
# 用户添除组
sudo usermod -r -G usbfs fex

```

# usb权限

```bash

# usb设备列表
lsusb
# 列表详情
lsusb -vvv
# 查看usb权限
ls /dev/bus/usb/ -lR
# 临时权限
sudo chmod 666 /dev/bus/usb/001/009

# 永久权限
sudo nano /etc/udev/rules.d/50-fv1106.rules
SUBSYSTEMS=="usb",ATTRS{idVendor}=="2207",ATTRS{idProduct}=="110c",GROUP="users",MODE="0666"
sudo udevadm control --reload

```