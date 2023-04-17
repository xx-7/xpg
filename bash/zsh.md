
# zsh

```bash

sudo pacman -S zsh

# 切换
chsh -s /bin/zsh
reboot

# 卸载 ohmyzsh
uninstall_oh_my_zsh



```

# zimfw

```bash

# install
# https://github.com/zimfw/zimfw
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh


# 改完配置或样式最好install一下.zim/modules 会重新生.zwc文件
# install zim module
zimfw install



```

## PS

```bash
# 格式
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Prompt-Expansion

# Login information
# %l    tty
# %M    The full machine hostname. 
# %m    The hostname up to the first ‘.’. An integer may follow the ‘%’ to specify how many components of the hostname are desired. With a negative integer, trailing components of the hostname are shown. 
# %n    $USERNAME. 
# %y    The line (tty) the user is logged in on, without ‘/dev/’ prefix. This does not treat ‘/dev/tty’ names specially. 


# Shell state
# %#    A ‘#’ if the shell is running with privileges, a ‘%’ if not. Equivalent to ‘%(!.#.%%)’. 
# %?    上次程序运行状态

# Visual effects
# %B (%b)   开始/结束字体加粗
# %E
# %U (%u)
# %S (%s)
# %F (%f)   开始/结束字体颜色
# %K (%k)   开始/结束背景颜色

# 选择条件
# %(x.true-text.false-text)
# X     
# !     True if the shell is running with privileges. 
# #     True if the effective uid of the current process is n. 
# ?     True if the exit status of the last command was n. 
# _     True if at least n shell constructs were started. 
# C /   True if the current absolute path has at least n elements relative to the root directory, hence / is counted as 0 elements. 
# c . ~ True if the current path, with prefix replacement, has at least n elements relative to the root directory, hence / is counted as 0 elements. 
# D     True if the month is equal to n (January = 0). 
# d     True if the day of the month is equal to n. 
# e     True if the evaluation depth is at least n. 
# g     True if the effective gid of the current process is n. 
# j     True if the number of jobs is at least n. 
# L     True if the SHLVL(打开shell深度) parameter is at least n. 
# l     True if at least n characters have already been printed on the current line. When n is negative, true if at least abs(n) characters remain before the opposite margin (thus the left margin for RPROMPT). 
# S     True if the SECONDS parameter is at least n. 
# T     True if the time in hours is equal to n. 
# t     True if the time in minutes is equal to n. 
# v     True if the array psvar has at least n elements. 
# V     True if element n of the array psvar is set and non-empty. 
# w     True if the day of the week is equal to n (Sunday = 0). 
```