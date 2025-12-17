```bash

# win7装不上tools要先装两个补丁
# https://catalog.update.microsoft.com/search.aspx?q=kb4474419
# https://catalog.update.microsoft.com/search.aspx?q=4490628


# 查看安装列表
sudo vmware-installer -l

# 卸载
sudo vmware-installer -u vmware-workstation

# vmware pro 针对个人已免费
paru -S vmware-workstation


# debian
# https://wiki.debian.org/VMware#VMware_Workstation_Pro.2FPlayer_17

# hiddle tray icon
nano ~/.vmware/preferences
pref.vmware.showTrayIcon = "FALSE"

```
