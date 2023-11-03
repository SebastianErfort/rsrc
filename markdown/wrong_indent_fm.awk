#!/usr/bin/env awk

# Description:
# Fix indentation in YAML block scalars (multi-line strings, see https://yaml-multiline.info/)

BEGIN {
    if (!indent) { indent = 2 } # YAML default indentation
    fm = 0
    a = 0
}
 
/^---/ {fm++}

{
    if ( fm%2 == 1 && !/^---/ ) { # inside front matter
        if ( /:\s*[|>]/ ) { # found block scalar
            a = 1 # active
            l = $0; sub(/^\s*/,"",l) # line without indentation
            ind_bs = length($0) - length(l)
            if ( /^\s*-/ ) { ind_bs += 2 } # array entry
            print; next
        }
        if ( a && /^\s*\S+:/ ) { a = 0 } # next key, exited block scalar
        # print a, ind_bs, $0
        if (a) {
            l = $0; sub(/^\s*/,"",l) # line without indentation
            ind_l = length($0) - length(l)
            if ( ind_l <= ind_bs ) { # line needs re-indentation
                fmt = "%" (length(l) + ind_bs + indent) "s\n"
                printf(fmt, l)
            } else { print }
        } else { print }
    } else { print }
}
