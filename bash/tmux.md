# install

```bash
pacman -S tmux

mkdir -p ~/.tmux/plugins

git clone git@github.com:tmux-plugins/tpm.git --depth=1 ~/.tmux/plugins/tpm

git clone git@github.com:tmux-plugins/tmux-sensible.git --depth=1 ~/.tmux/plugins/tmux-sensible
~/.tmux/plugins/tmux-resurrect/resurrect.tmux
git clone git@github.com:tmux-plugins/tmux-resurrect.git --depth=1 ~/.tmux/plugins/tmux-resurrect
~/.tmux/plugins/tmux-sensible/sensible.tmux

nano ~/.tmux.conf
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'

run-shell ~/.tmux/plugins/tmux-sensible/sensible.tmux
run-shell ~/.tmux/plugins/tmux-resurrect/resurrect.tmux


tmux source-file ~/.tmux.conf

```

# use

```bash
# 常用

# 接到之前会话
tmux a
# 分离退出tmux
`, d
# 列出所有会话
`, s
# 保存布局
`, ctrl + s
# 恢复布局
`, ctrl + r
# 切换面板
`, 方向键 
# 分左右两格
`, %
# 分上下两格
`, “



# 列出所有快捷键
tmux list-keys
 
# 列出所有 命令, 参数
tmux list-commands
 
# 列出所有的信息
tmux info
 
# 列出所有会话
tmux ls

# ==========================
# 系统

# 新建会话
tmux
# 新建会话指定名字
tmux new -s NAME
# detach, 断开会话
`, d
# 连接断开会话
tmux a
# 连接断开会话指定名字
tmux a -t NAME
# 连接断开会话指定名字
tmux attach -t NAME
# 关闭会话指定名字
tmux kill-session -t NAME
# 关闭所有会话
tmux kill-server
# 会话列表
tmux ls
# 列出所有会话
`, s
# 列出所有会话、面板
`, w
# 保存布局 resurrect 实现
`, ctrl + s
# 恢复布局 resurrect 实现
`, ctrl + r

# ==========================
# 面板

#  左右分割
`, "    "
#  上下分割
`, %
# 面板移动到新的窗口打开
`, !
# 关闭当前面板
`, x
# 最大化当前面板
`, z
# 移动光标至某个方向的面板
`, 方向键
# 向某个方向扩张窗口五个单元格, 也可以直接使用鼠标进行拖动
`, command 方向键
# 向前序号置换面板
`, {
# 向后序号置换面板
`, }
# 顺时针拨动面板
`, Ctrl-o
# 光标挪至下一面板
`, o
# 显示当前窗口所有面板序号, 编号显示时输入编号即可切换至面板
`, q
# 在当前面板显示时钟
`, t

# ==========================
# 窗口

# 创建新窗口
`, c
# 关闭窗口
`, &
# 打开上一个窗口
`, p
# 打开下一个窗口
`, n
# 重命名窗口
`, ,
# 重命名窗口序号
`, .
# 根据窗口序号切换至对应窗口
`, 1~9

# ==========================
# 插件 注意网络被墙

# 安装 
, I
# 更新
, U
# 移除
, alt u


```