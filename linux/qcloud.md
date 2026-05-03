
# 清监控


```bash

# 停止并卸载监控组件
/usr/local/qcloud/monitor/barad/admin/uninstall.sh
# 停止并卸载安全组件
/usr/local/qcloud/stargate/admin/uninstall.sh
# 删除相关文件
rm -rf /usr/local/qcloud

# 删除与 qcloud
crontab -e

systemctl disable tat_agent

```