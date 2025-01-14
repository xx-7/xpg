# install

```bash

# https://docs.flutter.dev/get-started/install/linux

sudo apt install clang cmake git ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev


cd /optd/opt
curl -OL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.27.2-stable.tar.xz
tar xf flutter_linux_3.27.2-stable.tar.xz

# env flutter
export PATH=$PATH:/optd/opt/flutter/bin
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn/
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_GIT_URL=https://mirrors.tuna.tsinghua.edu.cn/git/flutter-sdk.git
export CHROME_EXECUTABLE=/opt/google/chrome/chrome

export ANDROID_SDK_ROOT=/optd/sdk


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

flutter build linux

flutter build linux --release


flutter config --no-enable-ios

# --no-enable-windows-desktop
# --no-enable-linux-desktop
# --no-enable-macos-desktop
# --no-enable-web
# --no-enable-android
# --no-enable-ios


```


# Document 

## StatelessWidget or StatefulWidget
 * StatelessWidget和StatefulWidget没有本质区别，他们的所有属性都是不可变的。它们都没法更新，除非用一个新的Widget去替换它们。
 * StatefulWidget拥有一个可变的State。
