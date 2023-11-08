#!/usr/bin/env bash

# TODO: use markdownlint with tags/rules to filter only files with a problem that will be fixed by the respective command/function/script?

UTILDIR=${UTILDIR:-.}
. "${UTILDIR}/bash/tools.sh"
. "${UTILDIR}/markdown/frontmatter.sh"
. "${UTILDIR}/markdown/markdownlint.sh"

# set markdownlint config file
MDL_CFG="${MDL_CFG:-$(mdl_find_config)}"
[[ -n "$MDL_CFG" ]] && MDL_CFG="-c ${MDL_CFG}"
# retrieve Markdown indentation from markdownlint config file, set default if not found
MD_IND="$(mdl_get_indent)"

function md_fix_listIndent () {
    awk -i inplace -v indent="$MD_IND" -f "${UTILDIR}/markdown/wrong_indent.awk" \
        "$(find_files "*.md" "$@")"
}

function md_fix_tagLineStart () {
    # find lines starting with tag #... and prepend with text as some Markdown parsers
    # interpret this as headings
    local -a fixfiles
    mapfile -t fixfiles < <(egrep_files '*.md' '^#[a-z]' "$@")

    for f in "${fixfiles[@]}"; do
        sed -i '/^#[a-zA-Z]/s/./Tags: &/' "$f"
    done
}

function md_fix_noTabs () {
    local -a fixfiles
    mapfile -t fixfiles < <(find_files "*.md" "$@")
    mapfile -t fixfiles < <(grep -l -P '\t' "${fixfiles[@]}")
    if [[ "${#fixfiles[@]}" -gt 0 ]]; then
        echo "* replacing tabs by spaces in ${#fixfiles[@]} file(s) ..."
        sed -i "s/\t/$(printf "%${MD_IND}s")/g" "${fixfiles[@]}"
    fi
}

function md_fix () {
    echo "Fixing Markdown body"

    md_fix_noTabs "$@"

    # linters with fix function don't reindent underindented list items well
    echo "* fixing list indentation"
    md_fix_listIndent "$@"

    echo "* fixing lines starting with tag #..."
    md_fix_tagLineStart "$@"

    # use fix functionality of [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli)
    # TODO: ensure passing paths to markdownlint works as expected
    if which markdownlint &>/dev/null; then
        mdl_log=markdownlint.log
        markdownlint $MDL_CFG -o "$mdl_log" -f "$@"
        [[ $(wc -l "$mdl_log" 2>/dev/null | awk '{print $1}') -eq 0 ]] && rm markdownlint.log || \
            echo "Unresolved Markdown issues, see ${mdl_log}"
    else
        echo "Missing Markdown linter CLI markdownlint-cli(2), skipping further fixes"
    fi

    # front matter fixes, see frontmatter.sh
    fm_fix "$@"
}

# if executed, not sourced
if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
    md_fix "$@"
fi
