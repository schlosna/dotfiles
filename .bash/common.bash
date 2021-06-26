#!/bin/bash

if [ -v $__processed_common ]; then
    __log_info() {
        echo " [INFO]  - ${1}"
    }

    __log_debug() {
        [ -n "${DEBUG}" ] && echo " [DEBUG] - ${1}" 1>&2
    }

    import() {
        if [ -s "$@" ]; then
            . "$@"
            __log_debug "imported '$@'"
            return 0
        fi
        return 1
    }

    __processed_common=1
fi
