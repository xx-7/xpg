# wasmparser
    [https://github.com/bytecodealliance/wasm-tools](https://github.com/bytecodealliance/wasm-tools) 子项目
    主要负责wasm二进制字节流解析。
    定义文档:[https://webassembly.github.io/spec/core/binary/index.html](https://webassembly.github.io/spec/core/binary/index.html)

## 源码
  入口 Parser -> parse_all -> parse_reader
  binary_reader.rs -> BinaryReader 封装了一些底层字节读取,游标管理方法。
  readers 目录下各种 Section 实现