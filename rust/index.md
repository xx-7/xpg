## 记录
### [Iterator](./iterator.md) 

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

rustup target list
rustup target add x86_64-pc-windows-gnu
```

```
rustup component add  rust-src rls rust-analysis 

cargo test -- --nocapture
```

## Cargo Config
```bash
nano ~/.cargo/config
[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
replace-with = 'ustc'
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
[source.tuna]
registry = "https://mirrors.tuna.tsinghua.edu.cn/git/crates.io-index.git"


ext install matklad.rust-analyzer
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

## fustfmt.toml
```toml
verbose=false
max_width=180
comment_width=180
tab_spaces=4
fn_call_width=180
struct_lit_width=32
fn_call_style="Visual"
single_line_if_else_max_width=180
trailing_comma="Vertical"
chain_indent="Visual"
chain_one_line_max=180
reorder_imports=true
format_strings=false
hard_tabs=true
wrap_match_arms=false
error_on_line_overflow=false
```