
function git_current_branch() {
  local ref
  ref=$(git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

gam () {
    git add .
    git commit -m "$1"
    git push origin $(git_current_branch)
}

alias gita='git add .'
alias gitc='git commit -m'
alias gitp='git push origin'

alias gitcl='git config --list'
alias gitpc='git config --global --unset http.proxy && git config --global --unset https.proxy'
alias gitps='git config --global http.proxy "socks5://127.0.0.1:11019" && git config --global https.proxy "socks5://127.0.0.1:11019"'
alias gitfr='git fetch origin && git reset --hard origin $(git_current_branch)'