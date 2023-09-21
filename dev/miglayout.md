# MigLayout

[dc1](https://www.formdev.com/jformdesigner/doc/layouts/miglayout/)

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
#           详解: 用于列或行所有可用空间扩充
#       ins/insets ["dialog"] or ["panel"] or [top/all [left [bottom [right]]]]
#           示例: "insets dialog" or "ins 0" or "insets 10 n n n" or "insets 10 20 30 40"
#           详解: 指定内容空出间距, 类似css padding
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
#           详解: 设置组件默认 "grow" 方式, 默认设置的是growx
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

```