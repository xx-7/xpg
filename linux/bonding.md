# debian

```bash


sudo apt install ifenslave      # ifenslave的作用是网卡的负载均衡

# 0：      balance-rr       负载均衡模式
# 1：      active-backup    主备模式
# 2：      balance-xor      异或策略
# 3：      broadcast        广播策略
# 4：      802.3ad          动态链接聚合
# 5:       balance-tlb      适配器传输负载均衡
# 6：      balance-alb      适配器负载均衡


sudo nano /etc/network/interfaces
auto bond0                      # 这里我们命名bonding名称为 bond0
iface bond0 inet static
	address x.x.x.x
	netmask x.x.x.x
	gateway x.x.x.x
bond_slaves eth0 eth1           # 这里我们指定eth0和eth1两个网口为bond0组内成员
bond_mode 4                     # 这里我们指定使用 mode 4 动态链路聚合模式
bond_xmit_hash_policy layer2+3  # 这里我们指定分发策略为layer2+3
bond_miimon 100                 # 监测时间为100毫秒
bond_downdelay 200              # 网卡down up 时间毫秒
bond_updelay 200                # 发现链路恢复时，激活该链路之前的等待时间毫秒，updalay的值应该为miimon的整数倍


#此处为手动加载bonding模块，无需重启系统即可生效
modprobe bonding mode=4 miimon=100

#此方式在系统每次启动时将自动加载bonding模块
echo "bonding mode=4 miimon=100" >> /etc/modules

sudo systemctl restart networking

```

# systemd-networkd

```bash

nano /etc/systemd/network/25-bond0.netdev

[NetDev]
Name=bond0
Kind=bond

[Bond]
Mode=802.3ad
MIIMonitorSec=1s
LACPTransmitRate=fast
UpdelaySec=2s
DownDelay=8s
TransmitHashPolicy=layer2+3

# 桥接或设置ip
nano /etc/systemd/network/bond0.network
[Match]
Name=bond0

[Network]
BindCarrier=enp2s0f0 enp2s0f1
Bridge=br0

nano /etc/systemd/network/enp2s0f0.network

[Match]
Name=enp2s0f0

[Network]
Bond=bond0

nano /etc/systemd/network/enp2s0f1.network

[Match]
Name=enp2s0f1

[Network]
Bond=bond0

# 查询状态
cat /proc/net/bonding/bond0

```
