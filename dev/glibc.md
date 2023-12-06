```bash

# 查看版本
ldd --version

# 查看支持libc版本
busybox strings /lib/libm.so.6 | grep GLIBC_


# cross 设置libc 版本
[target.arm-unknown-linux-gnueabihf]
zig = "2.23"

```