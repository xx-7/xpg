# 常用

```bash

# 优化配置
# 生成debug release 编译文件
# 设置输出目录为build 输出文件此目录下

# 配置外部工具

# upx /optd/opt/upx/upx best --lzma "$TargetFile()"
# strip /usr/bin/strip strip-all "$TargetFile()" 

# QT5 https://wiki.freepascal.org/Qt5_Interface

# linux
# https://github.com/davidbannon/libqt5pas/releases/latest 下载  libqt5pas-dev libqt5pas1 重新安装

# win only x86  可以在linux上交叉编译 运行环境要提取
# https://gitlab.com/freepascal.org/lazarus/binaries/-/raw/main/i386-win32/qt5/Qt5Pas1.dll?inline=false 下载 Q5Pas1.dll
# https://download.qt.io/new_archive/qt/5.6/5.6.2/ 下载 qt-opensource-windows-x86-mingw492-5.6.2.exe 安装后dll在 Qt\Qt5.6.2\5.6\mingw49_32\bin 少什么复制什么


```



# Install

```bash

# Download
# https://www.lazarus-ide.org/index.php?page=downloads

# Install
# https://wiki.lazarus.freepascal.org/Installing_Lazarus_on_Linux

sudo apt install ./fpc-laz_3.2.2-210709_amd64.deb  ./fpc-src_3.2.2-210709_amd64.deb  ./lazarus-project_4.0.0-0_amd64.deb

# 删除配置文件 会重新显示新安装完的配置选择布局页面
rm -rf ~/.lazarus

```


# Install2
```bash

# 快速安装
# fpcupdeluxe
# https://github.com/LongDirtyAnimAlf/fpcupdeluxe


# QFLazarus
# 如果文件下载不了,config.ini有下载地址,下载到设置的安装目录会自动识别

```