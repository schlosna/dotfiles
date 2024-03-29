#!/bin/bash

. "${HOME}/.bash/common.bash"

__log_debug "begin reading ${HOME}/.bash/functions.sh"

if type -P brew &>/dev/null; then
    BREW_HOME=$(brew --prefix)
fi
LOCAL_BIN=${BREW_HOME:-/usr/local}/bin
if [ -x ${LOCAL_BIN}/gls ]; then
# Prefer Homebrew installed ls
    LS=${LOCAL_BIN}/gls
    LS_OPTS="--color=auto ${LS_OPTS}"
elif [ -x ${LOCAL_BIN}/ls ]; then
# See if manually installed
    LS=${LOCAL_BIN}/ls
    LS_OPTS="--color=auto ${LS_OPTS}"
else
# Fallback on good standard ls
    LS=ls
    LS_OPTS="-G ${LS_OPTS}"
fi
__log_debug "PATH=${PATH} BREW_HOME=${BREW_HOME} LOCAL_BIN=${LOCAL_BIN} LS=${LS}"
#[[ "/bin/ls" != "${LS}" && ${TERM} == *color* ]] && LS_OPTS="--color=auto ${LS_OPTS}"

function .. { cd .. ; }
function blog { git log --date-order --graph --format="%C(green)%H %C(reset)%C(yellow)%an%C(reset) %C(cyan bold)%aI%C(reset)%C(red bold)%d%C(reset) %s %C(cyan bold)%N%Creset" "$@" ; }
function brewup { brew update ; echo ; echo "Updated, Outdated:"; brew outdated ; }
function bsh { java -cp /opt/local/share/java/bsh.jar bsh.Interpreter "$@" ; }
function calc { awk "BEGIN{ print $@ }" ; }
function catskim { cat "${@}" | enscript -p - | open -f -a Skim ; }
function cdd { pushd "$@" ; }
function cpr { rsync -ahv --progress "$@" ; }
function cs { cd $(pwd | sed "s#/Volumes/git/#${HOME}/src/#"); clear ; }
function dns-restart { sudo killall -HUP mDNSResponder ; }
function docker-kill() { docker stop $(docker ps -a -q) && docker rm -vf $(docker ps -a -q) ; }
function docker-vagrant { export DOCKER_HOST=tcp://localhost:2375 ; }
function docker-unset { unset ${!DOCKER_*}; env | grep DOCKER ; }
function du2 { du -csh "$@" | egrep '^[0-9.]+M' | sort -n ; }
function eject { drutil tray eject ; }
function f { find . -name "*$@*" ; }
function ff { find . -name "$@" -print ; }
function gas { git status --porcelain | grep "^M" | sed 's/^M. //' | xargs git add; git status "$@" ; }
function gc { git clone "$@" && cd $(basename $@ | sed 's/\..*//g') ; }
function getsite { wget -r --no-host-directories --no-parent --level=5 --user-agent='Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; rv:1.6b) Gecko/20031213 Camino/0.7+' "$@" ; }
function getpdf {  wget -r -l1 -A.pdf "$@" ; }
function gb { git recent || git branch -v "$@" ; }
function gd { git diff "$@" ; }
function gdd { git diff "$@" ; }
function gds { git diff --staged "$@" ; }
function gdt { git difftool "$@" ; }
function gdts { git difftool --staged "$@" ; }
function gf { gvim `f "$@"` ; }
function gl { git log "$@" ; }
function gs { git status -uno "$@" ; }
function gsi { git status -u --ignored "$@" ; }
function gss { git status -uno --ignored "$@" ; }
function gst { git status "$@" ; }
function gcm { git commit -a -v "$@" ; }
function gco { git checkout "$@" ; }
function gdm { GIT_EXTERNAL_DIFF='diffmerge-git-wrapper' git diff "$@" ; }
function gitup { cd $(git rev-parse --show-toplevel) ; }
function gitx { open -a gitx . ; }
function gpull { git pull ; git status "$@" ; }
function gpush { git push origin HEAD "$@" ; }
function gradle-stop { jcmd | grep -i GradleDaemon | awk '{ print $1 }' | xargs kill ; }
function gup {
    if git pull; then
        git status;
        gw idea;
    else
        git status;
    fi
}
function gvim {
    if type -P mvim &>/dev/null; then
        mvim "$@" ;
    else
        vim "$@" ;
    fi
}
function gz { gzip -v "$@" ; }
function hgs { hg status "$@" ; }
function hgqs { hg qstatus "$@" ; }
function hlog { git log --date-order --all --graph --format="%C(green)%H%C(reset) %C(yellow)%an%C(reset) %C(cyan bold)%aI%C(reset)%C(red bold)%d%C(reset) %s %C(cyan bold)%N%C(reset)" "$@" ; }
function jboss { cd ${JBOSS_HOME} ; }
function jc { jar cvf "$1.jar" "$1" ; }
function jenv-home { export JAVA_HOME=$(jenv javahome); echo "JAVA_HOME=${JAVA_HOME}" ; java -version; }
function jslint {
    gjslint "$@";
    jshint "$@";
}
function l { $LS -lchF $LS_OPTS "$@" ; }
function launch { open -a "$@" ; }
function lg { ll | grep -i "$@" ; }
function ll { $LS -AhlF $LS_OPTS "$@" ; }
function lla { $LS -ahlF $LS_OPTS "$@" ; }
function lll { $LS -AhlF $LS_OPTS "$@" | $PAGER ; }
function lsa { $LS -ahlF $LS_OPTS "$@" ; }
function lss { $LS -AhlSF $LS_OPTS "$@" ; }
function lst { $LS -AhltF $LS_OPTS "$@" ; }
function ltr { $LS -AhltrF $LS_OPTS "$@" ; }
function manp { man -t "$@" | open -f -a Skim ; }
function markdown { python -m markdown -x footnotes "$@" ; }
function md2html { markdown "$1" > "$1.html"; open "$1.html" ; }
function mysqlctl { sudo /opt/local/etc/LaunchDaemons/org.macports.mysql5/mysql5.wrapper "$@" ; }
function nice-diff {
    if type -P diff-so-fancy &>/dev/null; then
        diff-so-fancy "$@" ;
    else
        diff "$@" ;
    fi
}
function o { open "$@" ; }
function of { $EDITOR `f "$@"` ; }
function pc { pwd | tr -d "\n" | pbcopy ; }
function pd { popd ; }
function port-clean { sudo port clean --all installed; sudo port -f uninstall inactive ; }
function port-hash { echo "checksums:" && md5 "$1" && openssl sha1 "$1" && openssl rmd160 "$1" ; }
function port-sync { sudo port -d sync && port-clean; port outdated ; }
function port-update { sudo port -d selfupdate ; }
function psg { ps -axo 'pid,user,nice,time,%cpu,command' | head -n 1; ps -axo 'pid,user,nice,time,%cpu,command' | grep -i "$@" | grep -v grep ; }
function psn { ps -axo 'pid,user,nice,time,%cpu,command' "$@" ; }
function pxz { jar cvfm "$1.pxz" META-INF/MANIFEST.MF metadata.xml ontology.ont sample.xml data.xml ; }
function q { exit ; }
function rcp { rsync --archive --human-readable --verbose --compress --progress "$@" ; }
function srcp { rsync -ahvz --rsync-path="sudo rsync" --progress "$@" ; }
function reattach { screen -d -r "$@" ; }
function replace { perl -p -i -e $1 $2 ; }
function s { screen "$@" ; }
function setup-gradlew { git archive --remote=git@stash:gradle/gradle-wrapper-bootstrap.git master | tar -x ; }
function sr { screen -R "$@" ; }
function svndiff { svn diff --diff-cmd $(which diff) -x "-u -w" "$@" ; }
function tf { touch "$@" && tail -f "$@" ; }
function tab() {
    osascript -e "
        tell application \"iTerm\"
         tell the first terminal
          set currentSession to current session
          launch session \"Default Session\"
          tell the last session
           write text \"cd $(pwd)\"
           write text \"$*\"
          end tell
          select currentSession
         end tell
        end tell"
}
function tcpflow { sudo tcpflow -c -i en0 "$@" ; }
function todo { gvim "$HOME/todo/todo.txt" ; }
function tf { tail -f "$@" ; }
function tgz { tar -c --use-compress-program=pigz -f "$1.tar.gz" "$1" ; }
function tssh { ssh "$@" -t "tmux -CC attach || tmux -CC" ; }
function unbz2 { bunzip2 "$@" ; }
function ungz { gzip -d "$@" ; }
function untar { tar xf "$@" ; }
function untbz2 { bunzip2 -c "$@" | tar -xf - ; }
function untgz { tar xzf "$@" ; }
function up { cd ..; ls ; }
function viewgz { tar tfz "$@" ; }
function wgetall { wget -r -nd -np -l1 -A "*.$2" "$1" ; }
function which { type -a "$@" ; }
function write-locks { gw --write-locks "$@" checkClassUniqueness checkUnusedConstraints verifyLocks ; git status ; }
function yy () {
    opensc_path=/usr/local/lib/opensc-pkcs11.so
    eval $(ssh-agent -t 1d -P $opensc_path)
    ssh-add -s $opensc_path
}

function sshagent_findsockets {
    find "$TEMPDIR" -uid $(id -u) -type s -name agent.\* 2>/dev/null
}

function sshagent_testsocket {
    if [ ! -x "$(which ssh-add)" ] ; then
        echo "ssh-add is not available; agent testing aborted"
        return 1
    fi

    if [ X"$1" != X ] ; then
        export SSH_AUTH_SOCK=$1
    fi

    if [ X"$SSH_AUTH_SOCK" = X ] ; then
        return 2
    fi

    if [ -S $SSH_AUTH_SOCK ] ; then
        ssh-add -l > /dev/null
        if [ $? = 2 ] ; then
            echo "Socket $SSH_AUTH_SOCK is dead!  Deleting!"
            rm -f $SSH_AUTH_SOCK
            return 4
        else
            echo "Found ssh-agent $SSH_AUTH_SOCK"
            return 0
        fi
    else
        echo "$SSH_AUTH_SOCK is not a socket!"
        return 3
    fi
}

function sshagent_init {
    # ssh agent sockets can be attached to a ssh daemon process or an
    # ssh-agent process.

    AGENTFOUND=0

    # Attempt to find and use the ssh-agent in the current environment
    if sshagent_testsocket ; then AGENTFOUND=1 ; fi

    # If there is no agent in the environment, search $TEMPDIR for
    # possible agents to reuse before starting a fresh ssh-agent
    # process.
    if [ $AGENTFOUND = 0 ] ; then
        for agentsocket in $(sshagent_findsockets) ; do
            if [ $AGENTFOUND != 0 ] ; then break ; fi
            if sshagent_testsocket $agentsocket ; then AGENTFOUND=1 ; fi
        done
    fi

    # If at this point we still haven't located an agent, it's time to
    # start a new one
    if [ $AGENTFOUND = 0 ] ; then
        eval `ssh-agent -s`
    fi

    # Clean up
    unset AGENTFOUND
    unset agentsocket

    # Finally, show what keys are currently in the agent
    ssh-add -l
}

complete -F _known_hosts cpr
complete -F _known_hosts rcp

__log_debug "finished reading ${HOME}/.bash/functions.sh"
