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


cargo new --lib demo

# >> demo/cargo.toml
[lib]
crate-type = ["staticlib", "cdylib"]
name = "rust_lib_fui"

[dependencies]
flutter_rust_bridge = "=2.11.1"


flutter create flutter --platforms=linux,windows,macos,ios,android --project-name fui

# 换平台或更新版本最好 integrate 再清空缓存 generate 再编译容易出莫名其妙错误

cd flutter
flutter_rust_bridge_codegen integrate --rust-crate-dir ../

mv ../src/api ../src/ffi

# ../ffi-client-rs/src/lib.rs
pub mod ffi;


# flutter_rust_bridge.yaml
rust_input: crate::ffi
rust_root: ..//
dart_output: lib/rs

mkdir ./lib/rs
rm -rf ./lib/src

flutter_rust_bridge_codegen generate

# fix main.dat path

flutter run -d linux

```

# FAQ

## 加载库文件名字不匹配

```bash

# flutter/rust_builder 默认是判断 lib${cargo.package.name}.so 为名字的文件是否存在，
# 解决方式:
#           1.修改项目名为要加载的文件名: rust_lib_fui
#           2.是修改优先看是否设置 cargo.lib.name

# 2.1. flutter/rust_builder/cargokit/build_tool/lib/src/cargo.dart
#        CrateInfo 添加  final String libName; 并修改构造方法  {required this.packageName, required this.libName}
#                 修改  parseManifest -> final libName = (meta['lib'] != null && meta['lib']['name'] != null) ? meta['lib']['name'] : name;
#                                return CrateInfo(packageName: name, libName: libName);

# 2.2. flutter/rust_builder/cargokit/build_tool/lib/src/artifacts_provider.dart
#               getArtifacts() -> environment.crateInfo.packageName -> environment.crateInfo.libName

```
