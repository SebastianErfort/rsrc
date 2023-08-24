#!/usr/bin/env bash

# TODO
# - refactor
#   - reduce code replication: generalise and recycle loops
#   - cli: parse arguments
#     - filters/target files

function md_fix_list_indent () {
    # FIXME
    echo "awk scripts don't work properly, do not use!"
    # fix missing preceeding empty line breaking rendering of lists
    BASEDIR=${BASEDIR:-\.}

    mapfile -t mdfiles < <(find . -name '*.md') # all files
    declare -a fixfiles                         # files with issue
    for (( i=0; i<${#mdfiles[@]} ; i++ )); do
        f=${mdfiles[$i]}
        [[ -n $(awk -f "$BASEDIR/utils/wrong_indent_find.awk" "$f") ]] && \
            fixfiles+=("$f")
    done

    for (( i=0; i<${#fixfiles[@]} ; i++ )); do
        f=${fixfiles[$i]#\./}
        echo "Fixing $f"
        echo awk -f "$BASEDIR/utils/wrong_indent_fix.awk" "$f" > "$f.tmp"
        # writing directly results in empty files
        mv "$f.tmp" "$f"
    done

    echo -e "----------\nFixed $i files"
}

function md_fix_lists_empty_line () {
    # NOTE: obsolete, use markdownlint instead
    # fix missing preceeding empty line breaking rendering of lists
    BASEDIR=${BASEDIR:-\.}

    mapfile -t mdfiles < <(find . -name '*.md') # all files
    declare -a fixfiles                         # files with issue
    for (( i=0; i<${#mdfiles[@]} ; i++ )); do
        f=${mdfiles[$i]}
        [[ ! -z $(awk -f $BASEDIR/utils/regexps_differentlines_find.awk "$f") ]] && \
            fixfiles+=("$f")
    done

    for (( i=0; i<${#fixfiles[@]} ; i++ )); do
        f=${fixfiles[$i]#\./}
        echo "Fixing $f"
        awk -f $BASEDIR/utils/regexps_differentlines_insert.awk "$f" > "$f.tmp"
        # writing directly results in empty files
        mv "$f.tmp" "$f"
    done

    echo -e "----------\nFixed $i files"
}

function md_fix_linestart_obsidian-tag () {
    # find lines starting with obsidian tag #... and prepend with text as some Markdown parsers
    # interpret this as headings
    #markdown/obsidian
    mapfile -t mdfiles < <(grep -irnl --include='*.md' '^#[a-z]')

    # note: array needs access by index bc. of items with ws
    for (( i=0; i<${#mdfiles[@]} ; i++ )); do
        f=${mdfiles[$i]}
        sed -i '/^#[a-zA-Z]/s/./Tags: &/' "$f"
    done
}

function fm_fix_tags_format () {
    # fix format of frontmatter tags: Obsidian accepts space separator - use YAML array format instead
    #markdown/frontmatter

    mapfile -t mdfiles < <(find . -name '*.md' -print0 | xargs -0 grep -il 'tags:\s\+[a-z]')

    # note: array needs access by index bc. of items with ws
    for (( i=0; i<${#mdfiles[@]} ; i++ )); do
        f=${mdfiles[$i]}
        echo "Fixing $f"
        sed -i '/^tags:/s/\s\+/\n  - /g' "$f"
    done
    echo -e "----------\nFixed $i files"
}

function fm_add_if_missing () {
    # add YAML front matter if absent
    #markdown/frontmatter
    mapfile -t mdfiles < <(find . -name "*.md")
    for (( i=0 ; i<${#mdfiles[@]} ; i++ )); do
        f=${mdfiles[$i]}
        [[ "$f" =~ $1 ]] && \
            [[ ! $(head -1 "$f") =~ "---" ]] && \
            awk '{if (NR==1 && $0 !~ /^---$/) {$0="---\n---\n"$0}; print}' "$f" > "$f.tmp" && \
            mv "$f.tmp" "$f"
    done
}

function fm_update_key () {
    # update/set key: value in YAML front matter
    #markdown/frontmatter
    mapfile -t mdfiles < <(find . -name "*.md")
    for (( i=0 ; i<${#mdfiles[@]} ; i++ )); do
        f=${mdfiles[$i]}
        [[ "$f" =~ $1 ]] && \
            yq -i -f process '.'"$2"'="'"$3"'"' "$f"
    done
}

function fm_fix_unquoted () {
    # Some programs choke on parsing the fm if strings contain certain characters and aren't
    # quoted. Use yq with --style=double to quote these strings
    # Tags: #markdown #markdown/frontmatter
    local -a allfiles
    mapfile -t allfiles < <(find . -name '*.md')
    for (( i=0; i<${#allfiles[@]} ; i++ )); do
        fixing=false
        f=${allfiles[$i]}
        # Only files with front matter
        { skipfile "$f" || [[ $(grep -c '^---$' "$f") -lt 2 ]]; } && continue

        # offending string: colon
        # TODO skip YAML block strings `- |` etc.
        yq -f extract "$f" | grep -q ': .*:' && \
            fixing=true && \
            yq -f process -i '(.[] | select(type=="!!str" and test(".*:.*"))) style="double"' "$f"
        # offending empty key
        yq -f extract "$f" | grep -q ':\s*$' && \
            fixing=true && \
            yq -f process -i '(.[] | select(tag == "!!null")) style="double"' "$f"
        # NOTE See https://mikefarah.gitbook.io/yq/how-it-works#complex-assignment-operator-precedence-rules
        # for an explanation of the yq command used here
        $fixing && echo "Fixed file $f"
    done
}

function skipfile () {
    false
}
