```bash

# 列出加载依赖

ldd /bin/ls
objdump -p /bin/ls

# 看查找过程
LD_DEBUG=libs /bin/ls


# 设置从当前目录查找
LD_LIBRARY_PATH=. ./main

# 搜索优先级
# RPATH(或RUNPATH) -> LD_LIBRARY_PATH -> 系统路径

# 复制过去更新缓存, 如与其它程序有冲突有风险!!!
sudo cp libfoo.so /usr/local/lib
sudo ldconfig

# 编译时批定加载目录
-Wl,-rpath,`pwd`
# 不管用
export RUSTFLAGS="-C link-args=-Wl,-rpath,@loader_path/../libs"

# 工具修改
sudo apt install patchelf

patchelf --print_rpath test
patchelf --add-rpath ./lib ./test
patchelf --set-rpath ./lib ./test
patchelf --remove-rpath ./test

```