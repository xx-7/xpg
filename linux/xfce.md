

```bash

# 系统快捷方式文件目录
ls -l /usr/share/applications/

# 用户快捷方式文件目录
ls -l ~/.local/share/applications

# 锁屏
xscreensaver-command -lock

# 启动命令前要加env 快捷方式文件后缀要是.desktop
env LANGUAGE=zh_CN.utf8 LANG=zh_CN.utf8 LC_ALL=zh_CN.utf8 inkscape %F

```