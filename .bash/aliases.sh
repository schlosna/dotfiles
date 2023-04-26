#!/bin/bash

. "${HOME}/.bash/common.bash"

__log_debug "Begin reading ${HOME}/.bash/aliases.sh"

alias a="rg -i "
alias ak="ack "
alias akc="ack "
alias cls="clear "
alias dev="docker-compose "
alias du="du -csh "
alias e="gvim "
alias g="git "
alias givm="gvim "
alias host="host -a "
alias ln="ln -s "
alias pstree="pstree -w "
alias tmux="tmux -u"

complete -o bashdefault -o default -o nospace -F __git_wrap__git_main g 2>/dev/null \
    || complete -o default -o nospace -F __git_wrap__git_main g

__log_debug "Finished reading $HOME/.bash/aliases.sh"
