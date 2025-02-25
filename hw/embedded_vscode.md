# VSCode嵌入式开发环境

- GCC
- CMake
- arm-none-eabi-gcc
- OpenOCD
- VSCode插件(CMake)

## Debian

```bash

sudo apt install gcc-arm-none-eabi gdb-arm-none-eabi

arm-none-eabi-gcc -v

# vscode setting.json
"cortex-debug.gdbPath": "gdb-multiarch" 
```