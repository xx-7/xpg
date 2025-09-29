# env

```bash

# 目录
$SPBROOT\share\pcb\text\ENV

# 关闭定义,已重新定义
# alias F2 zoom fit
# alias F6 done
# alias F7 next

# alias SF6 move
# alias SF7 dehilight all
# alias SF8 hilight pick

# alias CF2 next
# alias CF5 color192

# alias ~N new
# alias ~O open

# button wheel_up "zoom in $buttonfactor"
# button wheel_down "zoom out $buttonfactor"
# button Cwheel_up "zoom in $buttonfactor"
# button Cwheel_down "zoom out $buttonfactor"

# 添加


#  *************************customize start************************

alias ~U dehilight all
alias ~H hilight pick

alias Del delete
alias ~E move
alias ~L place manual

funckey d done
funckey Esc done

alias Home zoom fit
alias ~D done
alias ~R spin
# funckey r spin
#定义 Shitf+S 或者大写模式下单S 开始进行修线
funckey S slide

# 快速旋转角度
funckey tab iangle 90

# 重要提示，重要提示，重要提示。。 带 @ 的快捷键必须启用 alt 按键。这个 @ 就是表示alt 按键。
#启用方法 setup-User preferences-UI-input里勾上allegro_alt_alias 之后重启软件

alias ~@c color192
alias ~@C color192
alias ~@G define grid
alias ~@D cmgr
alias ~@P prmed
alias ~@V status

funckey n next

#定义 Shitf+A 或者大写模式下单A 开始绕线
funckey A delay tune
funckey f mirror
alias ~F mirror
alias ~P prmed
alias ~M cmgr
#funckey uc unrats component
#funckey sr rats component
#funckey un unrats net
funckey a rats net
#funckey rn rats net
alias ~H hilight
alias ~U dehilight

# 隐藏所有飞线
alias  zu unrats all

# 显示所有飞线
alias  zy rats all

# 高亮对象
funckey h hilight

funckey q cancel

# w line widht mils
alias w1 options acon_line_width 1
alias w2 options acon_line_width 2
alias w3 options acon_line_width 3
alias w4 options acon_line_width 4
alias w5 options acon_line_width 5
alias w6 options acon_line_width 6
alias w7 options acon_line_width 7
alias w8 options acon_line_width 8
alias w9 options acon_line_width 9
alias w10 options acon_line_width 10
alias w11 options acon_line_width 11
alias w12 options acon_line_width 12
alias w13 options acon_line_width 13
alias w14 options acon_line_width 14
alias w15 options acon_line_width 15
alias w16 options acon_line_width 16
alias w17 options acon_line_width 17
alias w18 options acon_line_width 18
alias w19 options acon_line_width 19
alias w20 options acon_line_width 20
alias w25 options acon_line_width 25
alias w30 options acon_line_width 30
alias w35 options acon_line_width 35
alias w40 options acon_line_width 40
alias w45 options acon_line_width 45
#mm
alias w0.1 options acon_line_width 0.1
alias w0.15 options acon_line_width 0.15
alias w0.2 options acon_line_width 0.2
alias w0.25 options acon_line_width 0.25
alias w0.3 options acon_line_width 0.3
alias w0.35 options acon_line_width 0.35
alias w0.4 options acon_line_width 0.4
alias w0.45 options acon_line_width 0.45
alias w0.5 options acon_line_width 0.5
alias w0.55 options acon_line_width 0.55


# 可以一个快捷键执行多个命令，用引号引起来即可。例如以下命令表示输入ct则执行布线，class设置为etch，subclass设置为Top三个分命令。
# funckey ct "add connect; class Etch ; subclass Top"

# 开启或关闭栅格显示
alias gd grid toggle


# 下面这几个zz命令是模仿PADS的zz所有层都显示。
alias zz Replay zz.scr 

# umm把单位改成毫米 ，um把单位改成mil
# alias um Replay um.scr
# alias umm Replay umm.scr

# L+数字换成打孔的方式。这个方式快捷键设置比较麻烦。 大多板子还是再18层以下。所以只添加到18层。
alias l1 'pop bbdrill;pop swap;subclass top'
alias l2 'pop bbdrill;pop swap;subclass top;+'
alias l3 'pop bbdrill;pop swap;subclass top;+;+'
alias l4 'pop bbdrill;pop swap;subclass top;+;+;+'
alias l5 'pop bbdrill;pop swap;subclass top;+;+;+;+'
alias l6 'pop bbdrill;pop swap;subclass top;+;+;+;+;+'
alias l7 'pop bbdrill;pop swap;subclass top;+;+;+;+;+;+'
alias l8 'pop bbdrill;pop swap;subclass top;+;+;+;+;+;+;+'
alias l9 'pop bbdrill;pop swap;subclass top;+;+;+;+;+;+;+;+'
alias l10 'pop bbdrill;pop swap;subclass top;+;+;+;+;+;+;+;+;+'
alias l11 'pop bbdrill;pop swap;subclass top;+;+;+;+;+;+;+;+;+;+'
alias l12 'pop bbdrill;pop swap;subclass top;+;+;+;+;+;+;+;+;+;+;+'
alias l13 'pop bbdrill;pop swap;subclass top;+;+;+;+;+;+;+;+;+;+;+;+'
alias l14 'pop bbdrill;pop swap;subclass top;+;+;+;+;+;+;+;+;+;+;+;+;+'
alias l15 'pop bbdrill;pop swap;subclass top;+;+;+;+;+;+;+;+;+;+;+;+;+;+'
alias l16 'pop bbdrill;pop swap;subclass top;+;+;+;+;+;+;+;+;+;+;+;+;+;+;+'
alias l17 'pop bbdrill;pop swap;subclass top;+;+;+;+;+;+;+;+;+;+;+;+;+;+;+;+'
alias l18 'pop bbdrill;pop swap;subclass top;+;+;+;+;+;+;+;+;+;+;+;+;+;+;+;+;+'


# 下面这两句句是滚轮上下时界面上下移动，而不是放大缩小
button wheel_up "roam y -$roamInc"
button wheel_down "roam y $roamInc"


# 下面这两句句是 Ctrl+滚轮界面放大缩小
button Cwheel_up "zoom in $buttonfactor"
button Cwheel_down "zoom out $buttonfactor"


# 下面这两句句是shift+滚轮界面左右移动
button Swheel_up      "roam x -$roamInc"
button Swheel_down     "roam x $roamInc"

# 显示和隐藏动态铺铜，保留边框。以及不隐藏静态铺铜。注意只有没更新铜皮时可以使用。
alias po 'settoggle no_shape_fill_dyn_ood;redraw'

# 显示和隐藏铺铜。没有边框
alias spo 'settoggle no_etch_shape_display;redraw'

# 显示和隐藏铺铜 还有边框
alias spd 'settoggle no_shape_fill;redraw'

# 设置原点
alias so chg origin

# 取消跟随上一命令的走线宽度。或者按上一命令的走线宽度。循环输入。
alias ww 'settoggle acon_no_width_override_retain;redraw'

# 快速捕抓线顶端和pin。sv捕捉线顶端，sp捕捉引脚
alias sv "prepopup; pop dyn_option_select 'Snap pick to@:@Segment Vertex'"
alias sp "prepopup; pop dyn_option_select 'Snap pick to@:@Pin'"

# 小写c 复制
funckey c copy

# 空格键打孔
funckey " " "pop bbdrill -cursor"

#  *************************customize--end************************


```