FROM ubuntu:22.04

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN apt update
RUN apt upgrade -y
RUN apt install -y iputils-ping vim git wget xz-utils bzip2 gcc g++ cpio unzip rsync device-tree-compiler bison flex file nano
RUN apt install -y python3 python2 time make bc libncurses5-dev libncursesw5-dev libssl-dev mtd-utils
RUN ln -sf /usr/bin/python2 /usr/bin/python

RUN wget https://releases.linaro.org/components/toolchain/binaries/7.5-2019.12/arm-linux-gnueabihf/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf.tar.xz
RUN tar -xvf gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf.tar.xz
RUN mv gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf /opt/

ENV PATH="$PATH:/opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin"

RUN mkdir /project
WORKDIR /project

# Clean up
RUN apt-get -y clean