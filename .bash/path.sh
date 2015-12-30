#!/bin/bash

[ -n "${DEBUG}"  ] && echo begin reading ${HOME}/.bash/path.sh

####################
# Export environment variables
####################

# Home brew prefix (i.e `brew --prefix`)
#export BREW_HOME=/usr/local
export BREW_HOME=/opt/homebrew
[ -n "${DEBUG}"  ] && echo "setup homebrew BREW_HOME=${BREW_HOME}"

####################
# Java Path
####################

#export JAVA_HOME=$(/usr/libexec/java_home -v 1.6)
#export JDK6_HOME=/Library/Java/JavaVirtualMachines/1.6.0_65-b14-462.jdk/Contents/Home
export JDK6_HOME=/Users/davids/.jenv/versions/1.6
export JAVA_1_6_HOME="$JDK6_HOME"
export JDK7_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0.jdk/Contents/Home
export IVY_SETTINGS=/Users/davids/.ivy2/ivy-settings.xml
#export CLASSPATH=/opt/oracle/lib/ojdbc6_g.jar:${CLASSPATH}:.

####################
# Executable Search Path
####################

[ -n "${DEBUG}"  ] && echo "original PATH=${PATH}"
PATH="/opt/local/bin:${PATH}"
PATH="/usr/local/bin:${PATH}"
PATH="${BREW_HOME}/bin:${PATH}"
PATH="${PATH}:${HOME}/bin"
PATH="${PATH}:${HOME}/.jenv/bin"
PATH="${PATH}:${BREW_HOME}/share/npm/bin"

IL_SCRIPTS_HOME="${HOME}/src/il_scripts"
PATH="${PATH}:${IL_SCRIPTS_HOME}"
source "${IL_SCRIPTS_HOME}/.bash_completion.d/il_completion"

export PATH
[ -n "${DEBUG}"  ] && echo "setup PATH=${PATH}"

####################
# Manual Search Path
####################
export MANPATH="/usr/local/share/man:${BREW_HOME}/share/man:/usr/share/man:${MANPATH}"
[ -n "${DEBUG}"  ] && echo "setup MANPATH=${MANPATH}"

[ -n "${DEBUG}"  ] && echo finished reading ${HOME}/.bash/path.sh