```bash

# 路由表id: local | main | default | all | NUMBER
# 默认不带table 参数操作的是main表
# id 对应名字保存在 /etc/iproute2/rt_tables

# 优先级
# 查询出第一列数字
# 指定后面加参数 prio NUMBER
# 数字越小优先级越高

# 规则

# 查询
sudo ip rule show
sudo ip rule show table 200
# 添加 来源
sudo ip rule add from 192.168.1.1 table 200
sudo ip rule add from 192.168.1.0/24 table 200
# 添加 目的
sudo ip rule add to 192.168.1.1 table 200
sudo ip rule add to 192.168.1.0/24 table 200
# 添加根据标签ID
sudo ip rule add fwmark 200 table 200
# 添加根据设备
sudo ip rule add dev wlan0 table 200
# 添加指定优先级
sudo ip rule add from 192.168.1.0/24 table 200 prio 10

# 删除
sudo ip rule del table 200
sudo ip rule del prio 10
sudo ip rule del to 192.168.1.0/24
sudo ip rule del from 192.168.1.0/24
sudo ip rule del from 192.168.1.0/24 table 200 prio 10

# 根据iptables标记设置表
sudo ip rule add fwmark 10 table 10 

# 路由
# 查询
sudo ip route show
sudo ip route show table 200

# 添加
sudo ip route add 192.168.1.0/24 via 10.9.9.28 table main
# 添加 dev
sudo ip route add 192.168.1.0/24 dev eth1 table 200
# 添加默认
sudo ip route add default via 10.9.9.28 table 200
sudo ip route add default dev wlan0

# 删除
sudo ip route del default table 200
sudo ip route del 192.168.1.0/24 table 200


```
