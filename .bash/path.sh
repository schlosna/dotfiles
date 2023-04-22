#!/bin/bash

. "${HOME}/.bash/common.bash"

__log_debug "Begin reading ${HOME}/.bash/path.sh"

####################
# Export environment variables
####################

# Home brew prefix (i.e `brew --prefix`)
[ -f "/usr/local/bin/brew" ] && BREW_HOME=/usr/local
[ -f "/opt/homebrew/bin/brew" ] && BREW_HOME=/opt/homebrew
[ -f "/opt/brew/bin/brew" ] && BREW_HOME=/opt/brew
export BREW_HOME=${BREW_HOME:-/usr/local}
__log_debug "Using BREW_HOME=${BREW_HOME}"

####################
# Java Path
####################

if [ -f "/usr/libexec/java_home" ]; then
    export JAVA_8_HOME="$(/usr/libexec/java_home -v 1.8)"
    export JDK8_HOME="${JAVA_8_HOME}"
fi

####################
# Executable Search Path
####################

__log_debug "Original PATH=${PATH}"
PATH="/opt/local/bin:${PATH}"
PATH="/usr/local/bin:${PATH}"
PATH="${BREW_HOME}/opt/curl/bin:${PATH}"
PATH="${BREW_HOME}/opt/ant@1.9/bin:${PATH}"
PATH="${BREW_HOME}/bin:${PATH}"
PATH="${BREW_HOME}/sbin:${PATH}"
for i in ${BREW_HOME}/opt/*/libexec/gnubin; do PATH="$i:${PATH}"; done
PATH="${BREW_HOME}/opt/coreutils/libexec/gnubin:${PATH}"
PATH="${PATH}:${HOME}/bin"
PATH="${PATH}:${HOME}/.jenv/bin"
PATH="${PATH}:${BREW_HOME}/share/npm/bin"

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
