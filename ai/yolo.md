# 图片打标

## labelimg

```bash

conda create -n labelimg python=3.8.5
conda activate labelimg
pip install labelimg

labelImg

# 指定图片目录 跟label文件
labelImg ./labels ./labels/classes.txt

# cudnn
# https://developer.nvidia.com/cudnn

# onnxruntime 环境安装
# https://onnxruntime.ai/docs/execution-providers/CUDA-ExecutionProvider.html#cuda-12x

conda install nvidia::cudnn cuda-version=12


```

# install

```bash


conda create -n y11 python=3.13

# 装好cuda环境再装
pip install ultralytics


```

# 训练

```bash

# 目录

# data/
# ├── images/           # 图像数据总目录
# │   ├── train/        # 训练集图像
# │   ├── val/          # 验证集图像
# └── labels/           # 标签数据总目录
#    ├── train/         # 训练集标签
#    ├── val/           # 验证集标签

# labels 坐标文件格式
0 0.45 0.32 0.12 0.25  # 类别ID 中心x 中心y 宽度 高度 (归一化坐标)
2 0.78 0.61 0.05 0.07

# yaml conf file
# cp ultralytics\ultralytics\cfg\datasets\coco8.yaml
# data.yaml

path: data # root dir
train: images/train
val: images/val

names:
  0: person
  1: bicycle

# model config file
# cp ultralytics/ultralytics/cfg/models/11/yolo11.yaml
# yolo11.yaml

nc: 2 # number of classes
scales: # model compound scaling constants, i.e. 'model=yolo11n.yaml' will call yolo11.yaml with scale 'n'
  # [depth, width, max_channels]
  n: [0.50, 0.25, 1024] # summary: 181 layers, 2624080 parameters, 2624064 gradients, 6.6 GFLOPs
  s: [0.50, 0.50, 1024] # summary: 181 layers, 9458752 parameters, 9458736 gradients, 21.7 GFLOPs
  m: [0.50, 1.00, 512] # summary: 231 layers, 20114688 parameters, 20114672 gradients, 68.5 GFLOPs
  l: [1.00, 1.00, 512] # summary: 357 layers, 25372160 parameters, 25372144 gradients, 87.6 GFLOPs
  x: [1.00, 1.50, 512] # summary: 357 layers, 56966176 parameters, 56966160 gradients, 196.0 GFLOPs

# YOLO11n backbone
backbone:
  # [from, repeats, module, args]
  - [-1, 1, Conv, [64, 3, 2]] # 0-P1/2
  - [-1, 1, Conv, [128, 3, 2]] # 1-P2/4
  - [-1, 2, C3k2, [256, False, 0.25]]
  - [-1, 1, Conv, [256, 3, 2]] # 3-P3/8
  - [-1, 2, C3k2, [512, False, 0.25]]
  - [-1, 1, Conv, [512, 3, 2]] # 5-P4/16
  - [-1, 2, C3k2, [512, True]]
  - [-1, 1, Conv, [1024, 3, 2]] # 7-P5/32
  - [-1, 2, C3k2, [1024, True]]
  - [-1, 1, SPPF, [1024, 5]] # 9
  - [-1, 2, C2PSA, [1024]] # 10

# YOLO11n head
head:
  - [-1, 1, nn.Upsample, [None, 2, "nearest"]]
  - [[-1, 6], 1, Concat, [1]] # cat backbone P4
  - [-1, 2, C3k2, [512, False]] # 13

  - [-1, 1, nn.Upsample, [None, 2, "nearest"]]
  - [[-1, 4], 1, Concat, [1]] # cat backbone P3
  - [-1, 2, C3k2, [256, False]] # 16 (P3/8-small)

  - [-1, 1, Conv, [256, 3, 2]]
  - [[-1, 13], 1, Concat, [1]] # cat head P4
  - [-1, 2, C3k2, [512, False]] # 19 (P4/16-medium)

  - [-1, 1, Conv, [512, 3, 2]]
  - [[-1, 10], 1, Concat, [1]] # cat head P5
  - [-1, 2, C3k2, [1024, True]] # 22 (P5/32-large)

  - [[16, 19, 22], 1, Detect, [nc]] # Detect(P3, P4, P5)


# 从 YAML 配置新建模型并从头训练
yolo detect train data=./data.yaml model=./mahm.yaml epochs=3000 imgsz=640 patience=50


yolo export model=runs/detect/train2/weights/best.pt format=onnx

```
