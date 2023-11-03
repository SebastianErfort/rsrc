#!/usr/bin/env bash
# DESCRIPTION: functions to process and fix the YAML front matter (in Markdown files)
# #markdown/frontmatter

UTILDIR="${UTILDIR:-.}"
. "${UTILDIR}/bash/tools.sh"

function fm_set () {
    # Set key=value in frontmatter of file
    local msg_usage="Usage: ${FUNCNAME[0]} <key> <val> <file>"
    local msg_desc="Set key=value in frontmatter of file"
    [[ $# != 3 ]] && echo "ERROR. ${msg_usage}" && return 2
    local key=${1} value=${2} path=${3}

    # find files where key isn't set to val
    if [[ -f "$path" ]]; then
        fm_ensure "$f"
        yq -f process -i ".${key}=\"${value}\"" "$f"
    else
        echo "ERROR. file/dir not found: ${path}"
    fi
}

function fm_matchFiles () {
    # Find files with front matter key=value
    # #markdown/frontmatter
    local msg_usage="Usage: ${FUNCNAME[0]} [-i] <key> <val> [<path(s)>]"
    local msg_options="\t-i\t\tinvert match\n\t-h, --help\tprint this help"
    local msg_desc="Find files with front matter key=value"
    local msg_help="${msg_usage}\n${msg_desc}\n\n${msg_options}"
    [[ "$1" == "-i" ]] && { invert=true; shift; } || invert=false
    [[ "$1" == "-h" || "$1" == "--help" ]] && { echo -e "$msg_help"; return; }
    [[ $# != 2 && $# != 3 ]] && echo -e "ERROR. ${msg_usage}" && return 2
    local key="$1" val="$2"
    shift 2
    local dir="${*:-.}"

    [[ -n "${fixfiles[*]}" ]] && unset fixfiles
    declare -ga fixfiles
    find_files fixfiles "*.md" "$dir"
    for f in "${fixfiles[@]}"; do
        if ! $invert && fm_exists "$f"; then
            [[ $(yq -f extract '.'"$key" "$f" 2>/dev/null) == "$val" ]] && files+=("$f")
        else
            if ! fm_exists "$f" || [[ $(yq -f extract '.'"$key" "$f" 2>/dev/null) != "$val" ]]; then
                files+=("$f")
            fi
        fi
    done

    unset fixfiles
}

function fm_exists () {
    # Exit 0 if frontmatter exists, else 1
    local msg_usage="Usage: ${FUNCNAME[0]} <file>"
    local msg_desc="Exit 0 if frontmatter exists, else 1"
    # TODO: allow frontmatter after first line?
    awk 'NR==1 && ! /^---/ {exit 1}' "$1"
}

function fm_ensure () {
    # Create empty frontmatter if absent
    local msg_desc="Create empty frontmatter if absent"
    fm_exists "$1" || sed -i '1i\---\n---' "$1"
}

function fm_get () {
    # Get value of key in frontmatter of file. Error with 1 if frontmatter or key are absent.
    local msg_desc="Get value of key in frontmatter of file. Error with 1 if frontmatter or key are absent."
    local msg_usage="Usage: ${FUNCNAME[0]} <file> <key>"
    fm_exists "$1" && yq -e=1 -f extract ".${2}" "$1" 2>/dev/null
}

function fm_ensureTitle () {
    # If title is missing, use file name
    local msg_desc="If title is missing, use file name"
    local msg_usage="Usage: ${FUNCNAME[0]} <file>"
    local title
    if ! fm_exists "$1" || ! fm_get "$1" title >/dev/null; then
        fm_ensure "$1"
        title="$(basename "${1}")"
        title=${title%.md}
        title=${title//_/ }
        echo "Setting title: ${title}"
        yq -f process -i ".title=\"${title}\"" "$1"
    fi
}

function fm_fix_tags_format () {
    # fix format of frontmatter tags: use array
    # Explanation: Obsidian for example accepts tags as space-separated string, others (e.g. MkDocs) require an array
    # #markdown/frontmatter
    local msg_usage="Usage: ${FUNCNAME[0]} <file>"
    grep -qi 'tags:\s\+[a-z]' "$1" && sed -i '/^tags:/s/\s\+/\n  - /g' "$1"
}

function fm_fix_unquoted () {
    # Quote problematic string values: colon, empty, ...
    # Some programs choke on parsing the fm if strings contain certain characters and aren't
    # quoted. Use yq with --style=double to quote these strings
    # Tags: #markdown #markdown/frontmatter
    local msg_desc="Quote problematic string values: colon, empty, ..."
    local msg_usage="Usage: ${FUNCNAME[0]} <file>"
    local fm

    if fm_exists "$1"; then
        fm="$(yq -f extract "$1")"
        # colon in string: quote
        # TODO: skip YAML block strings `- |` etc.
        grep -q ': .*:' <<< "$fm" && \
            yq -f process -i '(.[] | select(type=="!!str" and test(".*:.*"))) style="double"' "$1"
        # empty key: empty quote
        grep -q ':\s*$' <<< "$fm" && \
            yq -f process -i '(.[] | select(tag == "!!null")) style="double"' "$1"
        # NOTE: See https://mikefarah.gitbook.io/yq/how-it-works#complex-assignment-operator-precedence-rules
        # for an explanation of the yq command used here
    fi
}

function fm_fix () {
    # Fix YAML frontmatter (in Markdown files)
    local msg_desc="Fix YAML frontmatter (in Markdown files)"
    local msg_usage="Usage: ${FUNCNAME[0]} <path(s)>"
    local msg_options="Options:\n\t-c\tcreate fm if absent"
    local QUIET CREATE_MISSING
    [[ "$1" == "-q" || "$1" == "--quiet" ]] && { QUIET=true; shift; } || QUIET=false
    [[ "$1" == "-c" ]] && { CREATE_MISSING=true; shift; }
    local -a paths
    [[ -n "$*" ]] && paths=("$@") || paths=(".")

    [[ -n "${fixfiles[*]}" ]] && unset fixfiles
    declare -ga fixfiles # NOTE: unset when done!
    find_files fixfiles "*.md" "${paths[@]}" # collect files from path arg.s

    ! $QUIET && echo "Fixing front matter in ${#fixfiles[@]} files ..."
    for f in "${fixfiles[@]}"; do
        echo "$f"
        [[ "$CREATE_MISSING" == "true" ]] && fm_ensure "$f"
        # defaults
        fm_ensureTitle "$f"
        fm_fix_unquoted "$f"
        fm_fix_tags_format "$f"
    done
    fm_fix_blockScalars_indent "${paths[@]}"

    # last check frontmatter is valid YAML
    for f in "${fixfiles[@]}"; do
        yq -f extract "$f" 2>/dev/null | yamllint - || \
            { echo "ERROR: invalid YAML front matter in '${f}'"; }
    done

    unset fixfiles
}

function fm_fix_blockScalars_indent () {
    # Fix files with YAML block scalars without indentation of the key's value, e.g.
    # key: |
    # value  # should be indented
    # Why? For some unknown reason performing all Markdown fixes on a whole directory, as opposed
    # to single files, removes the indentation in YAML block scalars.
    # What are block scalars? Extended strings, see https://yaml-multiline.info/
    [[ -n "${allfiles[*]}" ]] && unset allfiles
    declare -ga allfiles
    local -a fixfiles
    grep_files allfiles "*.md" ":\s*[|>]" "$@"
    YAML_IND=${YAML_IND:-2}

    for f in "${allfiles[@]}"; do
        fm_exists "$f" && { sed -n '/^---/,/^---/p' "$f" | yamllint - &>/dev/null || fixfiles+=("$f"); }
    done
    echo "Files requiring fix (${#fixfiles[@]}): ${fixfiles[*]}"

    awk -v indent="$YAML_IND" \
        -i inplace \
        -f "$UTILDIR/markdown/wrong_indent_fm.awk" \
        "${fixfiles[@]}"
    unset allfiles
}
