
# win

- AIDA64, 设备管理器

# linux

```bash

# CPU型号
grep -i "model name" /proc/cpuinfo

# 显卡型号
lspci | grep -i --color "vga\|3d\|2d"

# 芯片组型号
dmidecode -t baseboard

# 声卡型号
aplay -l

# 网卡型号
lspci | grep -i network
lshw -class network

# 硬盘型号
lshw -class disk -class storage

# 键盘、触控板、触控屏连接类型
dmesg | grep -i input

```

# 硬件选购

```bash

# 主板

# 考虑微星、华硕、华擎, 目前 Z790可用, Z890不稳定

# 内存
# 没有特殊要求

# 显卡
# N卡 1080 后都无法支持
# A卡 性能: RX6950XT, 性卡比: RX6650XT  *新卡

# 固态
# NAND/类型/cell/写入次数: SCL/1bit/大于10万 MLC/2bit/3千-1万 TLC/3bit/500-1000 QLC/4bit/150
# 到了使用寿命倒掉速, 带缓存的缓存也有寿命
# 英韧 IG5216(Shasta+) 主控避开

```

# 参数

```bash

# 微星Z790 EDGE TI MAX WIFI刀锋钛D5
# 网卡: Intel I226-V  (AppleIGC v1.5已适配)
# 声卡: 瑞昱Realtek ALC4080  (usb声卡免驱??插入设备 找音频midi设置?)
# 无线: 高通QCNCM865 WiFi 7 6GHz频段/320MHz/5.8Gbps满速

```

# FQA

## Sequoia BCM94352z 修复

```bash
# 0.更新内核扩展 BrcmPatchRAM, AirportBrcmFixup, BlueToolFixup, 要关闭AMFIPass.kext
# 1.设置
    # Misc->Security -> Secure Boot Model -> Disable
# 2. 修复wifi NVRAM -> 7C436110-AB2A-4BBB-A880-FE41995C9F82
    # csr-active-config=03080000
    # boot-args = amfi=0x80
    # 添加 boot-args = ipc_control_port_options=0
# 3. 重启系统，清除NVRAM, OpenCore Legacy Patcher, 重启
# 4. 修复蓝牙 NVRAM -> 7C436110-AB2A-4BBB-A880-FE41995C9F82
    # 添加 bluetoothExternalDongleFailed - Data - 00
    # 添加 bluetoothInternalControllerInfo - Data - 00000000 00000000 00000000 0000
# 5. 重启系统，清除NVRAM
# 6. 
    # 看是否 禁用 com.apple.iokit.IOSkywalkFamily
    # 并在Kernel-> Add :IOSkywalkFamily.kext、IO80211FamilyLegacy.kext和IO80211FamilyLegacy.kext/Contents/PlugIns/AirPortBrcmNIC.kext ,要放在BrcmPatchRAM、AirportBrcmFixup和BlueToolFixup三个后面
# 7. 重启系统，清除NVRAM, OpenCore Legacy Patcher, 重启

```

# 资源

- (AppleIGC)[https://github.com/SongXiaoXi/AppleIGC] I225/I226网卡驱动
- (AppleALC)[https://github.com/acidanthera/AppleALC] 声卡驱动