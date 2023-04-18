

# pkgconfig

```bash

pacman -S pkgconf

pkg-config --list-all

pkg-config --libs --cflags sdl2

pkg-config --static --libs --cflags sdl2

pkg-config --cflags sdl2

pkg-config --libs sdl2 

# x86 交叉编译
i686-pc-linux-gnu-pkg-config  --libs --cflags 

PKG_CONFIG_SYSROOT_DIR=/mingw32
PKG_CONFIG_PATH=/mingw32/lib/pkgconfig

# 查看.pc文件目录
pkg-config --variable pc_path pkg-config

i686-pc-linux-gnu-pkg-config --variable pc_path pkg-config

# 默认  配置是目录下.pc文件
PKG_CONFIG_PATH = /usr/lib/pkgconfig:/usr/share/pkgconfig

#  python 库urllib中urlopen 只支持http,https代理, 不支持socks meson下载依赖就是调用的urlopen
export {http,https}_proxy=http://172.17.0.1:5556

```