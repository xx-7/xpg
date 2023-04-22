# install

```bash

# https://docs.flutter.dev/get-started/install/linux

cd /optd/opt
curl -OL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.7.12-stable.tar.xz
tar xf flutter_linux_3.7.12-stable.tar.xz

# env flutter
export PATH=$PATH:/optd/opt/flutter/bin
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn/
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_GIT_URL=https://mirrors.tuna.tsinghua.edu.cn/git/flutter-sdk.git
export CHROME_EXECUTABLE=/opt/google/chrome/chrome


# dart api
# https://api.dart.dev


```

# Create and build

```bash

# flutter packages
# https://pub.dev/packages

# https://docs.flutter.dev/development/platform-integration/desktop

flutter create my_app
flutter create my_app --platforms=linux,windows,macos --project-name myapp

# add existing
flutter create --platforms=linux,windows,macos ./
flutter create --platforms=linux,windows,macos ./ --project-name myapp

flutter clean

flutter pub get

flutter run -d linux

flutter build linux

flutter build linux --release

```