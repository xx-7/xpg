

alias gita='git add .'
alias gitc='git commit -m'
alias gitp='git push origin'

gam () {
    git add .
    git commit -m "$1"
    git push origin master
}