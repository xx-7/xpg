

# rar

```bash

sudo apt install libarchive-tools

bsdtar xf file.rar

```

# zip

```bash
sudo apt install zip
sudo pacman -S zip
zip -re dest.zip src        #回车，输入2次密码
zip -rP PASS dest.zip src

unzip src.zip                #按提示输入密码
unzip -P PASS src.zip

```

# 7Z

```bash
sudo apt install p7zip
sudo pacman -S p7zip

7za -p -mhe -r a destOutputFileName srcFileOrDir1 srcFileOrDir2 ....
:'
-mhe 加密文件名
-p 需要设置密码 （敲完命令回车后，根据提示输入密码和确认，密码将和linux系统密码一样不显示)
-ppassword 直接设置密码
-r 读取目录及子目录所有文件
'

7za x 7zFileName [-oOutputPath]

:'
x 是安装原来的目录结构解压
e 是忽略目录结构，都解压到跟目录
-o 输出目录非必须
' 
```