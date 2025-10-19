[TOC]

# 配置
```bash


# window
# C:\Users\<YourUsername>\AppData\Roaming\mpv\config

nano ~/.config/mpv/config

# 标题
title='${filename} - mpv'
script-opts='osc-title=${filename}'

speed=1.6
screen=1
fullscreen=yes
sub-auto=all
sub-file-paths=subs

ao=alsa
audio-device=auto


# 驱动列表
mpv --ao=help

# 设备列表
mpv --audio-device=help

# 旋转
nano ~/.config/mpv/input.conf
ctrl+t cycle-values video-rotate 0 90 180 270


```

# 鼠标控制

| 快捷键   | 功能          |
| :------- | :------------ |
| 左键双击 | 进入/退出全屏 |
| 右键单击 | 暂停/继续播放 |

# 播放控制

| 快捷键 | &nbsp; | 功能                                      |
| :----- | :----- | :---------------------------------------- |
| p      | Space  | 暂停、继续播放                            |
| /      | \*     | 减少/增加音量                             |
| 9      | 0      | 减少/增加音量（数字键盘区的 9、0 不可用） |
| m      | &nbsp; | 静音                                      |
| ←      | →      | 快退/快进 5 秒                            |
| ↑      | ↓      | 快进/快退 1 分钟                          |
| <      | >      | 上一个/下一个（播放列表中）               |
| Enter  | \*     | 下一个（播放列表中）                      |
| l      | &nbsp; | 设定/清除 A-B 循环点                      |
| I      | &nbsp; | 显示当前文件名                            |
| L      | &nbsp; | 循环播放                                  |
| s      | &nbsp; | 截屏                                      |
| S      | &nbsp; | 截屏，无字幕                              |
| q      | &nbsp; | 退出                                      |
| Q      | &nbsp; | 保存播放进度并退出                        |

# 视频控制

| 快捷键     | &nbsp; | 功能                 |
| :--------- | :----- | :------------------- |
| \_(下划线) | &nbsp; | 循环切换可用视频轨   |
| A          | &nbsp; | 循环切换视频画面比例 |
| [          | ]      | 减少/增加 0.1 倍速率 |
| {          | }      | 减少/增加 1 倍速率   |
| Backspace  | &nbsp; | 还原到 1.0 倍速      |
| .          | ,      | 下一帧/上一帧        |

# 音频控制

| 快捷键 | &nbsp; | 功能               |
| :----- | :----- | :----------------- |
| #      | &nbsp; | 循环切换可用音频轨 |
| Ctrl + | Ctrl - | 音轨延迟+/- 0.1 秒 |

# 字幕控制

| 快捷键 | &nbsp; | 功能                |
| :----- | :----- | :------------------ |
| V      | &nbsp; | 关闭/开启字幕       |
| j      | J      | 循环切换可用字幕轨  |
| x      | z      | 字幕延迟 +/- 0.1 秒 |
| r      | t      | 上移/下移字幕位置   |

# 窗口控制

| 快捷键 | 功能          |
| :----- | :------------ |
| T      | 窗口始终置顶  |
| f      | 进入/退出全屏 |
| ESC    | 退出全屏      |

# [官方文档](https://mpv.io/manual/stable/)


# 摄像头 

```bash

# 安装包
sudo apt-get install v4l-utils

# https://github.com/mpv-player/mpv/wiki/Video4Linux2-Input

mpv --demuxer-lavf-o=video_size=4656x3496,input_format=mjpeg av://v4l2:/dev/video0 --profile=low-latency

# video-rotate 旋转角度
mpv --demuxer-lavf-o=video_size=1920x1080,input_format=mjpeg av://v4l2:/dev/video0 --profile=low-latency --video-rotate=180

```