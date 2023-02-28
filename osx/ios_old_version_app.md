

```bash
# down Itunes 12.6.3.6
# win32bit  https://secure-appldnld.apple.com/itunes12/091-33627-20170922-EF8CB708-9FEF-11E7-8504-92CF9A97A551/iTunesSetup.exe
# win64bit  https://secure-appldnld.apple.com/itunes12/091-33626-20170922-F51D3530-A003-11E7-8324-03D19A97A551/iTunes64Setup.exe

# Login in itunes 

# setting ie proxy(fiddler set https first) 

# itunes seach app and buy down first.

# fiddler 看到下面类似post链接
https://p36-buy.itunes.apple.com/WebObjects/MZBuy.woa/wa/buyProduct

# 返回xml有个softwareVersionExternalIdentifiers字段
# 会有数字版本id

# fiddler 执行命令
bpu MZBuy.woa

# 再到itunes 上下载应用
# fiddler 上会被中断到post下面链接
https://p36-buy.itunes.apple.com/WebObjects/MZBuy.woa/wa/buyProduct

# post 数据返回会有个 bundleShortVersionString字段显示版本号
# 把 appExtVrsId 替换成想要下载的版本数字ID就发送数据

# 下载完应用会在 ～\Muisc\iTunes\iTunes Media\Mobile Applications

# 安装
ideviceinstaller -i

```