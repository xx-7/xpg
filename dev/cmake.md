
```bash

# BUILD_TYPE Debug, Release, RelWithDebInfo, MinSizeRe
-DCMAKE_BUILD_TYPE=MinSizeRel

# i686 交叉编译
cmake ../ -DCMAKE_SYSTEM_NAME=Windows -DCMAKE_SYSTEM_VERSION=6.1 -DCMAKE_BUILD_TYPE=MinSizeRel -DCMAKE_C_COMPILER=i686-w64-mingw32-gcc

```