# install

```bash

# https://docs.flutter.dev/get-started/install/linux

sudo apt install clang cmake git ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev


sudo pacman -S xdg-user-dirs zenity


cd /ufs/opt
curl -OL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.38.5-stable.tar.xz
tar xf flutter_linux_3.27.2-stable.tar.xz

# env flutter
export PATH=$PATH:/ufs/opt/flutter/bin
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn/
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_GIT_URL=https://github.com/flutter/flutter.git
export CHROME_EXECUTABLE=/opt/google/chrome/chrome

export ANDROID_SDK_ROOT=/ufs/sdk


sdkmanager --install 'platforms;android-36'
sdkmanager --install 'build-tools;28.0.3'

# win
# https://docs.flutter.cn/community/china

Get-ChildItem Env:

$ENV:ALL_PROXY = 'socks5://127.0.0.1:1080'

$env:PUB_HOSTED_URL="ttps://pub.flutter-io.cn";
$env:FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
$env:FLUTTER_GIT_URL="https://mirrors.ustc.edu.cn/flutter.git"


# dart api
# https://api.dart.dev

# Android 要装 Android Studio

flutter config --android-studio-dir=/optd/opt/android-studio/

# 检测环境
flutter doctor


```

# Create and build

```bash

# flutter packages
# https://pub.dev/packages

# https://docs.flutter.dev/development/platform-integration/desktop

flutter create my_app
flutter create my_app --platforms=linux,windows,macos,ios,android --project-name myapp

# add existing
flutter create --platforms=linux,windows,macos ./
flutter create --platforms=linux,windows,macos ./ --project-name myapp

flutter clean

flutter pub get

flutter run -d linux

flutter run -d linux --release

flutter build linux

flutter build linux --release


flutter config --no-enable-ios

# --no-enable-windows-desktop
# --no-enable-linux-desktop
# --no-enable-macos-desktop
# --no-enable-web
# --no-enable-android
# --no-enable-ios

# const 提醒  analysis_options.yaml -> linter -> rules
prefer_const_constructors: false

```

# Document

## StatelessWidget or StatefulWidget

- StatelessWidget 和 StatefulWidget 没有本质区别，他们的所有属性都是不可变的。它们都没法更新，除非用一个新的 Widget 去替换它们。
- StatefulWidget 拥有一个可变的 State。

# android 改 id 闪退

```bash

flutter pub add -d change_app_package_name

dart run change_app_package_name:main com.new.package.name

dart run change_app_package_name:main com.new.package.name --android

dart run change_app_package_name:main com.new.package.name --ios


```
