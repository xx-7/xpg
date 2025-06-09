

# FAQ

## Error: Forward declaration not solved "HandleIgnoreError(TLHandle);"

- 配置为qt5 win64都会出现这个错误, 原因是"lclnet.pas"宏开关只设置win32跟qt"lclgtkeventer.inc", 设置下就正常了