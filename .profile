#!/bin/sh

[ -n "${DEBUG}" ] && echo "begin reading ${HOME}/.profile"

# Setting the path for MacPorts.
#export PATH=/opt/local/bin:/opt/local/sbin:${PATH}
echo PATH=${PATH}

#export MANPATH=/opt/local/share/man:${MANPATH}
echo MANPATH=${MANPATH}

[ -n "${DEBUG}" ] && echo "finished reading ${HOME}/.profile"

