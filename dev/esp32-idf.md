# 安装

```bash

mkdir -p /optd/opt/esp
cd /optd/opt/esp
git clone -b v5.1 --recursive https://github.com/espressif/esp-idf.git

cd esp-idf

# 优先选择 Espressif 下载服务器
export IDF_GITHUB_ASSETS="dl.espressif.com/github_assets"

# 安装单个芯片支持
./install.sh esp32

# 安装多个芯片支持
./install.sh esp32,esp32s2

# 安装所有芯片支持
./install.sh all

# 添加到 ~/.config/zsh/env.zsh

# esp-idf
[[ -f /optd/opt/esp/esp-idf/export.sh ]] && . /optd/opt/esp/esp-idf/export.sh

```

# 操作

```bash

# https://docs.espressif.com/projects/esp-idf/zh_CN/v5.1/esp32/get-started/linux-macos-setup.html

# 编译
idf.py build

# 烧录
idf.py -p PORT flash

# 监视输出
idf.py -p PORT monitor

# 目标芯片
idf.py set-target esp32

# 配置
idf.py menuconfig

```

# 新建项目

```bash
mkdir -p hello/src
cd hello


cat > CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.16)

set(EXTRA_COMPONENT_DIRS "src")

include($ENV{IDF_PATH}/tools/cmake/project.cmake)

project(hello)
EOF

cat > ./src/CMakeLists.txt << EOF
idf_component_register(SRCS "main.c"
                    INCLUDE_DIRS "" REQUIRES spi_flash)
EOF



cat > ./src/main.c << EOF
idf_component_register(SRCS "main.c"
                    INCLUDE_DIRS "" REQUIRES spi_flash)
EOF




```