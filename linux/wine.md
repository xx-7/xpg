
# 64位

```bash

#************* 真垃圾，各种不稳定
WINEARCH=win64 WINEPREFIX=/ufs/wine/w64 winecfg

WINEPREFIX=/ufs/wine/w64 winetricks

WINEPREFIX=/ufs/wine/w64 wineserver -k

WINEPREFIX=/ufs/wine/w64 wine "d:/SiemensEDA/PADSVX.2.15/SDD_HOME/common/win32/bin/powerlogic.exe"
WINEPREFIX=/ufs/wine/w64 wine "d:/SiemensEDALicensePatcher.exe"


```

# x86

```bash

WINEARCH=win32 WINEPREFIX=/ufs/wine/x86 winecfg
WINEPREFIX=/ufs/wine/x86 wine "d:/PADSVX.2.15_ESDM/setup.exe"




```