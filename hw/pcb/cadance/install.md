
# Linux

```bash

# https://archive.org/download/CSPB174LNX

# 解压IScape运行安装向导
tar -zxvf IScape04.23-s021lnx86.t.Z
bin/iscape.sh

# libnativemethods_lnx_64.so 安全提醒
sudo execstack -c ~lib/libnativemethods_lnx_64.so


#env
export CDS_INST_DIR=/ufs/opt/SPB2210
export CDS_LIC_FILE=~/Downloads/cadence.lic
export CDS_DIR=$CDS_INST_DIR
export CONCEPT_INST_DIR=$CDS_DIR
export CDS_SITE=$CDS_DIR/share/local/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATHCONCEPT_INST_DIR/tools/lib:$CDS_DIR/tools/lib64:$CDS_DIR/tools/mainwin520/mw/lib-linux_optimized/:$CDS_DIR/tools/lib/64bit/RHEL/RHEL7/
export CDSDOC_PROJECT=/CDS_INST_DIR/doc
export PATH=$PATH:$CDS_INST_DIR/tools/jre/bin:$CONCEPT_INST_DIR/tools/bin:$CONCEPT_INST_DIR/tools/pcb/bin:$CONCEPT_INST_DIR/tools/fet/bin


```

# win

```bash
# 中文环境变量
intl_enabled=1

```