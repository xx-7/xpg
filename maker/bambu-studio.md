# 使用技巧

- 填充
    - 推荐使用: 三角形/螺旋体/蜂窝
    - 螺旋体强度是最好的
    - 实心只有直线填充, 一般不推荐超过80, 结构连接处可以改成100, 硬度会达到最高
    - 对象/添加修改器, 可以添加特殊位置填充
- 支撑
    - 平面普通支撑, 曲面树状支撑
    - 筏值角度, 悬垂角度低于, 打印支撑
    - 筏层, 相当于加基座, 降低打印难度, 底部不是平面很好用
    - 可以手动绘制支撑
- 流量调节
    - 粗调上下范围调, 细调只向下调
    - 不知道调, 先把流量改成1粗调, 再细调
    - 要用OrcaSlicer
- K值压力提前
    - 先校准流量调节
    - 要用OrcaSlicer
- 可变打印层高
    - 不同的高度设置不同的打印层高
    - 打印层高调小速度会变慢
- 接缝/C缝
    - 打印一圈停顿时产生, 无法避免
    - 一般是对齐
    - 可手动设置位置, 左键设置Z缝, 右键屏避位置
- 指定层暂停
    - 可用来打印多色
- 逐件打印
    - 其它/特殊模式/打印顺序
    - 防止一锅全糊, 单件为了防撞需占更多空间, 打印时间也会变长
- LAC喷雾
- 擦嘴线
    - 在打印机起始g-code中删除noozle line注释线段
- 风扇
    - 可以在耗材丝-高级-起始G-code里改 M106后面数值256为最大 都改成125即可P几对应的哪个风扇

# 编译安装

## BambuStudio

```bash

# https://github.com/bambulab/BambuStudio
# https://github.com/bambulab/BambuStudio/wiki/Linux-Compile-Guide

mkdir /optd/opt/BambuStudio_dep

cd BambuStudio/deps
mkdir build;cd build

cmake ../ -DDESTDIR="/optd/opt/BambuStudio_dep" -DCMAKE_BUILD_TYPE=Release -DDEP_WX_GTK3=1
make -j6


cd BambuStudio
mkdir /optd/opt/BambuStudio
mkdir build;cd build

cmake ../ -DSLIC3R_STATIC=ON -DSLIC3R_GTK=3 -DBBL_RELEASE_TO_PUBLIC=1 -DCMAKE_PREFIX_PATH="/optd/opt/BambuStudio_dep/usr/local" -DCMAKE_INSTALL_PREFIX="/optd/opt/BambuStudio" -DCMAKE_BUILD_TYPE=Release
cmake --build ./ --target install --config Release -j6
```

## OrcaSlicer

```bash
# https://github.com/SoftFever/OrcaSlicer

mkdir /optd/opt/OrcaSlicer
mkdir build;cd build

cmake ../ -DSLIC3R_STATIC=ON -DSLIC3R_GTK=3 -DBBL_RELEASE_TO_PUBLIC=1 -DCMAKE_PREFIX_PATH="/optd/opt/BambuStudio_dep/usr/local" -DCMAKE_INSTALL_PREFIX="/optd/opt/OrcaSlicer" -DCMAKE_BUILD_TYPE=Release
cmake --build ./ --target install --config Release -j6

```