# 工作台

- 紧固件工作台 [Fasteners](https://wiki.freecadweb.org/Fasteners_Workbench)
- 装配工作台 [A2Plus](https://github.com/kbwbe/A2plus)

```bash
# 数据目录
# ~/.local/share/FreeCAD/
# 配置目录
# ~/.config/FreeCAD/

# 去掉默认单例启动  删除 --single-instance
sudo nano /usr/share/applications/org.freecadweb.FreeCAD.desktop

```

# 技巧

## 修改step

```bash

# 1.打开step
# 2.新建实体
# 3.把打开的step拖入到新建的实体

```

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
# 关闭 freecad 编辑 ~/.config/FreeCAD/user.cfg
# 找到 FCParamGroup 名字是 Shortcut
# 把其中的 Shift + ~ 改成 ~

# 添加快捷键 ! 绘制样式在 线框与带边着色间切换
# 先添加个Command 我这就添加到 part design 工作台中


# nano /usr/lib/freecad/Mod/AddonManager/ToggleDisplayMode.py

# -*- coding: utf-8 -*-

import FreeCAD
import FreeCADGui as Gui
from PySide.QtCore import QT_TRANSLATE_NOOP

class _ToggleDisplayMode:
    """Explanation of the command."""

    def GetResources(self):
        return {'Pixmap': 'Arch_Subcomponent',
                'Accel': "!",
                'MenuText': 'Toggle DisplayMode', 
                'ToolTip': 'Toggle DisplayMode'}

    def Activated(self):
        state = Gui.ActiveDocument.ActiveObject
        if state.DisplayMode == "Flat Lines":
            state.DisplayMode= "Wireframe"
            Gui.runCommand('Std_DrawStyle',6)
        else:
            state.DisplayMode = "Flat Lines"
            Gui.runCommand('Std_DrawStyle',2)

    def IsActive(self):
        if Gui.ActiveDocument:
            return True
        else:
            return False

if FreeCAD.GuiUp:
    Gui.addCommand('ToggleDisplayMode', _ToggleDisplayMode())

# nano /usr/lib/freecad/Mod/AddonManager/InitGui.py

# 添加
import ToggleDisplayMode

# ***注意*** 必需在: Tools -> Customize -> ToolBars 里面添加命令到工具栏，才可以用快捷键执行, 宏命令也是如此

# 手动运行
Gui.runCommand('ToggleDisplayMode')


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