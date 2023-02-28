

```bash

# Ios open http://host:port download root certificate
# install 
# Settings -> General -> Profiles
# open
# Settings -> General -> About -> Certificate Trust Settings

# win 注意安装到受信任的根证书颁发机构
# cmd -> certMgr.msc 打开证书管理，看到证书说明安装成功

# Rules -> Customize Rules 

# setting socks gateway
# static function OnBeforeRequest(oSession: Session) {
# add
	oSession["X-OverrideGateway"] = "socks=127.0.0.1:5557";

# log websocket
# static function OnWebSocketMessage(oMsg: WebSocketMessage) {
# add
    FiddlerApplication.Log.LogString(oMsg.ToString());

# 请求命令
# https://docs.telerik.com/fiddler/knowledge-base/quickexec

# 匹配url断点
bpu /test.apsx
# 没有参数时, 清空匹配url断点
bpu
    
```