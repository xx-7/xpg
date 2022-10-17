# 工作台

- 紧固件工作台 [Fasteners](https://wiki.freecadweb.org/Fasteners_Workbench)
- 装配工作台 [A2Plus](https://github.com/kbwbe/A2plus)

# 设置

## 快捷键

```bash
# 导航
# https://wiki.freecadweb.org/Mouse_navigation/zh
# 编辑 → 首选项 → 显示 → 3D视图 → 3D导航 改成Blender 
# 右下角点击也可更改

# 自定义\修改快捷键
# https://wiki.freecadweb.org/Interface_Customization/zh-cn
# Tools → Customize -> Keyboard

# 将 适合所有 从默认的 V,F 改成`   V在草模式会有被占用无法执行V,F
# 将 等轴测 从 0 改成 ~


# 注意FreeCAD无法设置Shift + 的键, 比如一按 shift + ` 就会变成 Shift + ~ 而实际这个键无法被唤起
# 按下 Shift + ` 会查找 shift + ` 或 ~ 的绑定无法找到 Shift + ~
# 关闭 freecad 编辑 ~/.config/FreeCAD/user.conf
# 找到 FCParamGroup 名字是 Shortcut
# 把其中的 Shift + ~ 改成 ~


```

# 注意

- Part/PartDesign常规中的模型设置,不选中不会自动合并,选中后挖槽圆角容易出莫名bug
- 有时挖槽时要设置锥度,否则挖不出来

# 插件管理

```bash

# 插件列表
# https://wiki.freecadweb.org/External_workbenches

# 插件安装目录
# ~/.local/share/FreeCAD/Mod/

# 加载插件时会访问: https://raw.githubusercontent.com/FreeCAD/FreeCAD-addons/master/addonflags.json
# 或网络通畅
# 或clone下来 修改:/usr/lib/freecad/Mod/AddonManager/addonmanager_workers.py中访问地址

```