
# install

```bash

rustup target add aarch64-linux-android armv7-linux-androideabi

nano ~/.cargo/config.toml


[target.aarch64-linux-android]
ar = "/optd/opt/android-ndk-r26b/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar"
linker = "/optd/opt/android-ndk-r26b/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android30-clang"

[target.armv7-linux-androideabi]
ar = "/optd/opt/android-ndk-r26b/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar"
linker = "/optd/opt/android-ndk-r26b/toolchains/llvm/prebuilt/linux-x86_64/bin/armv7a-linux-androideabi30-clang"

```

# Demo

```bash

# https://github.com/jni-rs/jni-rs

cargo new --lib jni_demo

# Cargo.toml

[dependencies]
jni = "0.21"

[lib]
crate_type = ["cdylib"]

# lib.rs

use jni::JNIEnv;
use jni::objects::{JClass, JString};

#[no_mangle]
pub extern "system" fn Java_HelloWorld_hello<'local>(
    mut env: JNIEnv<'local>,
    _class: JClass<'local>,
    input: JString<'local>,
) -> JString<'local> {

    let input: String = env
        .get_string(&input)
        .expect("Couldn't get java string!")
        .into();

    let output = env
        .new_string(format!("Hello, {}!", input))
        .expect("Couldn't create java string!");
    output
}


cargo build --target aarch64-linux-android

cargo build --target armv7-linux-androideabi


```