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
    JAVA_8_HOME="$(/usr/libexec/java_home -v 1.8)"
    JAVA_11_HOME="$(/usr/libexec/java_home -v 11)"
    JAVA_15_HOME="$(/usr/libexec/java_home -v 15)"
    JAVA_17_HOME="$(/usr/libexec/java_home -v 17)"
    export JAVA_8_HOME JAVA_11_HOME JAVA_15_HOME JAVA_17_HOME
fi

export PNPM_HOME="${HOME}/Library/pnpm"

####################
# Executable Search Path
####################

__log_debug "Original PATH=${PATH}"
# Prepend to PATH
PATH="/usr/local/bin:${PATH}"
PATH="/opt/local/bin:${PATH}"
PATH="${HOME}/bin:${PATH}"
PATH="${BREW_HOME}/bin:${PATH}"
PATH="${BREW_HOME}/sbin:${PATH}"
PATH="${HOME}/bin:${PATH}"
# Append to PATH
for i in "${BREW_HOME}"/opt/*/libexec/gnubin; do PATH="${PATH}:${i}"; done
PATH="${PATH}:${BREW_HOME}/share/npm/bin"
PATH="${PATH}:${BREW_HOME}/opt/ant@1.9/bin"
PATH="${PATH}:${BREW_HOME}/opt/curl/bin"
PATH="${PATH}:${BREW_HOME}/opt/python@3.11/libexec/bin"
PATH="${PATH}:${BREW_HOME}/share/npm/bin"
PATH="${PATH}:${PNPM_HOME}"

export PATH
__log_debug "PATH=${PATH}"

####################
# Manual Search Path
####################
MANPATH="/usr/local/share/man:${MANPATH}"
MANPATH="${MANPATH}:${BREW_HOME}/share/man"
MANPATH="${MANPATH}:${BREW_HOME}/opt/coreutils/libexec/gnuman"
MANPATH="${MANPATH}:/usr/share/man"
export MANPATH
__log_debug "MANPATH=${MANPATH}"

__log_debug "Finished reading ${HOME}/.bash/path.sh"
