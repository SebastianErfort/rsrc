function mdl_get_indent () {
    # retrieve Markdown indentation from markdownlint config file, set default if not found
    [[ -n "$MDL_CFG" ]] && { yq -e=1 '.MD007.indent' "$MDL_CFG" 2>/dev/null | grep "[0-9]\+"; } || \
        echo 4
}

function mdl_find_config () {
    # search markdownlint config file
    # TODO: add common locations
    if [[ -z "$MDL_CFG" ]]; then
        [[ -f .markdownlint.yaml ]] && echo ".markdownlint.yaml"
        [[ -f markdownlint.yaml ]] && echo "markdownlint.yaml"
    fi
}
