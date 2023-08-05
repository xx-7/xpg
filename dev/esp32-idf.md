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

# 添加到 
# esp-idf
cat >> ~/.config/zsh/aliases.zsh << EOF
# esp32-idf
alias get_idf='. /optd/opt/esp/esp-idf/export.sh'
alias idf='idf.py'
EOF

```

# 操作

```bash

# https://docs.espressif.com/projects/esp-idf/zh_CN/v5.1/esp32/get-started/linux-macos-setup.html
# https://docs.espressif.com/projects/esp-idf/zh_CN/release-v5.1/esp32/api-guides/tools/idf-py.html

# 编译
idf build

# 烧录
idf -p PORT flash

# 监视输出
idf -p PORT monitor

# 目标芯片
idf set-target esp32

# 配置
idf menuconfig

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
void app_main(void) {
}
EOF




```