alias c=clear -x
alias ls='ls -G'
alias ll='ls -lhG --time-style=long-iso'
alias l='ls -alhG --time-style=long-iso'


alias msb='meson setup build'
alias nb='ninja -C build'
alias rmb='rm -rf build*'
alias rmt='rm -rf target*'

alias ta='tmux a'

alias du='sudo du -h --max-depth=1'
alias dud='sudo du -h --max-depth='


alias dr='docker run -v $PWD/:/app --user="$(id -u)"'
alias drt='docker run -v $PWD/:/app --user="$(id -u)" -ti'
alias drtp='docker run -v $PWD/:/app --user="$(id -u)" -e NPXY="socks5://172.17.0.1:11028" -ti'
alias drr='docker run -v $PWD/:/app --user=0'
alias drrt='docker run -v $PWD/:/app --user=0 -ti'
alias drrtp='docker run -v $PWD/:/app --user=0 -e NPXY="socks5://172.17.0.1:11028" -ti'