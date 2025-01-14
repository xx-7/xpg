# quick_start

```bash

# 安装 & 更新
cargo install flutter_rust_bridge_codegen

# 新建
flutter_rust_bridge_codegen create APP_NAME

# 已有现成flutter 
flutter_rust_bridge_codegen integrate


```

# frb2 

```bash
# https://trdthg.github.io/flutter_rust_bindgen_book_zh/integrate/new_crate.html
# https://cjycode.com/flutter_rust_bridge/guides/how-to/cargo-workspaces

cargo install flutter_rust_bridge_codegen


cargo new --lib ffi-ui-rs

# >> ffi-ui-rs/cargo.toml
[lib]
crate-type = ["staticlib", "cdylib"]

[dependencies]
flutter_rust_bridge = "=2.7.0"


flutter create flutter-ui --platforms=linux,windows,macos,ios,android --project-name fui


cd flutter-ui
flutter_rust_bridge_codegen integrate --rust-crate-dir ../ffi-ui-rs

mv ../ffi-ui-rs/src/api ../ffi-ui-rs/src/ffi

# >> ffi-client-rs/cargo.toml
[package]
name = "rust_lib_fui"

# ../ffi-client-rs/src/lib.rs
pub mod ffi;


# flutter_rust_bridge.yaml
rust_input: crate::ffi
rust_root: ../ffi-ui-rs/
dart_output: lib/rs

mkdir ./lib/rs
rm -rf ./lib/src

flutter_rust_bridge_codegen generate

# fix main.dat path

flutter run -d linux






```