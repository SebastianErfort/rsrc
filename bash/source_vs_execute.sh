[[ "$0" = "${BASH_SOURCE[0]}" ]] && echo executed || echo sourced

function when_executed () {
    echo "executed: calling ${FUNCNAME[0]}"
}

[[ "$0" = "${BASH_SOURCE[0]}" ]] && when_executed
