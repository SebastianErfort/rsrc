#!/usr/bin/env bash

# TODO: use markdownlint with tags/rules to filter only files with a problem that will be fixed by the respective command/function/script?

UTILDIR=${UTILDIR:-.}
. "${UTILDIR}/bash/tools.sh"
. "${UTILDIR}/markdown/frontmatter.sh"
. "${UTILDIR}/markdown/markdownlint.sh"

# set markdownlint config file
MDL_CFG="$(mdl_find_config)"
[[ -n "$MDL_CFG" ]] && MDL_CFG="-c ${MDL_CFG}"
# retrieve Markdown indentation from markdownlint config file, set default if not found
MD_IND="$(mdl_get_indent)"

function md_fix_listIndent () {
    # TODO: read indent value from central (config) file
    # for now using 4 in line with MkDocs (Python Markdown)
    [[ -n "${fixfiles[*]}" ]] && unset fixfiles
    declare -ga fixfiles
    find_files fixfiles "*.md" "$@"
    awk -i inplace -v indent="$MD_IND" -f "${UTILDIR}/markdown/wrong_indent.awk" "${fixfiles[@]}"
    unset fixfiles
}

function md_fix_tagLineStart () {
    # find lines starting with tag #... and prepend with text as some Markdown parsers
    # interpret this as headings
    [[ -n "${fixfiles[*]}" ]] && unset fixfiles
    declare -ga fixfiles
    grep_files fixfiles '*.md' '^#[a-z]' "$@"

    for f in "${fixfiles[@]}"; do
        sed -i '/^#[a-zA-Z]/s/./Tags: &/' "$f"
    done
    unset fixfiles
}

function md_fix () {
    # front matter fixes, see frontmatter.sh
    echo "Fixing YAML front matter"
    fm_fix "$@"

    # linters with fix function don't reindent underindented list items well
    echo "Fixing list indentation"
    md_fix_listIndent "$@"
    echo "Fixing lines starting with tag #..."
    md_fix_tagLineStart "$@"

    # use fix functionality of [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli)
    if which markdownlint; then
        [[ -n "${fixfiles[*]}" ]] && unset fixfiles
        declare -ga fixfiles
        find_files fixfiles "*.md" "$@"
        mdl_log=markdownlint.log
        markdownlint $MDL_CFG -o "$mdl_log" -f "$@"
        [[ $(wc -l "$mdl_log" 2>/dev/null | awk '{print $1}') -eq 0 ]] && rm markdownlint.log || \
            echo "Unresolved Markdown issues, see ${mdl_log}"
    else
        echo "Missing Markdown linter CLI markdownlint-cli(2), skipping further fixes"
    fi

    unset fixfiles
}

# if executed, not sourced
if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
    md_fix "$@"
fi
