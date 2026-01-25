local VMPATH=/home/vm/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/zig-x86_64-linux-0.15.2
local RSBPROXY=https://192.168.1.8:8808

rsb() {
    docker run -v $PWD/:/zfs -v ~/.dcargo:/home/vm/.cargo --user="$(id -u)" -e PATH=$VMPATH -e https_proxy=$RSBPROXY  -ti rsb cargo build $*
}

rsbm() {
    docker run -v $PWD/:/zfs -v ~/.dcargo:/home/vm/.cargo --user="$(id -u)" -e PATH=$VMPATH -e https_proxy=$RSBPROXY -ti rsb cargo zigbuild --target arm-unknown-linux-gnueabihf.2.23 $*
}

rsbw() {
    docker run -v $PWD/:/zfs -v ~/.dcargo:/home/vm/.cargo --user="$(id -u)" -e PATH=$VMPATH -e https_proxy=$RSBPROXY -ti rsb cargo zigbuild --target x86_64-pc-windows-gnu $*
}


rsbw86() {
    docker run -v $PWD/:/zfs -v ~/.dcargo:/home/vm/.cargo --user="$(id -u)" -e PATH=$VMPATH -e https_proxy=$RSBPROXY -ti rsb cargo zigbuild --target i686-pc-windows-gnu $*
}

rsbpc() {
    RSBPROXY=
}

rsbps() {
    RSBPROXY=https://10.8.8.227:11029
}

dclean() {
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
}
