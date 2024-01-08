#!/usr/bin/env bash

[[ -f frontmatter.sh ]] && . frontmatter.sh

function push_fmmatch () {
    # Push all files where YAML frontmatter <key> has <value> to <target dir>
    # #markdown #markdown/frontmatter
    # TODO: Would be cooler with Git/version control than rsync
    local msg_usage="Usage: ${FUNCNAME[0]} <key> <val> [<source dir>] <target dir>"
    [[ $# != 3 && $# != 4 ]] && echo "$msg_usage" && return 2
    # TODO: allow for defaults
    local key=${1:-visibility} value=${2:-public}
    [[ $# == 4 ]] && source_dir="$3" || source_dir='.'
    local -a syncfiles # array to store function result

    # TODO: this only catches Markdown files with a certain front matter key and not, for example, image files etc.
    #   => add another way of declaring files public like a whitelist of files or metadata
    #   ! consider license/copyright first
    mapfile -t syncfiles < <(fm_matchFiles "$key" "$value" "$source_dir")
    # additional files from file
    if [[ -f public.txt ]]; then
        while read -r l; do
            syncfiles+=("$l")
        done < public.txt
    fi
    # sort and remove duplicates (ensure unique)
    mapfile -t syncfiles < <(printf '%s\n' "${syncfiles[@]}" | sort -u)

    echo "Copying ${#syncfiles[@]} files to $3 ..."
    rsync -aLR "${syncfiles[@]}" "$3"

    unset syncfiles
    echo "Done."
}

function pull_fmmatch () {
    [[ $# != 1 ]] && echo "Usage: <source dir>" && return 2

    echo "Copying files from $1 ..."
    cp -ar "$1"/* .
    # rsync -aLR "$3/*" .

    echo "Done."
}
