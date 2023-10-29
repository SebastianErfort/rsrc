#!/usr/bin/env bash
# DESCRIPTION: collection of tools to modify Markdown file body, mainly fixing syntax. For front
# matter see frontmatter.sh.

# TODO
# - refactor
#   - reduce code replication: generalise and recycle loops
#   - cli: parse arguments
#     - filters/target files

function md_fix_listIndent () {
    # FIXME
    echo "awk scripts don't work properly, do not use!"
    # fix missing preceeding empty line breaking rendering of lists
    UTILDIR=${UTILDIR:-.}

    # use markdownlint with specific tag(s)/rules to find files
    declare -ga mdfiles
    find_files mdfiles '*.md' .
    declare -a fixfiles
    for f in "${mdfiles[@]}"; do
        [[ -n $(awk -f "$UTILDIR/utils/wrong_indent_find.awk" "$f") ]] && \
            fixfiles+=("$f")
    done

    echo -e "Fixing ${#fixfiles[@]} files"
    for f in "${fixfiles[@]}"; do
        echo awk -i inplace -f "$BASEDIR/utils/wrong_indent_fix.awk" "$f"
    done
    unset mdfiles
}

function md_fix_tagLineStart () {
    # find lines starting with obsidian tag #... and prepend with text as some Markdown parsers
    # interpret this as headings
    #markdown/obsidian
    mapfile -t mdfiles < <(grep -irnl --include='*.md' '^#[a-z]')

    for f in "${mdfiles[@]}"; do
        sed -i '/^#[a-zA-Z]/s/./Tags: &/' "$f"
    done
}

main () {
    md_fix_listIndent
    md_fix_tagLineStart
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then # if executed, not sourced
    main
fi
