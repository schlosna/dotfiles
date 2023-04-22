#!/bin/bash

. "${HOME}/.bash/common.bash"

__log_debug "Begin reading ${HOME}/.bash/environment.sh"

####################
# directory colors
####################
DIRCOLORS_INPUT=${HOME}/.bash/dircolors-solarized/dircolors.256dark
if type -P gdircolors &>/dev/null; then
    eval $(gdircolors -b ${DIRCOLORS_INPUT})
elif type -P dircolors &>/dev/null; then
    eval $(dircolors -b ${DIRCOLORS_INPUT})
fi

# ^l clear screen
bind -m vi-insert "\C-l":clear-screen

# ^p check for partial match in history
#bind -m vi-insert "\C-p":dynamic-complete-history

# ^n cycle through the list of partial matches
#bind -m vi-insert "\C-n":menu-complete


if [ -n "${BREW_HOME}" ]; then
    __log_debug "Already set BREW_HOME=${BREW_HOME}"
else
    if type -P brew &>/dev/null; then
        BREW_HOME=$(brew --prefix)
        __log_debug "Set BREW_HOME=${BREW_HOME}"
    fi
fi

if [ -n "${BREW_HOME}" ]; then
### BASH Completion for homebrew
    import "${BREW_HOME}/etc/profile.d/bash_completion.sh"
    import "${BREW_HOME}/Library/Contributions/brew_bash_completion.sh"
    if [ "${BASH_VERSINFO}" -gt 3 ]; then
        # bash-completion2 for bash 4.0+
        import "${BREW_HOME}/share/bash-completion/bash_completion"
    else
        # Bash 3.x compatible
        import "${BREW_HOME}/etc/bash_completion"
    fi

    # http://wiki.github.com/joelthelion/autojump
    import "${BREW_HOME}/etc/autojump.sh"
    import "${BREW_HOME}/etc/profile.d/autojump.sh"
    import "${BREW_HOME}/opt/bash-git-prompt/share/gitprompt.sh"

    for i in ${BREW_HOME}/etc/bash_completion.d/*; do
        import "$i"
    done

    if type -P insta &>/dev/null && [ -f "${BREW_HOME}/Library/Taps/palantir/homebrew-insta/autocomplete/bash_autocomplete" ]; then
        PROG=insta source "${BREW_HOME}/Library/Taps/palantir/homebrew-insta/autocomplete/bash_autocomplete"
    fi

    if type -P brew-cask &>/dev/null; then
        alias cask="brew-cask "
        complete -o bashdefault -o default -F _brew_cask cask
    fi
    import "${HOME}/.bash/tokens.bash"

    export NVM_DIR="$HOME/.nvm"
    if [ -s "${BREW_HOME}/opt/nvm/nvm.sh" ] && [ -d "${NVM_DIR}" ]; then
        import "${BREW_HOME}/opt/nvm/nvm.sh"
        import "${BREW_HOME}/opt/nvm/etc/bash_completion.d/nvm"
    fi
fi

### BASH Completion from MacPorts
import "/opt/local/etc/bash_completion"

# iterm2 shell integration
export iterm2_hostname="$(hostname -f)"
import "${HOME}/.bash/iterm2_shell_integration.bash" || import "${HOME}/.iterm2_shell_integration.bash"

export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
import "${HOME}/.bash/.fzf.bash"

if type -P jenv &>/dev/null; then
    eval "$(jenv init - --no-rehash)";
    export JAVA_HOME=$(jenv javahome);
fi

if type -P rbenv &>/dev/null; then
    eval "$(rbenv init -)";
fi

import "${HOME}/.gvm/scripts/gvm"
import "${HOME}/.bash/cloud.bash"

CURL_CA_BUNDLE="/etc/pki/tls/certs/ca-bundle.crt"
[ -f "${CURL_CA_BUNDLE}" ] && export CURL_CA_BUNDLE || unset CURL_CA_BUNDLE

####################
# Paths
####################
shopt -s cdspell
shopt -s dotglob
shopt -s extglob
shopt -s progcomp
shopt -s nocaseglob

if [ "${BASH_VERSINFO}" -gt 3 ]; then
    shopt -s autocd
    shopt -s globstar
    shopt -s dirspell
fi

[ -d "/Volumes/git" ] && export DEVELOPMENT_DIR="/Volumes/git" || export DEVELOPMENT_DIR="$HOME"
export CDPATH=".:~:${DEVELOPMENT_DIR}:${HOME}/Documents:/Volumes"
export FIGNORE=\~:.bak:.o

####################
# Shell
####################
export DISPLAY=:0.0
export EDITOR="vim -f"
export VISUAL="vim -f"
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
export LANG=en_US.UTF-8
export LC_ALL=C

# Mail
export MAIL=/var/mail/$USER
MAILPATH=/var/spool/mail/$USER
for i in ${HOME}/Mail/[^.]*
do
    MAILPATH=$MAILPATH:$i'?You have new mail in your ${_##*/} folder'
done
unset i
export MAILPATH

export PAGER=less
export MORE='-cs'
export LESS='-c -d -i -M -q -R -s -w'
export BLOCKSIZE=K
#export DYLD_NO_FIX_PREBINDING=true

####################
# Compiling
####################
#export MAKEFLAGS='-j3'

if [ -d "${BREW_HOME}/opt/readline/lib" ]; then
    export LDFLAGS="-L${BREW_HOME}/opt/readline/lib ${LDFLAGS}"
fi
if [ -d "${BREW_HOME}/opt/readline/include" ]; then
    export CPPFLAGS="-I${BREW_HOME}/opt/readline/include ${CPPFLAGS}"
fi

if type -P go &>/dev/null; then
    SRC_HOME="/Volumes/git"
    if [ ! -d "${SRC_HOME}" ]; then
        SRC_HOME="${HOME}/dev"
    fi
    GOPATH="${SRC_HOME}/go"
    if [ ! -d "${GOPATH}" ]; then
        GOPATH="$(go env GOPATH)"
    fi
    mkdir -p "${GOPATH}"
    export GOPATH
    export PATH="${PATH}:${GOPATH}/bin"
fi

####################
# Screen
####################
if [ "$TERM" = "screen" -a ! "$SHOWED_SCREEN_MESSAGE" = "true" ]; then
    detached_screens=$(screen -list | grep Detached)
    if [ ! -z "$detached_screens" ]; then
        echo "+---------------------------------------+"
        echo "| Detached screens are available:       |"
        echo "$detached_screens"
        echo "+---------------------------------------+"
        #        else
        # echo "[ screen is activated ]"
    fi
    export SHOWED_SCREEN_MESSAGE="true"
fi


# From http://pastebin.com/m64be26a5 via http://reddit.com/info/697cu/comments/
# Set the terminal type.
case $TERM in
  xterm*|putty|Eterm)
    case $(uname) in
      FreeBSD)
        TERM=xterm-color
        ;;
      SunOS|Linux)
        TERM=xterm
        ;;
    esac
    ;;
  linux|cons*|vt*)
    case $(uname) in
      FreeBSD)
        TERM=console
        ;;
      SunOS)
        TERM=vt100
        ;;
      Linux)
        TERM=linux
        ;;
    esac
    ;;
esac
export TERM

####################
#  prompt
####################

SIMPLE_PROMPT="[\u@\h] \w \$"
PROMPT_COLOR_ENABLED="true"


function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /';
}

function elite
{
    local GRAY="\001\033[1;30m\002"
    local LIGHT_GRAY="\001\033[0;37m\002"
    local CYAN="\001\033[0;36m\002"
    local LIGHT_CYAN="\001\033[1;36m\002"
    local NO_COLOUR="\001\033[0m\002"

    case $TERM in
        xterm*|rxvt*)
            #local TITLEBAR='\001\033]0;\u@\h:\w\007\002'
            local TITLEBAR='\001\033]0;\W\007\002'
            ;;
        *)
            local TITLEBAR=""
            ;;
    esac

    local temp=$(tty)
    local GRAD1=${temp:5}
    PS1="$TITLEBAR\
        $GRAY-$CYAN-$LIGHT_CYAN(\
        $CYAN\u$GRAY@$CYAN\h\
        $LIGHT_CYAN)$CYAN-$LIGHT_CYAN(\
        $CYAN\#$GRAY/$CYAN$GRAD1\
        $LIGHT_CYAN)$CYAN-$LIGHT_CYAN(\
        $CYAN\$(date +%H%M)$GRAY/$CYAN\$(date +%d-%b-%y)\
        $LIGHT_CYAN)$CYAN-$GRAY-\
        $LIGHT_GRAY\n\
        $GRAY-$CYAN-$LIGHT_CYAN(\
        $CYAN\$$GRAY:$CYAN\w\
        $LIGHT_CYAN)$CYAN-$GRAY-$LIGHT_GRAY "
    PS2="$LIGHT_CYAN-$CYAN-$GRAY-$NO_COLOUR "
}


function make-prompt {
####################
#  ANSI Colors
####################

local PRE_COLOR="\001\033["
local POST_COLOR="\002"
local DEFAULT="\e[m\002"

local COLOR="\001\033[31;40m\002"
local RED="\001\033[0;31m\002"
local GREEN="\001\033[0;32m\002"
local YELLOW="\001\033[0;33m\002"
local LIGHT_GRAY="\001\033[0;37m\002"
local CYAN="\001\033[0;36m\002"
local CLEAR="\001\e[0m\002"

#BACK_RED="41"
#BACK_GREEN="42"
#BACK_BROWN="43"
#BACK_BLUE="44"
#BACK_PURPLE="45"
#BACK_CYAN="46"
#BACK_GRAY="47"

#FRONT_BLACK="0;30m"
#FRONT_WHITE="1;37m"
#FRONT_BLUE="0;34m"
#FRONT_LIGHT_BLUE="1;34m"
#FRONT_GREEN="0;32m"
#FRONT_LIGHT_GREEN="1;32m"
#FRONT_CYAN="0;36m"
#FRONT_LIGHT_CYAN="1;36m"
#FRONT_RED="0;31m"
#FRONT_LIGHT_RED="1;31m"
#FRONT_PURPLE="0;35m"
#FRONT_PINK="1;35m"
#FRONT_BROWN="0;33m"
#FRONT_YELLOW="1;33m"
#FRONT_LIGHT_GRAY="0;37m"
#FRONT_DARK_GRAY="1;30m"


    if [ "${PROMPT_COLOR_ENABLED}" = "true" ]; then
        case $TERM in
            xterm*|rxvt*)
                #https://gist.github.com/phette23/5270658
                #TITLEBAR="\001\033]0;\002\W\007\002"
                TITLEBAR="\001\033]0;\002\001\W\007\002"
                ;;
            *)
                TITLEBAR=""
                ;;
        esac

        if [ $UID -eq 0 ]; then
            # set prompt color for root
            PROMPT_COLOR="${PRE_COLOR}37;41m${POST_COLOR}"
        else
            # set prompt color for general users
            PROMPT_COLOR="${PRE_COLOR}37;44m${POST_COLOR}"
        fi
        #SIMPLE_PROMPT="[\u@\h] \w"

        if type __git_ps1 &>/dev/null; then
            SIMPLE_PROMPT="\w\$(__git_ps1 ' (%s)') \$"
        else
            SIMPLE_PROMPT="[${USER}@\h:\W]\$"
        fi
        #PS1="${PRE_COLOR}${PROMPT_COLOR}${SIMPLE_PROMPT}${POST_COLOR}${DEFAULT} "
        #PS1="${TITLEBAR}${PRE_COLOR}${PROMPT_COLOR}${POST_COLOR}${SIMPLE_PROMPT}${PRE_COLOR}\[\033[m\]${POST_COLOR}${DEFAULT} "
        #PS1="${TITLEBAR}${PROMPT_COLOR}${SIMPLE_PROMPT}${PRE_COLOR}m${POST_COLOR}${DEFAULT} "
        PS1="${PROMPT_COLOR}${SIMPLE_PROMPT}${PRE_COLOR}${POST_COLOR}${DEFAULT} "
        #PS1="${TITLEBAR}${PRE_COLOR}${PROMPT_COLOR}${POST_COLOR}${SIMPLE_PROMPT}${PRE_COLOR}\[\033[m\]${POST_COLOR}${DEFAULT} "
        #PS1="${TITLEBAR}[${GREEN}${USER}@\h:\W${YELLOW}$(__git_ps1 ' (%s)')${LIGHT_GRAY}${CLEAR}]\\$ "
    else
        PS1="${SIMPLE_PROMPT} "
    fi
    export PS1
}

export GIT_PS1_SHOW_DIRTYSTATE=1
GIT_PROMPT_ONLY_IN_REPO=1
export PROMPT_COMMAND="make-prompt; ${PROMPT_COMMAND}"
__log_debug "PROMPT_COMMAND = '${PROMPT_COMMAND}'"
__log_debug "PS1 = '${PS1}'"

__log_debug "Finished reading ${HOME}/.bash/environment.sh"
