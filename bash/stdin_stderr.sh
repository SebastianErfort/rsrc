my_cmd >/dev/null 2>&1 # re-direct STDOUT and STDERR (bashism)
my_cmd >/dev/null >&2 # re-direct STDERR (bashism)
my_cmd &>/dev/null # shorthand (bashism)

function get_message () {
    [[ -f ${1} ]] && cat ${1} || echo "$@"
}

function process_message () {
    [[ ! -t 0 ]] && args="${@} $(</dev/stdin)" || args=$@
    # [[ $args = *[![:space:]]* ]] && echo Nothing to do || return 0 # only ws, nothing to do
    # or
    [[ $args =~ ^\ *$ ]] && echo Nothing to do && return 0 # only ws, nothing to do
    echo Working with $args

    if [[ -f ${1} ]]; then # first argument is bg image file or error message file
        identify ${1} >/dev/null 2>&1 && bgimage=${1} shift # argument is image file
        echo ${@}
        message=$(get_message ${@})
        echo $bgimage
        echo $message
    fi
}

# Redirect stdin and stderr to separate files and both to a common file
function cause_error () {
    echo derp
    ls schlerpaterp
}
cause_error 1> >(tee stdout.txt > stdout_stderr.txt) 2> >(tee stder.txt >> stdin_stderr.txt)
