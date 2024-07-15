# List

- [Sarasa Gothic](https://github.com/be5invis/Sarasa-Gothic)
- [霞鹜文楷](https://github.com/lxgw/LxgwWenKai)
- [Fira Code](https://github.com/tonsky/FiraCode)
- [有字库龙藏手写体](https://github.com/google/fonts/blob/main/ofl/longcang/LongCang-Regular.ttf)

# Install

## Arch

```bash
# https://wiki.archlinux.org/title/Font_configuration
# 默认字体 Noto Sans 10pt / Hack 10pt(fix width)
sudo pacman -S ttf-sarasa-gothic
sudo pacman -S ttf-fira-code
sudo pacman -S adobe-source-code-pro-fonts

sudo fc-cache -fv

# 查询系统中字体
fc-list | grep 'WenQuan'

# 查询系统mono字体
fc-list :mono | grep 'WenQuan'

# 默认字体目录
/usr/share/fonts/
~/.local/share/fonts

# 默认配置文件
/etc/fonts/local.conf
~/.config/fontconfig/fonts.conf


```

```xml
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <alias>
    <family>sans-serif</family>
    <prefer>
      <family>Noto Sans</family>
      <family>Sarasa Gothic SC</family>
      <family>sans-serif</family>
    </prefer>
  </alias>
  <alias>
    <family>serif</family>
    <prefer>
      <family>Noto Serif</family>
      <family>Sarasa Gothic SC</family>
      <family>serif</family>
    </prefer>
  </alias>
  <alias>
    <family>monospace</family>
    <prefer>
      <family>Sarasa Mono SC</family>
      <family>DejaVu Sans Mono</family>
      <family>monospace</family>
    </prefer>
  </alias>
</fontconfig>
```

# Debian

```bash

# 复制字体到目录
sudo cp ./LXGWWenKaiMono-Regular.ttf /usr/share/fonts/opentype/diy/

# 重新缓存
sudo fc-cache -fv

# 查询系统中字体
fc-list | grep 'diy'

# 查询系统mono字体
fc-list :mono | grep 'diy'

```