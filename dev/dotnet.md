# 反编译

- [ILSpy](https://github.com/icsharpcode/ILSpy) 
- [dotPeek](https://www.jetbrains.com/decompiler/download/#section=portable)

# 调试

- [dnSpy](https://github.com/dnSpy/dnSpy)

# MAUI

```bash

# .NET 8 / MAUI 8 资源解包 提取.net dll 资源目录 assemblies/assemblies.blob   *.blob
# https://github.com/dotnet/android/tree/main/tools/decompress-assemblies
# https://github.com/ropbear/xamarout

# .NET MAUI 9 在lib下.so文件中提取
# https://github.com/mwalkowski/pymauistore/tree/main


```

# FAQ

## 资源UnknownType

```bash

# 删除 type = "System.Resoures.Extensions.UnknownType"
# application/x-microsoft.net.object.bytearray.base64 -> application/x-microsoft.net.object.binary.base64

```