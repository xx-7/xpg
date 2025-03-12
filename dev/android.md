# adb

```bash


# adb 下载地址
# https://developer.android.com/tools/releases/platform-tools?hl=zh-cn

# [-s <serialNumber>]

# 30版本以后先要配对才能连接
adb pair IP:PORT CODE
adb devices
adb pull <local> <remote>
adb push <remote> <local>
adb shell <command> 
adb install <path-to-apk>
adb version
adb kill-server
adb start-server
adb root start-server
adb root
adb remount
adb shell stop
adb shell start
adb reboot
adb shutdown
```
# ida debugger

```bash
adb root start-server
adb push android_server64 /data/local/tmp/

adb shell
cd 
chmod 755 /data/local/tmp/android_server64
/data/local/tmp/android_server64

adb forward tcp:23946 tcp:23946   #other window

ida -> Debugger -> Remote ArmLinux/Android debbuger
```

## frida-server

```bash
# down frida-server-x.y.z-android-arm64.xz https://github.com/frida/frida/releases/
unar frida-server-x.y.z-android-arm64.xz
mv frida-server-x.y.z-android-arm64 frida-server
adb push frida-server /data/local/tmp
adb shell
cd /data/local/tmp
su
chmod 777 frida-server
./frida-server

```

# tcpdump

- [downloads](https://www.androidtcpdump.com/android-tcpdump/downloads)

```bash

sudo pacman -S android-tools

adb connect 127.0.0.1:5555

adb pull /sdcard/capture.pcap

adb push tcpdump /system/bin/tcpdump
adb shell

chmod 6755 /system/bin/tcpdump

tcpdump -i any -p -s 0 -w /sdcard/capture.pcap

```

# NDK

```bash
# https://github.com/android/ndk/releases

wget https://dl.google.com/android/repository/android-ndk-r26b-linux.zip

unar android-ndk-r26b-linux.zip

export PATH=$PATH:/optd/opt/android-ndk-r26b/


```

# SDK

```bash

# sdk gui 现在要通过 Android Studio 管理
# https://developer.android.com/studio?hl=zh-cn

# 命令行管理

mkdir /optd/sdk
export ANDROID_SDK_ROOT=/optd/sdk

# https://developer.android.com/studio#command-line-tools-only
wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
mkdir /optd/sdk/cmdline-tools/
unar commandlinetools-linux-11076708_latest.zip -o /optd/sdk/cmdline-tools/

cd /optd/sdk/cmdline-tools/ && mv cmdline-tools latest && cd -

export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin


sdkmanager --list_installed --sdk_root=/optd/sdk/

sdkmanager --list_installed 

# 安装下初始环境, 其它的版本,ndk这些flutter 要用到自动会装
sdkmanager --install platform-tools
sdkmanager --install 'platforms;android-35'
sdkmanager --install 'build-tools;35.0.1'

# 设置adb目录
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools/


```
# 反编译

```bash

java -jar $ANDROID_SDK_ROOT/build-tools/26.0.2/lib/dx.jar --dex --output=test.dex 'com/test/test.class'

java -jar $JAR_TOOLS_ROOT/baksmali-2.5.2.jar dis 'test.dex'


# 生成证书
keytool -genkey -keystore my-release-key.keystore -alias my_alias -keyalg RSA -keysize 4096 -validity 10000

# 签名
jarsigner -sigalg MD5withRSA -digestalg SHA1 -keystore my-release-key.keystore -signedjar super.mlxx.apk mlxx.apk my_alias

```