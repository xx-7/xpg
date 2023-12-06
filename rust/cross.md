```bash

# 简化编译可以用 cross
# https://github.com/cross-rs/cross
# 是运行docker 编译 要先装 docker
cross build --target  arm-unknown-linux-musleabihf --release



# 设置libc 版本
[target.arm-unknown-linux-gnueabihf]
zig = "2.23"

```