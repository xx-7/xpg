export PATH=$PATH:/usr/local/bin
export PATH=$PATH:~/.local/bin


export LANG=en_US.utf8
export LC_ALL=en_US.utf8

# rust
[[ -f ~/.cargo/env ]] && . ~/.cargo/env


# flutter
export PATH=$PATH:/optd/opt/flutter/bin
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn/
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_GIT_URL=https://mirrors.tuna.tsinghua.edu.cn/git/flutter-sdk.git
export CHROME_EXECUTABLE=/opt/google/chrome/chrome

# java
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk/"
export PATH=$PATH:/usr/lib/jvm/java-17-openjdk/bin/
export PATH=$PATH:/optd/opt/gradle-8.3/bin/