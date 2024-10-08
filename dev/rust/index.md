## 记录
### [Iterator](./iterator.md) 

## 开源库
    - [SixtyFPS](https://github.com/sixtyfpsui/sixtyfps) 
    - [Flume](https://github.com/zesterer/flume)
    - [Tokio](https://github.com/tokio-rs/tokio)
    - [Monoio](https://github.com/bytedance/monoio)

## 库

### bytecodealliance
#### [wasmparser](./wasmparser.md) 
#### fern 日志

## 安装更新
```bash
curl https://sh.rustup.rs -sSf | sh
rustup update
```
## 编译
```bash
cargo run
cargo run --example demo1
cargo build --release


rustup self uninstall
rustup default stable-gnu
rustup default stable-x86_64-pc-windows
rustup toolchain install stable-x86_64-pc-windows-gnu
rustup toolchain uninstall stable-x86_64-pc-windows-gnu

rustup target list
rustup target add x86_64-unknown-linux-gnu
rustup target add x86_64-pc-windows-gnu
rustup target add i686-pc-windows-gnu

cargo build --target=x86_64-pc-windows-gnu

cargo build --target=i686-pc-windows-gnu

cargo build --target=x86_64-unknown-linux-gnu

```

```
rustup component add  rust-src rls rust-analysis 

cargo test -- --nocapture
```

## Cargo Config
```bash
nano ~/.cargo/config

[build]
target = "x86_64-unknown-linux-gnu"

[target.x86_64-pc-windows-gnu]
linker = "x86_64-w64-mingw32-gcc"

[target.i686-pc-windows-gnu]
linker = "i686-w64-mingw32-gcc"
rustflags = "-C panic=abort"

[target.x86_64-unknown-linux-musl]
linker = "x86_64-linux-musl-gcc" 

[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
replace-with = 'ustc'
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
[source.tuna]
registry = "https://mirrors.tuna.tsinghua.edu.cn/git/crates.io-index.git"

[net]
git-fetch-with-cli = true


ext install matklad.rust-analyzer

rm -rf ~/.cargo/.package-cache
```

## 关键字
```bash

as break const continue crate if else struct enum true false fn
for in let loop impl mod match move mut pub ref return self
Self static super trait type unsafe use where while async await
dyn main

```

## 保留字
```bash
abstract become box do final macro override priv typeof
unsized virtual yield try
```

## rustfmt.toml
```toml
max_width = 180
```