#!/usr/bin/env bash
# Example for setting up completion for an alias derived from another command with completion
source /usr/share/bash-completion/completions/pass
_passred(){
    PASSWORD_STORE_DIR=~/.pass/red/ _pass
}
complete -o filenames -o nospace -F _passred passred
_passblue(){
    PASSWORD_STORE_DIR=~/.pass/blue/ _pass
}
complete -o filenames -o nospace -F _passblue passblue
