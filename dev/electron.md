# asar

```bash

# 安装 asar
npm install -g asar

# 解包文件 app.asar 到 app 目录
asar extract app.asar.bak app

# 打包目录 app 为 app.asar
asar pack app app.asar

```

# https 证书错误

## electron 自身

```js
const { app } = require("electron");

// 启动参数
app.commandLine.appendSwitch("ignore-certificate-errors");

// 主进程监听
app.on(
  "certificate-error",
  (event, webContents, url, error, certificate, callback) => {
    console.log("certificate-error", url);
    event.preventDefault();
    callback(true);
  }
);

// renderer 设置 CertificateVerifyProc
const win = new BrowserWindow();
win.webContents.session.setCertificateVerifyProc((request, callback) => {
  console.warn("certificate-verify-proc");
  callback(0);
});
```

## axios

```js
// 设置一项也可以
const httpsAgent = new https.Agent({
  rejectUnauthorized: false, // 忽略出错证书
  ca: fs.readFileSync("./bundle.crt"), // 根证书
  cert: fs.readFileSync("./usercert.pem"), // 中间证书
  key: fs.readFileSync("./key.pem"), // 证书
  passphrase: "YYY",
});

// 使用
axios.get(url, { httpsAgent });
const instance = axios.create({ httpsAgent });
```

## got

```js
// https://github.com/sindresorhus/got/blob/main/documentation/5-https.md

await got("https://example.com", {
  https: {
    rejectUnauthorized: false,
    certificateAuthority: fs.readFileSync("./my_ca.pem"), // 信任ca
  },
});

// 注意有些程序会在请求前检测删除https rejectUnauthorized 等相关设置
```
