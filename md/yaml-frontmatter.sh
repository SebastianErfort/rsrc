#!/usr/bin/env bash
# Description:
#   Parse YAML frontmatter in Markdown files. Add if missing with filename as title.
# Requisites
# - yq: YAML parser
# - yamllint: YAML linter

function main () {
    mapfile -t files < <(find . -name '*.md') # bash >4 builtin for arrays
    for (( i = 0; i < ${#files[@]}; i++ )); do
        yaml-frontmatter_ensure "${files[$i]}"
    done
}

function yaml_validate () {
    # Validate YAML syntax using yamllint python package
    local logfile="${0%.*}.log"
    yamllint --no-warnings "$1" &>"$logfile" && rm "$logfile" || return 1
}

function yaml-frontmatter_validate () {
    yq --front-matter=extract "$1" 2>/dev/null | yaml_validate /dev/stdin || head "$1" && return 1
}

function yaml-frontmatter_test () {
    yaml-frontmatter_validate /dev/stdin << 'EOF'
---
title: derp
---
## yerp
EOF
}

# yaml-frontmatter_test
main
