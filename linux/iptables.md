

```bash

# 添加放行
iptables -A INPUT -p tcp --dport 22 -j ACCEPT


# 清除所有, 没有stop要关时先save然后清除所有，开时再restore回来
sudo iptables -F
sudo iptables -X

# 默认规则
# policy： ACCEPT DROP REJECT
iptables -P INPUT [policy]
iptables -P OUTPUT [policy]
iptables -P FORWARD [policy]

# 查看
iptables -L -n


# nat 
sudo iptables -t nat -A POSTROUTING -s 192.168.1.0/24  -j MASQUERADE
# 只nat针对 10.8.8.0/24的访问
sudo iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -d 10.8.8.0/24 -j MASQUERADE

# 端口转发
sudo iptables -t nat -A PREROUTING -p tcp --dport 53 -j DNAT --to-destination 192.168.1.2:53

sudo iptables -t nat -A PREROUTING -p tcp --dport 22 -j DNAT --to-destination 192.168.1.2:22
# 回路 nat
sudo iptables -t nat -A POSTROUTING -d 192.168.1.2 -p tcp --dport 22 -j SNAT --to 10.8.8.9

sudo iptables -t nat -nL --line

# 删除nat转发
sudo iptables -t nat -D PREROUTING 1
sudo iptables -t nat -D POSTROUTING 1

sudo iptables -t nat -D POSTROUTING 5

sudo iptables -t nat -F
sudo iptables -t nat -X
sudo iptables -t nat -L -n

sudo iptables -t mangle -L -n

sudo iptables -A POSTROUTING -t mangle -p tcp --dport 9966 -j MARK --set-mark 10
sudo iptables -t mangle -D PREROUTING 1
sudo iptables -t mangle -D POSTROUTING 1

sudo iptables -t mangle -F
sudo iptables -t mangle -X

sudo iptables -t mangle -nL --line




# 保存
iptables-save > /etc/iptables.up.rules
# 恢复
iptables-restore < /etc/iptables.up.rules

# 开机自动加载
nano /etc/network/if-pre-up.d/iptables

#!/bin/sh
/sbin/iptables-restore < /etc/iptables.up.rules

chmod +x /etc/network/if-pre-up.d/iptables

```