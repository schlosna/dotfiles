#!/bin/bash

[ -n "${TRACE_BASH}" ] && set -x
[ -n "${DEBUG}" ] && echo "began reading ${HOME}/.bashrc"

# Always setup PATH
[ -f ~/.bash/path.sh ] && . ~/.bash/path.sh

if [ -n "${PS1}" ]; then
# Setup interactive shell
    [ -f ~/.bash/environment.sh ] && . ~/.bash/environment.sh
    [ -f ~/.bash/aliases.sh ] && . ~/.bash/aliases.sh
    [ -f ~/.bash/functions.sh ] && . ~/.bash/functions.sh
fi

[ -n "${DEBUG}" ] && echo "finished reading ${HOME}/.bashrc"
