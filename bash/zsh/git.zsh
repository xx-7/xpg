

alias gita='git add .'
alias gitc='git commit -m'
alias gitp='git push origin'

alias gitcl='git config --list'
alias gitpc='git config --global --unset http.proxy && git config --global --unset https.proxy'
alias gitps='git config --global http.proxy "socks5://127.0.0.1:11019" && git config --global https.proxy "socks5://127.0.0.1:11019"'

gam () {
    git add .
    git commit -m "$1"
    git push origin master
}