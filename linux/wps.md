# Arch
```bash
# https://wiki.archlinuxcn.org/wiki/WPS_Office

paru -S wps-office ttf-wps-fonts

# 汉化
# 1.下载deb中文版 https://linux.wps.cn/
# 2.解压
unar wps-office_11.1.0.11698_amd64.deb
# 3.复制配置
sudo cp -r data/opt/kingsoft/wps-office/office6/mui/zh_CN /usr/lib/office6/mui
# 4.修改配置 从中文版 data/opt/kingsoft/wps-office/office6/mui/lang_list_community.json
#   复制配置 下面样式到 /usr/lib/office6/mui/lang_list/lang_list.json

# 中文
LANGUAGE=zh_CN wps

# 英文
LANGUAGE=en_US wps

```
## 样式示例

```json
    {
        "locale" : "zh_CN",
        "online" : false,
        "plugin_name" : "lang_zh",
        "type" : "",
        "text" : {
            "name_en" : "简体中文",
            "name_current_lang" : "简体中文",
            "title" : "选择语言",
            "initializing" : "初始化中...",
            "run_in_bg" : "后台运行",
            "install_configuration" : "安装语言包，配置应用环境。",
            "failed_re_download" : "下载语言包失败，点击重新下载。",
            "new_lang" : "WPS支持 %1, 点击完成安装。",
            "follow_sys" : "跟随系统语言",
            "reboot" : "切换语言后，您需要重启WPS来应用修改。",
            "follow_sys_or_en" : "默认跟随系统语言，若WPS不支持该语言将显示英文。",
            "not_downloaded" : "没有下载",
            "bg_download" : "后台下载",
            "re_download" : "重新下载",
            "download" : "下载 ",
            "download_finished" : "已下载 %1",
            "do_it_later" : "稍后执行",
            "set_now" : "立刻执行",
            "exit_cancel_download" : "退出后将取消正在进行的下载。",
                        "cancel_download" : "取消下载",
                        "recommend" : "推荐",
                        "apply" : "应用"
        }
    },
```