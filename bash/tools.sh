#!/usr/bin/env bash

function find_files () {
    local msg_usage="Usage: ${FUNCNAME[0]} <global arr name> <file name pattern> <path(s)>"
    (( $# < 3 )) && { echo "$#: ERROR. ${msg_usage}"; return 2; }
    [[ "$1" == "-h" || "$1" == "--help" ]] && { echo -e "$msg_usage"; return; }
    local VERBOSE
    [[ "$1" == "-v" || "$1" == "--verbose" ]] && { VERBOSE=true; shift; } || VERBOSE=false
    local -a files
    eval "declare -nl files_return=${1}"
    local find_pattern="$2"
    shift 2
    $VERBOSE && echo "Searching files ${find_pattern} in path(s) $*"
    # collect files to be fixed
    for path in "$@"; do
        if [[ -f "$path" ]]; then
            files_return+=("$path")
        else
            mapfile -t files < <(find "$path" -name "$find_pattern")
            files_return+=("${files[@]}")
        fi
    done
}

function grep_files () {
    msg_usage="Usage: ${FUNCNAME[0]} <ga name> <file name glob> <grep pattern> <path(s)>"
    (( $# < 4 )) && { echo "ERROR. ${msg_usage}"; return 2; }
    local ga_name="$1" fn_glob="$2" pattern="$3"
    shift 3
    eval "declare -n files_ref=${ga_name}"
    find_files "$ga_name" "$fn_glob" "$@"
    mapfile -t files_ref < <(grep -il "$pattern" "${files_ref[@]}")
}
