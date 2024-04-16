# OrcaSlicer

```bash
# https://github.com/SoftFever/OrcaSlicer

docker build -t orca -f ./orca/Dockerfile .


docker run -v $PWD/:/OrcaSlicer -ti orca /bin/bash

./BuildLinux.sh -u

mkdir -p /optd/opt/OrcaSlicer_deps
mkdir -p /optd/opt/OrcaSlicer

cd /OrcaSlicer/deps
mkdir build;cd build
cmake ../ -DDESTDIR="/optd/opt/OrcaSlicer_deps" -DCMAKE_BUILD_TYPE=Release -DDEP_WX_GTK3=1
make -j6



cd /OrcaSlicer/
mkdir build;cd build

cmake ../ -DSLIC3R_STATIC=ON -DSLIC3R_GTK=3 -DBBL_RELEASE_TO_PUBLIC=1 -DCMAKE_PREFIX_PATH="/optd/opt/OrcaSlicer_deps/usr/local" -DCMAKE_INSTALL_PREFIX="/optd/opt/OrcaSlicer" -DCMAKE_BUILD_TYPE=Release
cmake --build ./ --target install --config Release -j6


mkdir /OrcaSlicer/dist

cp -r /optd/opt/OrcaSlicer /OrcaSlicer/dist/OrcaSlicer

```


```Dockerfile

FROM ubuntu:22.04

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN apt-get update && \
    echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Add a deb-src
RUN echo deb-src http://archive.ubuntu.com/ubuntu \
    $(cat /etc/*release | grep VERSION_CODENAME | cut -d= -f2) main universe>> /etc/apt/sources.list 

RUN apt-get update && apt-get install  -y \
    autoconf \
    build-essential \
    cmake \
    curl \
    eglexternalplatform-dev \
    extra-cmake-modules \
    file \
    git \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-libav \
    libcairo2-dev \
    libcurl4-openssl-dev \
    libdbus-1-dev \
    libglew-dev \ 
    libglu1-mesa-dev \
    libglu1-mesa-dev \
    libgstreamer1.0-dev \
    libgstreamerd-3-dev \ 
    libgstreamer-plugins-base1.0-dev \
    libgstreamer-plugins-good1.0-dev \
    libgtk-3-dev \
    libgtk-3-dev \
    libosmesa6-dev \
    libsecret-1-dev \
    libsoup2.4-dev \
    libssl3 \
    libssl-dev \
    libudev-dev \
    libwayland-dev \
    libwebkit2gtk-4.0-dev \
    libxkbcommon-dev \
    locales \
    locales-all \
    m4 \
    pkgconf \
    sudo \
    wayland-protocols \
    wget \
    libcgal-dev

ENV LC_ALL=en_US.utf8
RUN locale-gen $LC_ALL

ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

RUN mkdir /OrcaSlicer
WORKDIR /OrcaSlicer

# Clean up
RUN apt-get -y clean

```