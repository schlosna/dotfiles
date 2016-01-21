#!/bin/bash

[ -n "${DEBUG}" ] && echo begin reading ${HOME}/.bash/aliases.sh

alias a="ag -i "
alias ak="ack "
alias akc="ack "
alias cls="clear "
alias dm="docker-machine "
alias du="du -csh "
alias e="gvim "
alias g="git "
alias gd="git diff "
alias gdt="git difftool "
alias gds="git diff --staged "
alias gdts="git difftool --staged "
alias givm="gvim "
#alias gw="./gradlew --info "
alias gw="gw --info "
alias gradle="gw "
alias host="host -a "
alias irb='irb --readline -r irb/completion'
alias lc="lunchy "
alias ln="ln -s "
alias pstree="pstree -w "
#alias vi="gvim "
#alias vim="gvim "

complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
	|| complete -o default -o nospace -F _git g

[ -n "${DEBUG}" ] && echo finished reading $HOME/.bash/aliases.sh
