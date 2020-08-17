#!/bin/bash

. "${HOME}/.bash/common.bash"

__log_debug "Begin reading ${HOME}/.bash/path.sh"

####################
# Export environment variables
####################

# Home brew prefix (i.e `brew --prefix`)
[ -d "/usr/local/" ] && BREW_HOME=/usr/local
[ -d "/opt/brew/" ] && BREW_HOME=/opt/brew
export BREW_HOME=${BREW_HOME:-/usr/local}
__log_debug "Using BREW_HOME=${BREW_HOME}"

####################
# Java Path
####################

export JAVA_8_HOME="$(/usr/libexec/java_home -v 1.8)"
export JDK8_HOME="${JAVA_8_HOME}"

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
PATH="${PATH}:${HOME}/bin"
PATH="${PATH}:${HOME}/.jenv/bin"
PATH="${PATH}:${BREW_HOME}/share/npm/bin"

export PATH
__log_debug "PATH=${PATH}"

####################
# Manual Search Path
####################
export MANPATH="/usr/local/share/man:${BREW_HOME}/share/man:/usr/share/man:${MANPATH}"
__log_debug "MANPATH=${MANPATH}"

__log_debug "Finished reading ${HOME}/.bash/path.sh"
