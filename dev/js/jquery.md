# 版本差别

```js
// 赋值
// 之前 $("#ID").attr('value', VALUE) 在select中无效
$("#ID").val(VALUE);

// 原来
$.find("input:[key=KEY]");
// 现在
$.find("input[key=KEY]");
```