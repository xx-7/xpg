# windows

```bash


git clone https://github.com/microsoft/vcpkg.git


cd vcpkg
.\bootstrap-vcpkg.bat

.\vcpkg integrate install

# env
# VCPKG_ROOT    D:\vcpkg
# Path          D:\vcpkg
# Path          %VCPKG_ROOT%\installed\x64-windows-static\bin

# 指定拉取版本
vcpkg install openssl:x64-windows


vcpkg install openssl:x64-windows-static

```

# linux

```bash

git clone git@github.com:microsoft/vcpkg.git

./bootstrap-vcpkg.sh

.\vcpkg integrate install

# ENV
export VCPKG_ROOT=/ufs/opt/vcpkg
export VCPKG_INSTALLED_ROOT=$VCPKG_ROOT/installed
export PATH=$PATH:$VCPKG_ROOT:$VCPKG_INSTALLED_ROOT/x64-linux/bin

```
