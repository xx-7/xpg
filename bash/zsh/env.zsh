export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/sbin

export PATH=$PATH:~/.local/bin


export LANG=en_US.utf8
export LC_ALL=en_US.utf8

# rust
[[ -f ~/.cargo/env ]] && . ~/.cargo/env

export PATH=$PATH:~/.cargo/bin

export PATH=$PATH:/ufs/opt/upx

export PATH=$PATH:/ufs/opt/bin

export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_SCALE_FACTOR=1.75

# java
export JAVA_HOME=/ufs/opt/jdk-21.0.9
export PATH=$PATH:$JAVA_HOME/bin/
export PATH=$PATH:/ufs/opt/gradle-8.3/bin/


# Rk
export PATH=$PATH:/ufs/opt/rk/upgrade_tool/


# flutter
export PATH=$PATH:/ufs/opt/flutter/bin
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn/
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_GIT_URL=https://github.com/flutter/flutter.git
export CHROME_EXECUTABLE=/opt/google/chrome/chrome

export ANDROID_SDK_ROOT=/ufs/sdk

export PATH=$PATH:/ufs/opt/android-platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools/



export JAR_TOOLS_ROOT=/ufs/opt/jar

# jar
export PATH=$PATH:/ufs/opt/jar
