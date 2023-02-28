# 常用

```js


```

# 十六进制字符串转换为数组

```js
function hexStringToArray(str) {
  var pos = 0;
  var len = str.length;
  if (len % 2 != 0) {
    return null;
  }
  len /= 2;
  var arrBytes = new Array();
  for (var i = 0; i < len; i++) {
    var s = str.substr(pos, 2);
    arrBytes.push(s);
    pos += 2;
  }
  return arrBytes;
}
```

# 十六进制字符串转换为字节数组

```js
function hexStringToArray(str) {
  var pos = 0;
  var len = str.length;
  if (len % 2 != 0) {
    return null;
  }
  len /= 2;
  var arrBytes = new Array();
  for (var i = 0; i < len; i++) {
    var s = str.substr(pos, 2);
    arrBytes.push(s);
    pos += 2;
  }
  return arrBytes;
}
```

# ArrayBuffer 转换成 16 进制内容
```js
const ab2hex = buffer => {
  const arr = [] as any;
  Array.prototype.map.call(new Uint8Array(buffer), function(bit) {
    let item = ("00" + bit.toString(16)).slice(-2);
    arr.push(item);
  });
  return arr;
};
```