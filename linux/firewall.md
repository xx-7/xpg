```bash

# install
sudo apt install firewalld

sudo systemctl enable firewalld
sudo systemctl start firewalld



# 重加载
sudo firewall-cmd --reload

# zone
# all zones
# trusted 信任所有  public 不允许流入
sudo firewall-cmd --get-zones
sudo firewall-cmd --get-active-zones

# 自定义区
sudo firewall-cmd --permanent --new-zone=customzone

# 设置默认 zone
firewall-cmd --set-default-zone=public

# 接口加入public zone
firewall-cmd --zone=public --add-interface=eth0

# 配置列表
sudo firewall-cmd --list-all

# 永久生效 --permanent


# 开启masquerade
sudo firewall-cmd --add-masquerade --permanent
# 检查是否允许 NAT 转发
sudo firewall-cmd --query-masquerade
# 禁用转发
sudo firewall-cmd --remove-masquerade

# 配置端口转发规则
# firewall-cmd --permanent --zone=<区域> --add-forward-port=port=<源端口号>:proto=<协议>:toport=<目标端口号>:toaddr=<目标IP地址>
# 5555端口转发到 -> 172.16.1.9:22
sudo firewall-cmd --permanent --add-forward-port=port=5555:proto=tcp:toport=22:toaddr=172.16.1.9

# nat 192.168.1.0/24 到 eth1
sudo firewall-cmd --permanent --direct --passthrough ipv4 -t nat -I POSTROUTING -o eth1 -j MASQUERADE -s 192.168.1.0/24





# 查看规则
firewall-cmd --zone=public --list-rich-rules
# 允许 192.168.1.0/24 访问 80
firewall-cmd --permanent --add-rich-rule="rule family="ipv4" source address="192.168.1.0/24" port protocol="tcp" port="80" accept"
# 限制 192.168.1.0/24 访问 80
firewall-cmd --permanent --add-rich-rule="rule family="ipv4" source address="192.168.1.0/24" port protocol="tcp" port="80" reject"



# 查看防火墙端口开启状态
firewall-cmd --list-ports

# 添加服务
sudo firewall-cmd --permanent --add-service=http
# 禁用服务
sudo firewall-cmd --permanent --remove-service=http

# 添加端口
firewall-cmd --zone=public --add-port=80/tcp --permanent

# 删除端口
firewall-cmd --zone=public --remove-port=80/tcp --permanent

```
