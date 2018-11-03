#!/bin/bash

. "${HOME}/.bash/common.bash"

[ -n "${TRACE_BASH}" ] && set -x
__log_debug "Began reading ${HOME}/.bashrc"

# Always setup PATH
import "${HOME}/.bash/path.sh"

if [ -n "${PS1}" ]; then
    # Setup interactive shell
    import "${HOME}/.bash/environment.sh"
    import "${HOME}/.bash/aliases.sh"
    import "${HOME}/.bash/functions.sh"
fi

__log_debug "Finished reading ${HOME}/.bashrc"

unset -f __log_info
unset -f __log_debug
unset -v __processed_common

