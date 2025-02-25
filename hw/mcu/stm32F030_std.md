# 标准库开发环境搭建

## 下载调整目录

```bash

# https://www.st.com/en/embedded-software/stsw-stm32048.html?dl=redirect

unar en.stm32f0_stdperiph_lib.zip

cd STM32F0xx_StdPeriph_Lib_V1.6.0

rm -rf _htmresc Release_Notes.html stm32f0xx_stdperiph_lib_um.chm Utilities Package*
rm -rf Libraries/STM32F0xx_CPAL_Driver
rm -rf Libraries/CMSIS/SVD
rm -rf Libraries/CMSIS/RTOS
rm -rf Libraries/CMSIS/Documentation
rm -rf Libraries/CMSIS/index.html
rm -rf Libraries/CMSIS/README.txt
rm -rf 'Libraries/CMSIS/CMSIS END USER LICENCE AGREEMENT.pdf'

mv Libraries/CMSIS/Device/ST/STM32F0xx/Include/* Libraries/CMSIS/
mv Libraries/CMSIS/Device/ST/STM32F0xx/Source/Templates/system_stm32f0xx.c Libraries/CMSIS/

mv Projects/STM32F0xx_StdPeriph_Templates/stm32f0xx_conf.h Libraries/CMSIS/

rm -rf Projects

rm -rf Libraries/CMSIS/Device

mv Libraries pkg

# 用于存放ld跟starup文件
# STM32F030F4PX_FLASH.ld 主要是(区段/字节对齐/加载地址)可以从以前项目复制或者用STM32CubeIDE生成一次
# startup_stm32f030f4px.s gcc 启动文件可以从以前项目复制或者用STM32CubeIDE生成一次
mkdir pkg/CMSIS/gcc


# svd https://github.com/modm-io/cmsis-svd-stm32
mkdir pkg/svd

mkdir inc
mkdir src

cat > src/main.c << EOF
#include "stm32f0xx.h"

int main(void){

}
EOF

cat > CMakeLists.txt << 'EOF' 

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)
cmake_minimum_required(VERSION 3.21)


set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++)
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)
set(CMAKE_AR arm-none-eabi-ar)
set(CMAKE_OBJCOPY arm-none-eabi-objcopy)
set(CMAKE_OBJDUMP arm-none-eabi-objdump)
set(SIZE arm-none-eabi-size)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)


project(testf030 C CXX ASM)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD 11)

add_compile_options(-mcpu=cortex-m0 -mthumb -mthumb-interwork)
add_compile_options(-ffunction-sections -fdata-sections -fno-common -fmessage-length=0)

# uncomment to mitigate c++17 absolute addresses warnings
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-register")

# Enable assembler files preprocessing
add_compile_options($<$<COMPILE_LANGUAGE:ASM>:-x$<SEMICOLON>assembler-with-cpp>)

if ("${CMAKE_BUILD_TYPE}" STREQUAL "Release")
    message(STATUS "Maximum optimization for speed")
    add_compile_options(-Ofast)
elseif ("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
    message(STATUS "Maximum optimization for speed, debug info included")
    add_compile_options(-Ofast -g)
elseif ("${CMAKE_BUILD_TYPE}" STREQUAL "MinSizeRel")
    message(STATUS "Maximum optimization for size")
    add_compile_options(-Os)
else ()
    message(STATUS "Minimal optimization, debug info included")
    add_compile_options(-Og -g)
endif ()

include_directories(
    ./
    ${CMAKE_SOURCE_DIR}/pkg/CMSIS/Include
    ${CMAKE_SOURCE_DIR}/pkg/CMSIS
    ${CMAKE_SOURCE_DIR}/pkg/STM32F0xx_StdPeriph_Driver/inc
    ${CMAKE_SOURCE_DIR}/inc
)
add_definitions( -D__MICROLIB -DSTM32F030 -DUSE_STDPERIPH_DRIVER)

# aux_source_directory(${CMAKE_SOURCE_DIR}/std_lib/src STDLIB)
# set(STDLIB ${CMAKE_SOURCE_DIR}/std_lib/src/stm32f0xx_gpio.c
#                 ${CMAKE_SOURCE_DIR}/std_lib/src/stm32f0xx_exti.c
#                     ${CMAKE_SOURCE_DIR}/std_lib/src/stm32f0xx_spi.c)


aux_source_directory(${CMAKE_SOURCE_DIR}/pkg/STM32F0xx_StdPeriph_Driver/src/ STDLIB)
aux_source_directory(${CMAKE_SOURCE_DIR}/pkg/CMSIS/ SYSTEM)
aux_source_directory(${CMAKE_SOURCE_DIR}/src MAIN)

set(STARTUP       ${CMAKE_SOURCE_DIR}/pkg/CMSIS/gcc/startup_stm32f030f4px.s)
set(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/pkg/CMSIS/gcc/STM32F030F4PX_FLASH.ld)

add_link_options(-Wl,-gc-sections,--print-memory-usage,-Map=${PROJECT_BINARY_DIR}/${PROJECT_NAME}.map)
add_link_options(-mcpu=cortex-m0 -mthumb -mthumb-interwork)
add_link_options(-T ${LINKER_SCRIPT})

add_executable(${PROJECT_NAME}.elf  ${SYSTEM} ${MAIN} ${STDLIB} ${STARTUP} ${LINKER_SCRIPT})

set(HEX_FILE ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.hex)
set(BIN_FILE ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.bin)

add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${PROJECT_NAME}.elf> ${HEX_FILE}
        COMMAND ${CMAKE_OBJCOPY} -Obinary $<TARGET_FILE:${PROJECT_NAME}.elf> ${BIN_FILE}
        COMMENT "Building ${HEX_FILE}
Building ${BIN_FILE}")

EOF

mkdir build && cd build
cmake ../
make


# vscode setting.json
"cortex-debug.gdbPath": "gdb-multiarch" 


cat > .vscode/launch.json << 'EOF' 

{
    "version": "0.2.0",
    "configurations": [
        {
            "cwd": "${workspaceRoot}",
            "executable": "${workspaceRoot}/build/test.elf",   
            "name": "Debug with OpenOCD",
            "request": "launch",
            "type": "cortex-debug",
            "servertype": "openocd",
            "configFiles": [
                "/usr/share/openocd/scripts/interface/stlink.cfg",  //在OpenOCD选择下载器
                "/usr/share/openocd/scripts/target/stm32f0x.cfg"    //在OpenOCD选择芯片
            ],
            "svdFile": "${workspaceRoot}/pkg/svd/STM32F0x0.svd"   //选择寄存器文件
        }
    ]
}

EOF

```