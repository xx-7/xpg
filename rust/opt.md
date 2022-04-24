# 减少生成文件体积

## 1.release

```bash
cargo build --release
```

## 2.strip

```bash
pacman -S binutils
strip -s target/release/test
```

## 3.cargo.toml

```bash
[profile.release]
opt-level = 'z'
codegen-units = 1
panic = 'abort'
lto = true
```