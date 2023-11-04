# rust

```toml

prost-types = "0.12"
prost = "0.12"

[build-dependencies]
prost-build = "0.12.1"

```

## build.rs

```rs
use std::io::Result;

fn main() -> Result<()> {
    prost_build::compile_protos(&["protos/hello.proto"], &["protos/"])?;
    Ok(())
}

```

## 使用

```rs
// 新建
let hello = protos::HelloRequest {name: "hello".to_string()};
info!("test: {:?}", hello);

// encode
let mut buf = Vec::new();
buf.reserve(hello.encoded_len());
hello.encode(&mut buf).unwrap();
info!("test encode: {}", buf.len());

// decode
let hello = protos::HelloRequest::decode(&mut Cursor::new(buf))?;
info!("decode: {:?}", hello);

let buf3 = vec![10u8,5,104,101,108,108,111];
let hello = protos::HelloRequest::decode(&mut Cursor::new(buf3))?;
info!("decode: {:?}", hello);
```

# js

```bash

npm i protobufjs
npm i protobufjs-cli -D

# 生成js 可加入到package.json中
pbjs -t static-module -w es6 -o src/pbs/hello.js  ../pbs/hello.proto

```

## 使用

```js
// 导入
import { hello } from "./proto/hello";

// 新建
var req = hello.HelloRequest.create({ name: "hello" });
// encode
let buffer = hello.HelloRequest.encode(req).finish();
// decode
let message = hello.HelloRequest.decode(buffer);
```
