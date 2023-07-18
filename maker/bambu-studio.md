```bash
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