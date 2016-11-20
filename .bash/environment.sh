#!/bin/bash

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

    import "${BREW_HOME}/etc/bash_completion.d/git-prompt.sh"
    import "${BREW_HOME}/opt/bash-git-prompt/share/gitprompt.sh"

    if type -P insta &>/dev/null; then
        PROG=insta source "${BREW_HOME}/Library/Taps/palantir/homebrew-insta/autocomplete/bash_autocomplete"
    fi

    if type -P brew-cask &>/dev/null; then
        alias cask="brew-cask "
        complete -o bashdefault -o default -F _brew_cask cask
    fi
fi

### BASH Completion from MacPorts
import "/opt/local/etc/bash_completion"

# iterm2 shell integration
import "${HOME}/.bash/iterm2_shell_integration.bash"

if type -P jenv &>/dev/null; then
    eval "$(jenv init - --no-rehash)";
    export JAVA_HOME=$(jenv javahome);
fi

if type -P rbenv &>/dev/null; then
    eval "$(rbenv init -)";
fi

[[ -s "${HOME}/.gvm/scripts/gvm" ]] && source "${HOME}/.gvm/scripts/gvm"

export DOCKER_HOST=tcp://localhost:2375

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

export CDPATH=".:~:/Volumes/git:${HOME}/Documents:/Volumes"
export FIGNORE=\~:.bak:.o

####################
# Shell
####################
export DISPLAY=:0.0
export EDITOR="mvim -f"
export VISUAL="mvim -f"
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups

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

####################
# Network
####################
#export ftp_passive=1
#export CVS_RSH=ssh

####################
# IRC
####################
# export IRCSERVER='irc.us.freenode.net:6667'
# export IRCNICK='schlosna'

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
    local GRAY="\[\033[1;30m\]"
    local LIGHT_GRAY="\[\033[0;37m\]"
    local CYAN="\[\033[0;36m\]"
    local LIGHT_CYAN="\[\033[1;36m\]"
    local NO_COLOUR="\[\033[0m\]"

    case $TERM in
        xterm*|rxvt*)
            #local TITLEBAR='\[\033]0;\u@\h:\w\007\]'
            local TITLEBAR='\[\033]0;\W\007\]'
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

local PRE_COLOR="\[\033["
local POST_COLOR="\]"
local DEFAULT="\e[m\]"

    local COLOR="\[\033[31;40m\]"
    local RED="\[\033[0;31m\]"
    local GREEN="\[\033[0;32m\]"
    local YELLOW="\[\033[0;33m\]"
    local LIGHT_GRAY="\[\033[0;37m\]"
    local CYAN="\[\033[0;36m\]"
    local CLEAR="\[\e[0m\]"

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
                TITLEBAR='\[\033]0;\W\007\]'
                ;;
            *)
                TITLEBAR=""
                ;;
        esac

        if [ $UID -eq 0 ]; then
            # set prompt color for root
            PROMPT_COLOR='37;41m'
        else
            # set prompt color for general users
            PROMPT_COLOR="37;44m"
        fi
        #SIMPLE_PROMPT="[\u@\h] \w \$(parse_git_branch)\$"

        if type __git_ps1 &>/dev/null; then
            SIMPLE_PROMPT="\w$(__git_ps1 ' (%s)') \$"
        else
            SIMPLE_PROMPT="[${USER}@\h:\W]\$"
        fi
        #PS1="${PRE_COLOR}${PROMPT_COLOR}${SIMPLE_PROMPT}${POST_COLOR}${DEFAULT} "
        PS1="${TITLEBAR}${PRE_COLOR}${PROMPT_COLOR}${POST_COLOR}${SIMPLE_PROMPT}${PRE_COLOR}\[\033[m\]${POST_COLOR}${DEFAULT} "
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
