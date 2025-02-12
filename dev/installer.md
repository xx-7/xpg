```bash

# windows Inno Setup
# https://jrsoftware.org/isdl.php

# mac
npm install -g appdmg

config.json
{
    "title": "Test App",
    "icon": "thumb.icns",
    "contents": [
        {
            "x": 448,
            "y": 344,
            "type": "link",
            "path": "/Applications"
        },
        {
            "x": 192,
            "y": 344,
            "type": "file",
            "path": "../../build/macos/Build/Products/Release/xxx.app"
        }
    ]
}

# 可以直接改icon文件 为thumb.icns
# 生成
appdmg config.json test.dmg


```