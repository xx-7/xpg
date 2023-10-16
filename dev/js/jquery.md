# 版本差别

```js
// 赋值
// 之前 $("#ID").attr('value', VALUE) 在select中无效
$("#ID").val(VALUE);

// attr 获取的页面元素值
// prop 比对象中取值

// html本身自带固有属性用prop
// html自定义dom属性用attr

// 原来 attr 后面版本 建议用prop
"#ID".attr("checked", true);
// 现在
"#ID".prop("checked", true);

// 原来
$.find("input:[key=KEY]");
// 现在
$.find("input[key=KEY]");
```
