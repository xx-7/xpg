# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

ZSH_AUTOSUGGEST_MANUAL_REBIND=1

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Initialize modules.
source ${ZIM_HOME}/init.zsh

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key

DISABLE_AUTO_TITLE="true"

precmd () { echo -en "\033]0; `basename $PWD` \007"}

source ~/.config/zsh/env.zsh
source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/git.zsh
