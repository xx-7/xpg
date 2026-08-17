# tdl

```bash
# https://github.com/iyear/tdl
# https://docs.iyear.me/tdl/zh/guide

# install
curl -sSL https://docs.iyear.me/tdl/install.sh | sudo bash

# login
tdl login

# 会话列表
tdl chat ls --proxy socks5://127.0.0.1:11028

# 导出聊天记录
tdl chat export -c  12345678 --with-content --proxy socks5://127.0.0.1:11028

# 下载视频
tdl dl -u  https://t.me/c/12345678/123  -u  https://t.me/c/12345678/124
tdl dl -u  https://t.me/c/12345678/123  --proxy socks5://127.0.0.1:11028

# TDL配置全局代理
export TDL_PROXY=socks5://127.0.0.1:11028

# TDL线程数(默认4)
export TDL_THREADS=6

# TDL同时下载数(默认2)
export TDL_LIMIT=3


```

```bash

# https://github.com/JoeanAmier/TikTokDownloader
py main.py


# cookie-name:odin_tt 搜cookie关键字

```
