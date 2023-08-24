set -e # Exit on error. Has gotchas, see http://mywiki.wooledge.org/BashFAQ/105? Same as set -o errexit.
set -o errtrace # functions and subshells inherit errexit
trap 'echo -n "there was an error (code $?): " ; [[ -f error.txt ]] && cat error.txt' ERR
# Redirect stderr of all commands to file and back to original stderr
exec 2> >(tee error.txt >&2)

# function cleanup () {
#     # ...
# }

function myerror () {
    if [ "$1" -eq 2 ]; then
        echo "Usage: ${FUNCNAME} options arguments"; return 2
    else
        echo "Error in ${FUNCNAME}: {$2}"; return "$1"
    fi
}

# cause an error
ls adkl
