# runtime

- [window](https://go.microsoft.com/fwlink/p/?LinkId=2124703)

# command

```bash

cargo tauri build

cargo tauri build --target i686-pc-windows-gnu

cargo tauri build --target x86_64-pc-windows-gnu

# https://tauri.app/zh-cn/v1/guides/building/app-size

[profile.release]
panic = "abort"
codegen-units = 1 
lto = true
opt-level = "s"
strip = true

```