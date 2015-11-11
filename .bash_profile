#!/bin/bash

if [ -n "${DEBUG}" ]; then
    echo "${BASH} ${BASH_VERSION}"
    if [ -n "${VERBOSE}" ]; then
        PS4='$(date "+%s.%N (${BASH_SOURCE[$i]}: $LINENO) + ")'
        export PS4
    fi
    echo "begin reading ${HOME}/.bash_profile"
fi

[ -f ${HOME}/.bashrc ] && . ${HOME}/.bashrc

[ -n "${DEBUG}" ] && echo "finished reading ${HOME}/.bash_profile"
