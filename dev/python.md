# 安装

```bash

# https://www.python.org/downloads/windows/
# 对win7的支持只到 python3.8

# install pip
# down https://bootstrap.pypa.io/get-pip.py
# python get-pip.py

# 源
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# 源码方式安装库
pip install -e .

```

# 常用

```py
# 16进制字符 to 10进制
parseInt("0x498f8", 16)

# 10进制 to 16进制字符
"{:x}".format(38782)

```

# miniconda

```bash
# https://docs.conda.io/projects/miniconda/en/latest/

# install

mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

~/miniconda3/bin/conda init zsh

source ~/.zshrc

# 安装列表
conda list

# 环境列表
conda env list
# 新建环境
conda create -n y8 python=3.8
# 激活环境
conda activate y8
conda deactivate
# 删除环境
conda-env remove -n y8

```

# pytorch

```bash

# prev version
# https://pytorch.org/get-started/previous-versions/

# amd
pip install torch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0 --index-url https://download.pytorch.org/whl/rocm5.6

# last version
# https://pytorch.org/get-started/locally/
# amd

pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm5.6


import torch
x = torch.rand(5, 3)
print(x)

# cuda available??
import torch
torch.cuda.is_available()


```