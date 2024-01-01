```bash

# 简化编译可以用 cross
# https://github.com/cross-rs/cross
# 是运行docker 编译 要先装 docker
cross build --target  arm-unknown-linux-musleabihf --release



# 设置libc 版本
[target.arm-unknown-linux-gnueabihf]
zig = "2.23"

# xwin 交叉编译win msvc
sudo apt install nsis lld llvm
rustup target add x86_64-pc-windows-msvc
cargo install xwin
xwin splat --output ~/.xwin


# config.toml

[target.x86_64-pc-windows-msvc]
linker = "lld"
rustflags = [
  "-Lnative=/home/username/.xwin/crt/lib/x86_64",
  "-Lnative=/home/username/.xwin/sdk/lib/um/x86_64",
  "-Lnative=/home/username/.xwin/sdk/lib/ucrt/x86_64"
]

cargo build --target x86_64-pc-windows-msvc

```