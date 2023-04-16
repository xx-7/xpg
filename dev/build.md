

# pkgconfig

```bash

pacman -S pkgconf

pkg-config --list-all

pkg-config sdl2 --libs --cflags

pkg-config sdl2 --static --libs --cflags

pkg-config sdl2 --cflags

pkg-config sdl2 --libs

# x86 交叉编译
i686-pc-linux-gnu-pkg-config

PKG_CONFIG_SYSROOT_DIR=/mingw32
PKG_CONFIG_PATH=/mingw32/lib/pkgconfig

# 查看.pc文件目录
pkg-config --variable pc_path pkg-config

# 默认  配置是目录下.pc文件
PKG_CONFIG_PATH = /usr/local/lib/pkgconfig

```