#!/usr/bin/env bash

function find_files () {
    local msg_usage="Usage: ${FUNCNAME[0]} <file name pattern> <path(s)>"
    (( $# < 2 )) && { echo "$#: ERROR. ${msg_usage}"; return 2; }
    [[ "$1" == "-h" || "$1" == "--help" ]] && { echo -e "$msg_usage"; return; }
    local VERBOSE
    [[ "$1" == "-v" || "$1" == "--verbose" ]] && { VERBOSE=true; shift; } || VERBOSE=false
    local -a files allfiles
    local find_pattern="$1"; shift
    $VERBOSE && echo "Searching files ${find_pattern} in path(s) $*"
    # collect files to be fixed
    for path in "$@"; do
        if [[ -f "$path" ]]; then
            allfiles+=("$path")
        else
            mapfile -t files < <(find "$path" -name "$find_pattern")
            allfiles+=("${files[@]}")
        fi
    done
    # strip prefix `./` that find adds
    allfiles=("${allfiles[@]#\.\/}")
    printf "%s\n" "${allfiles[@]}" | sort -u
}

function egrep_files () {
    msg_usage="Usage: ${FUNCNAME[0]} <file name glob> <grep pattern> <path(s)>"
    (( $# < 3 )) && { echo "ERROR. ${msg_usage}"; return 2; }
    local fn_glob="$1" pattern="$2"
    shift 2
    grep -ilE "$pattern" "$(find_files "$fn_glob" "$@")"
}

function camel_case () {
    # camel case
    arg_arr=("$@")
    echo "${arg_arr[*]^}"
}
