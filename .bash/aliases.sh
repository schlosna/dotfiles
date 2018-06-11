#!/bin/bash

__log_debug "Begin reading ${HOME}/.bash/aliases.sh"

alias a="rg -i "
alias ak="ack "
alias akc="ack "
alias cls="clear "
alias dev="docker-compose "
alias du="du -csh "
alias e="gvim "
alias g="git "
alias gd="git diff "
alias gdt="git difftool "
alias gds="git diff --staged "
alias gdts="git difftool --staged "
alias givm="gvim "
alias gw="gw --info --parallel "
alias host="host -a "
alias irb='irb --readline -r irb/completion'
alias lc="lunchy "
alias ln="ln -s "
alias pstree="pstree -w "

complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
    || complete -o default -o nospace -F _git g

__log_debug "Finished reading $HOME/.bash/aliases.sh"
