# MigLayout

[doc](https://www.formdev.com/jformdesigner/doc/layouts/miglayout/)

## Layout Constraints

MigLayout(String layoutConstraints, String colConstraints, String rowConstraints)

```bash

#   layoutConstraints: 逗号分隔的布局约束列表. 
#   可设置:
#       wrap [count]
#           示例: “wrap“ or “wrap 4“
#           详解: 设置自动换行, 添加count数量组件后自动换行, 没有指定count就按列/行约束的数量
#       gap gapx [gapy] or gapx gapx or gapy gapy
#           示例: "gap 5px 10px" or "gap unrel rel" or "gapx 5dlu" or "gapx 10::50" or "gapy 0:rel:null" or "gap 10! 10!"
#           详解: 指定风格中单元格之间的间隙
#       debug [millis]
#           示例: "debug" or "debug 4000"
#           详解: 打开调试绘制, 默认第1000ms绘制一次
#       nogrid
#           示例: "nogrid"
#           详解: 设置为流模式, 不会与其它行列中的组件对齐
#       novisualpadding
#           示例: "novisualpadding"
#           详解: 关闭边界填充?
#       fill or fillx or filly
#           示例: "fill" or "fillx" or "filly"
#           详解: 用于列或行所有可用空间扩充, 要设置了grow才有用
#       ins/insets ["dialog"] or ["panel"] or [top/all [left [bottom [right]]]]
#           示例: "insets dialog" or "ins 0" or "insets 10 n n n" or "insets 10 20 30 40"
#           详解: 指定内容空出间距
#       flowy
#           示例: "flowy"
#           详解: 设置垂直流动, 默认水平
#       al/align alignx [aligny] or aligny/ay aligny or alignx/ax alignx
#           示例: "align 50% 50%" or "aligny top" or "alignx leading" or "align 100px" or "top, left" or "aligny baseline"
#           详解: 设置对齐方式
#       ltr/lefttoright or rtl/righttoleft
#           示例: "ltr" or "lefttoright" or "rtl"
#           详解: 覆盖容器 ComponentOrientation 属性
#       ttb/toptobottom or btt/bottomtotop
#           示例: "ttb" or "toptobottom" or "btt"
#           详解: ??
#       hidemode mode
#           示例: "hidemode 1"
#           详解: 设置隐藏组件布局模式 
#               0 - 默认,跟可见级件一样处理
#               1 - 大小被设置为0,0 
#               2 - 大小被设置为0,0周围间隙也设置为0 
#               3 - 不可见组件不参与布局
#       nocache
#           示例: "nocache"
#           详解: 指定不使用缓存

#   colConstraints / rowConstraints
#   格式: [constraint1, constraint2, ...]gap size[constraint1, constraint2, ...]gap size[...]...
#   示例: "[fill]10[top,10:20]", "[fill]push[]", "[fill]10:10:100:push[top,10:20]"
#   说明: 行/列约束设置[]为一行或间多个约束用","连接,中间是间隔设置, 可用 "|" 使用默认间隔代替 "]["   例如："[100|200|300]"与"[100][200][300]"相同.
#   可设置:
#       sg/sizegroup [name]
#           示例: "sg" or "sg grp1" or "sizegroup props"
#           详解: size组名称
#       fill
#           示例: "fill"
#           详解: 设置组件增长默认 "grow" 方式, 默认设置的是growx, 要设置了grow才有用
#       nogrid
#           示例: "nogrid"
#           详解: 设置为流模式, 不会与其它行列中的组件对齐, "flowx" / 水平流用于行, "flowy" / 垂直流用于列
#       grow [weight]
#           示例: "grow 50" or "grow"
#           详解: 设置增长权重, 默认100, 与其它行/列权重对比值, 会覆盖fill设置
#       growprio priority
#           示例: "growprio 50"
#           详解: 设置增长优先级
#       shrink weight
#           示例: "shrink 50"
#           详解: 收缩权重, 默认100, 与其它行/列权重对比值
#       shp/shrinkprio priority
#           示例: "shrinkprio 50" or "shp 110"
#           详解:  设置收缩优先级
#       al/align align
#           示例: "align 50%" or "align top" or "align leading" or "align 100px" or "top, left" or "align baseline"
#           详解:  设置对齐方式


```

## Component Constraints

Container.add(...) 
Control.setLayoutData(...)

```bash
#   示例: "width 100px!, grid 3 2, wrap"
#   格式: 跟 col / row Constraints 格式一样, 多个用 "," 连接
#   可设置:
#       wrap [gapsize]
#           示例: "wrap" or "wrap 15px" or "wrap push" or "wrap 15:push"
#           详解: 组件间隔, 如果设置了gapsize覆盖前行和下一行
#       newline [gapsize]
#           示例: "newline" or "newline 15px" or "newline push" or "newline 15:push"
#           详解: 换行间隔, 如果设置了gapsize覆盖前行和下一行
#       push [weightx [weighty]] or pushx [weightx] or pushy [weighty]
#           示例: "push" or "pushx 200"
#           详解: 使组件所在的行或列随权重增长而增长？
#       skip [count]
#           示例: "skip" or "skip 3"
#           详解: 跳过count个单元格,路过的在该组件之前处理, count默认为1
#       span [countx [county]] or spany/sy [count] or spanx/sx [count]
#           示例: "span" or "span 4" or "span 2 2" or "spanx" or "spanx 10" or "spanx 2, spany 2"
#           详解: 跨格/合并count个格, count默认是个很大的数
#       split [count]
#           示例: "split" or "split 4"
#           详解: 拆分单元格, count默认无限大
#       cell col row [span x [span y]]
#           示例: "cell 2 2" or "cell 0 1 2 " or "cell 1 1 3 3"
#           详解: 设置组件网格位置, 如果该风格已经存在组件则与其共享单元格
#       flowx or flowy
#           示例: "flowy" or "flowx"
#           详解: 设置单元格流动方向
#       w/width size or h/height size
#           示例: "width 10!" or "width 10" or "h 10:20" or "height pref!" or "w min:100:pref" or "w 100!,h 100!" or "width visual.x2-pref"
#           详解: 设置组件显示默认大小, 大小被指定为BoundSize
#       wmin/wmax x-size or hmin/hmax y-siz
#           示例: "wmin 10" or "hmax pref+100"
#           详解: 设置组件最小/最大, 大小被指定为BoundSize
#       grow [weightx [weighty]] or growx [weightx] or growy [weighty]
#           示例: "grow 50 20" or "growx 50" or "grow" or "growx" or "growy 0"
#           详解: 设置同组中自动增长权重, 默认为0不增长, 也可以使用"grow 0"显示设置为增长
#       growprio/gp prio or growpriox/gpx priox or growprioy/gpy prioy
#           示例: "growprio 50 50" or "gp 110 90" or "gpx 200" or "growprioy 200"
#           详解: 设置增长优先级, 优先级高的先增长到其最大尺寸
#       shrink [weightx [weighty]] or shrinkx [weightx] or shrinky [weighty]
#           示例: "shrink 50" or "shrink 50 40"
#           详解: 设置同组中自动收缩权重, 默认为100不增长, 默认情况下所有组件都能收缩到最小尺寸, 但不能小于
#       shrinkprio/shp priox [prioy] or shrinkpriox/shpx priox or shrinkprioy/shpy prioy
#           示例: "shrinkpriority 50 50 " or "shp 200 200 " or "shpx 110"
#           详解: 设置收缩优先级, 优先级高的先收缩到其最小尺寸
#       sizegroup/sg [name] or sizegroupx/sgx [name] or sizegroupy/sgy [name]
#           示例: "sg" or "sg group1" or "sizegroup props" or "sgx" or "sizegroupy grp1"
#           详解: 设置尺寸组名称, 同组会应用相同大小?
#       egx/endgroupx [name] or egy/endgroupy [name]
#           示例: "eg" or "eg group1" or "endgroup props" or "egx" or "endgroupy grp1"
#           详解: 结束尺寸组共享?
#       gap left [right [top [bottom]]] or gaptop gap or gapleft gap or gapbottom gap or gapright gap or gapbefore gap or gapafter gap
#           示例: "gap 5px 10px 5px 7px" or "gap unrel rel" or "gapx 5dlu" or "gapx 10:20:50:push" or "gapy 0:rel:null" or "gap 10! 10!" or "gapafter push"
#           详解: 设置周围间隙
#       gapx left [right] or gapy top [bottom]
#           示例: "gapx 5px 10px" or "gapy unrel rel"
#           详解: 设置水平/垂直间隙
#       id [groupid.]
#           示例: "id button1" or "id grp1.b1"
#           详解: 设置组件id
#       pos x y [x2 [y2]]
#           示例: "pos 50% 50% n n" or "pos 0.5al 0.5al" or "pos 100px 200px" or "pos n n 200 200"
#           示例: "pos (b1.x+b1.w/2) (b1.y2+rel)" or "pos (visual.x2 - pref) 200" or "pos n b1.y b1.x-rel b1.y2" or "pos 100 100 200 200"
#           详解: 相对容器的绝对坐标, 不会放入到网格单元中
#               - .x or .y      上/左
#               - .x2 or .y2    下/右
#               - .w or .h      宽/高
#               - xpos or .ypos 相对于屏幕的绝对坐标
#       x x or x2 x2 or y y or y2 y2
#           示例: "x button1.x" or "x2 (visual.x2-50)" or "x 100, y 300"
#           详解: 单独设置绝对坐标
#       dock ("north" or "west" or "south" or "east" or "center") or north/west/south/east
#           示例: "dock north" or "north" or "west, gap 5"
#           详解: 悬浮停靠位置
#       pad top/all [left [bottom [right]]]
#           示例: "pad 10 10" or "pad 5 5 -5 -5" or "pad 0 0 1 1"
#           详解: 设置组件填充, "pad -5 -5 5 5"会将组件在所有方向上放大 5 个像素
#       al/align alignx [aligny] or aligny/ay aligny or alignx/ax alignx
#           示例: "align 50% 50%" or "aligny top" or "alignx leading" or "align 100px" or "top, left" or "aligny baseline"
#           详解: 如果单元格大于组件加上空隙, 对齐方式
#       external
#           示例: "external" or "external, id mybutt"
#           详解: 禁止更改组件边界
#       hidemode mode
#           示例: "hidemode 1"
#           详解: 同 Layout Constraints 中
#       tag [name]
#           示例: "tag ok" or "tag help2"
#           详解: 设置标记名称
#               * ok - An OK button.
#               * cancel - A Cancel button.
#               * help - Help button that is normally on the right.
#               * help2 - Help button that on some platforms is placed to the left.
#               * yes - A Yes button.
#               * no - A No button.
#               * apply - An Apply button.
#               * next - A Next or Forward button.
#               * back - A Previous or Back button.
#               * finish - A Finished button.
#               * left - A button that should normally always be placed on the far left.
#               * right - A button that should normally always be placed on the far right.
#               * ther - An uncategorized button.

```

## UnitValue

* "" - 默认
* px - 像素 E.g. "10px" or "10"
* %  - 百分比 E.g. "100%"
* lp - 逻辑像素 普通字体1:1映射, 较大字体比例变大? E.g. "10lp"
* pt - Points 打印常用格式? E.g. "10pt"
* mm - 毫米 E.g. "10mm"
* cm - 厘米 E.g. "10cm"
* in - 英寸 E.g. "10in"
* sp - 相对于屏幕显示百分比 E.g. "sp 70" or "sp 73.627123"
* al - 边界对齐 "0al" 左对齐 "0.5al" 居中 "1al" 右对齐 E.g. "0.2al"
* n/null - 空值 E.g. "n" or "null"

PlatformConverter 

* r/rel/related
* u/unrel/unrelated
* p/para/paragraph
* i/ind/indent

component sizes

* min/minimum
* p/pref/preferred
* max/maximum

## BoundSize

format: "min:preferred:max"

push ?
E.g. "gap rel:push", "[][]push[][]", "10cm!:push" or "10:10:10:push"

