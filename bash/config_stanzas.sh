# TODO
# - adopt Git's dot-notation syntax to access values?
#   example: <command> submodule.<sm name>.key

. ./util/sed_escape.sh

function config_get_stanza () {
    local msg_usage="Usage: ${FUNC_NAME[0]} <regex start> <file>"

    # contents before
    if [[ "$1" == "-b" ]]; then
        shift
        [[ $(grep -n "^\s*\[.*${1}" "$2" | awk -F: '{print $1}') -gt 1 ]] && \
            sed -n "1,/\[.*$(sed_escape "$1")/p" "$2" | sed '$d'
    # contents after
    elif [[ "$1" == "-a" ]]; then
        shift
        sed -n "/\[.*$(sed_escape "$1")/,\$p" "$2" | awk '/^\s*\[/ {s++} s > 1 {print}'
    # contents of stanza
    else
        sed -n "/\[.*$(sed_escape "$1")/,/^\s*\[/p" "$2" | awk '! (NR > 1 && /^\s*\[/) {print}'
    fi
}

function stanza_get_val () {
    local msg_usage="Usage: ${FUNC_NAME[0]} <stanza> <var> <file>"
    [[ "$#" -ne 3 ]] && { echo "ERROR. Usage: ${msg_usage}"; return 2; }
    config_get_stanza "$1" "$3" | awk -F= "/${2}/ {print \$2}" | tr -d ' '
}

function stanza_set_val () {
    local msg_usage="Usage: ${FUNC_NAME[0]} <stanza> <var> <val> <file>"
    [[ "$#" -ne 4 ]] && { echo "ERROR. Usage: ${msg_usage}"; return 2; }
    # init
    local current before after
    current=$(config_get_stanza "$1" "$4")
    before=$(config_get_stanza -b "$1" "$4")
    after=$(config_get_stanza -a "$1" "$4")

    # update variable
    # NOTE: using sed here instead of awk as it's easier to preserve whitespace
    current=$(sed "s/\(${2}\s*=\s*\)\S\+/\1$(sed_escape ${3})/" <<< "$current")

    # return
    [[ -n "${before}" ]] && echo -e "$before" > "$4"
    [[ -n "${current}" ]] && echo -e "$current" >> "$4"
    [[ -n "${after}" ]] && echo -e "$after" >> "$4"
    return 0
}
