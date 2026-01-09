```bash


unar buildroot/dl/gcc-linaro.tar.bz2 -o /opt

export PATH=$PATH:/opt/gcc-linaro/bin

rm /opt/gcc-linaro/bin/arm-linux-gnueabi-ar
ln -s /opt/gcc-linaro/arm-linux-gnueabi/bin/ar /opt/gcc-linaro/bin/arm-linux-gnueabi-ar

rm /opt/gcc-linaro/bin/arm-linux-gnueabi-objdump
ln -s /opt/gcc-linaro/arm-linux-gnueabi/bin/objdump /opt/gcc-linaro/bin/arm-linux-gnueabi-objdump

rm /opt/gcc-linaro/bin/arm-linux-gnueabi-objcopy
ln -s /opt/gcc-linaro/arm-linux-gnueabi/bin/objcopy /opt/gcc-linaro/bin/arm-linux-gnueabi-objcopy

rm /opt/gcc-linaro/bin/arm-linux-gnueabi-strip
ln -s /opt/gcc-linaro/arm-linux-gnueabi/bin/strip /opt/gcc-linaro/bin/arm-linux-gnueabi-strip

rm /opt/gcc-linaro/bin/arm-linux-gnueabi-ld
ln -s /opt/gcc-linaro/arm-linux-gnueabi/bin/ld /opt/gcc-linaro/bin/arm-linux-gnueabi-ld

rm /opt/gcc-linaro/bin/arm-linux-gnueabi-nm
ln -s /opt/gcc-linaro/arm-linux-gnueabi/bin/nm /opt/gcc-linaro/bin/arm-linux-gnueabi-nm


apt install u-boot-tools

cd /project/lichee/linux-3.4
./scripts/build_tiger-cdr.sh




```
