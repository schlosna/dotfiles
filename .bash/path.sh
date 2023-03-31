#!/bin/bash

. "${HOME}/.bash/common.bash"

__log_debug "Begin reading ${HOME}/.bash/path.sh"

####################
# Export environment variables
####################

# Home brew prefix (i.e `brew --prefix`)
[ -x "/usr/local/bin/brew" ] && BREW_HOME=/usr/local
[ -x "/opt/brew/bin/brew" ] && BREW_HOME=/opt/brew
[ -x "/opt/homebrew/bin/brew" ] && BREW_HOME=/opt/homebrew
export BREW_HOME=${BREW_HOME:-/opt/homebrew}
__log_debug "Using BREW_HOME=${BREW_HOME}"

####################
# Java Path
####################

if [ -f "/usr/libexec/java_home" ]; then
    export JAVA_8_HOME="$(/usr/libexec/java_home -v 1.8)"
    export JAVA_11_HOME="$(/usr/libexec/java_home -v 11)"
    export JAVA_15_HOME="$(/usr/libexec/java_home -v 15)"
    export JAVA_17_HOME="$(/usr/libexec/java_home -v 17)"
fi

export PNPM_HOME="${HOME}/Library/pnpm"

####################
# Executable Search Path
####################

__log_debug "Original PATH=${PATH}"
PATH="${BREW_HOME}/opt/ant@1.9/bin:${PATH}"
PATH="${BREW_HOME}/opt/curl/bin:${PATH}"
PATH="${BREW_HOME}/opt/python@3.11/libexec/bin:${PATH}"
PATH="${BREW_HOME}/share/npm/bin:${PATH}"
PATH="${HOME}/.jenv/bin:${PATH}"
PATH="${PNPM_HOME}:${PATH}"
PATH="/opt/local/bin:${PATH}"
PATH="/usr/local/bin:${PATH}"
PATH="${HOME}/bin:${PATH}"
PATH="${BREW_HOME}/bin:${PATH}"
PATH="${BREW_HOME}/sbin:${PATH}"

export PATH
__log_debug "PATH=${PATH}"

####################
# Manual Search Path
####################
export MANPATH="/usr/local/share/man:${BREW_HOME}/share/man:/usr/share/man:${MANPATH}"
__log_debug "MANPATH=${MANPATH}"

__log_debug "Finished reading ${HOME}/.bash/path.sh"
