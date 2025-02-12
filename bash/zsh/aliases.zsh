alias c=clear -x
alias ls='ls -G'
alias ll='ls -lhG --time-style=long-iso'
alias l='lsd -lah --date "+%y-%m-%d %H:%M"'


alias msb='meson setup build'
alias nb='ninja -C build'
alias rmb='rm -rf build*'
alias rmt='rm -rf target*'

alias ta='tmux a'

# du
alias du='sudo du -h --max-depth=1'
alias dud='sudo du -h --max-depth='

# docker
alias dr='docker run -v $PWD/:/project --user="$(id -u)"'
alias drt='docker run -v $PWD/:/project --user="$(id -u)" -ti'
alias drtp='docker run -v $PWD/:/project --user="$(id -u)" -e NPXY="socks5://172.17.0.1:11028" -ti'
alias drr='docker run -v $PWD/:/project --user=0'
alias drrt='docker run -v $PWD/:/project --user=0 -ti'
alias drrtp='docker run -v $PWD/:/project --user=0 -e NPXY="socks5://172.17.0.1:11028" -ti'

# proxy
pi () {
    echo "http_proxy:${http_proxy}"
    echo "https_proxy:${https_proxy}"
    echo "ftp_proxy:${ftp_proxy}"
    echo "rsync_proxy:${rsync_proxy}"
    echo "all_proxy:${all_proxy}"
}
alias pc='export {http,https,ftp,rsync,all}_proxy='
alias pst='export {http,https,ftp,rsync,all}_proxy=http://127.0.0.1:11018'
alias pss='export {http,https,ftp,rsync,all}_proxy=socks5://172.17.0.1:11028'

# flutter
fcp () {
    flutter create $1 --platforms=$2
}
fcpp () {
    flutter create $1 --platforms=$2 --project-name=$3
}
fecp () {
    flutter create --platforms=$1 $2
}
fecpp () {
    flutter create --platforms=$1 $2 --project-name=$3
}
alias fcl='flutter clean'
alias fbl='flutter build linux'
alias frl='flutter run -d linux'
alias fpg='flutter pub get'


# cmake
alias cmdb='cmake -DCMAKE_BUILD_TYPE=Debug -S ./ -B ./build'
alias cmrb='cmake -DCMAKE_BUILD_TYPE=Release -S ./ -B ./build'
alias cmb='cmake --build ./build'

alias cbga='cross build --target  arm-unknown-linux-gnueabihf --release'

alias phs='python -m http.server'

# esp32-idf
alias get_idf='. /optd/opt/esp/esp-idf/export.sh'
alias idf='idf.py'


alias phs='python -m http.server'
alias qls='sudo systemctl start libvirtd && sudo systemctl start spice-vdagentd'

alias qcb='cd ../ && rm -rf build && rm -rf build.ninja'
alias qgb='mkdir build && cd build && cmake ../'
alias qgbn='mkdir build.ninja && cd build.ninja && cmake ../ -G Ninja'