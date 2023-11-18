

```bash

# 添加放行
iptables -A INPUT -p tcp --dport 22 -j ACCEPT


# 清除所有, 没有stop要关时先save然后清除所有，开时再restore回来
sudo iptables -F
sudo iptables -X

# 查看
iptables -L -n


# nat 
sudo iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -j MASQUERADE

# 端口转发
iptables -t nat -A PREROUTING -p tcp --dport 53 -j DNAT --to-destination 192.168.1.8:53

sudo iptables -t nat -F
sudo iptables  -t nat -X
sudo iptables -t nat -L -n




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