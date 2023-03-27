```bash

pacman -S which

which wx-config

# meson 编译时会通过wx-config获取编译参数
# compile_args:
wx-config --cxxflags std stc

# link_args:
wx-config --libs std stc

```

# cross

```bash

# meson 交叉编译时要注册设置wx-config = 'wx-config' 默认会是 wx-config.exe

pacman -S gcc mingw-w64-gcc diffutils make wget tar
wget https://github.com/wxWidgets/wxWidgets/releases/download/v3.2.2.1/wxWidgets-3.2.2.1.tar.bz2
mkdir wxWidgets
tar -xf wxWidgets-3.2.2.1.tar.bz2 --strip-components 1 -C wxWidgets/
mkdir wxWidgets/msw -p
cd wxWidgets/msw

# --disable-debug release
# --disable-shared 静态版本 --enable-shared 动态链接版本
# ../configure --help 但看编译选项
./configure prefix=/usr/i686-w64-mingw32 --host=i686-w64-mingw32 --build=x86_64-pc-linux-gnu --enable-unicode --with-msw --disable-debug --enable-shared --disable-dependency-tracking
make
make install
ldconfig

i686-w64-mingw32-g++ -o main.exe src/main.cpp `/usr/i686-w64-mingw32/bin/wx-config --cxxflags --libs`

```