# vim:et sts=2 sw=2 ft=zsh

typeset -g VIRTUAL_ENV_DISABLE_PROMPT=1

setopt nopromptbang prompt{cr,percent,sp,subst}

# Depends on git-info module to show git information
typeset -gA git_info
if (( ${+functions[git-info]} )); then
  zstyle ':zim:git-info' verbose yes
  zstyle ':zim:git-info:branch' format '%b'
  zstyle ':zim:git-info:commit' format '%c'
  zstyle ':zim:git-info:action' format '(%F{green}%s%f)'
  zstyle ':zim:git-info:unindexed' format '%F{yellow}●'
  zstyle ':zim:git-info:indexed' format '%F{green}●'
  zstyle ':zim:git-info:untracked' format '%F{red}●'
  zstyle ':zim:git-info:keys' format \
      'prompt' ' (%F{magenta}%b%c%I%i%u%f%S%f)%s'

  autoload -Uz add-zsh-hook && add-zsh-hook precmd git-info
fi

PS1='%(2L.%B%F{yellow}(%L)%f%b .)%B%F{cyan}%~%f%b${(e)git_info[prompt]} %B%(1j.%F{blue}*%f .)%F{green}%#%f%b '
unset RPS1