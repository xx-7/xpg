# adb

```bash
# download win adb
# https://dl.google.com/android/repository/platform-tools-latest-windows.zip
# [-s <serialNumber>]
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

# tcpdump

> [https://www.androidtcpdump.com/android-tcpdump/downloads](https://www.androidtcpdump.com/android-tcpdump/downloads)

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

# sdk 现在要通过 Android Studio 管理
# https://developer.android.com/studio?hl=zh-cn

```