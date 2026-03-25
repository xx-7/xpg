

```bash
sudo pacman -S network-manager-applet
# 系统快捷方式文件目录
ls -l /usr/share/applications/

# 用户快捷方式文件目录
ls -l ~/.local/share/applications

# 锁屏
xscreensaver-command -lock

# 启动命令前要加env 快捷方式文件后缀要是.desktop
env LANGUAGE=zh_CN.utf8 LANG=zh_CN.utf8 LC_ALL=zh_CN.utf8 inkscape %F

# 屏幕闪
Settings Editor -> xfwm4 -> vblank_mode -> off


flameshot gui


```

# 锁屏

```bash

sudo pacman -S xfce4-power-manager

# System -> System power saving -> When inactive for -> Never
#           Security -> Lock screen when system is going to sleep -> Uncheck

# Display -> Display power management -> Put to sleep after -> 12 minutes 
#                                     -> Switch off after -> 13 minutes 
xfce4-power-manager-settings

sudo pacman -S xfce4-screensaver

# Screensaver -> Theme -> Slideshow
#               Activate screenaver when computer is idle ->  Regard the computer as idle after: 12 minutes
# Lock Screen -> Lock Screen with Screensaver -> Lock the screen after the screensaver is active for: 2 minutes
xfce4-screensaver-preferences

# 快捷键
# Settings -> Keyboard -> Application Shortcuts -> add -> Super + L -> xfce-screensaver-command --lock

```