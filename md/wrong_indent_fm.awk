#!/usr/bin/env awk

# Description:
# Fix indentation in YAML block scalars (multi-line strings, see
# https://yaml-multiline.info/)

BEGIN {
    if (!indent) { indent = 2 } # YAML default indentation
    fm = 0
}
 
/^---/ {fm++}

{
    fixed = 0
    l = $0; sub(/^\s*/,"",l) # line without indentation
    ind_curr = length($0) - length(l)

    if ( fm%2 == 1 && !/^---/ ) { # inside front matter

        # Block scalars (multi-line string blocks)
        if ( /:\s*[|>]/ ) { # found block scalar
            bs = 1 # active
            ind_bs = ind_curr
            if ( /^\s*-/ ) { ind_bs += 2 } # array entry
            print; next
        }
        if ( bs && /^\s*\S+:/ ) { bs = 0 } # next key, exited block scalar
        if (bs) {
            if ( ind_curr <= ind_bs ) { # line needs re-indentation
                fmt = "%" (length(l) + ind_bs + indent) "s\n"
                fixed = 1
            }
        }

        # # over-indented array elements
        # if ( /^\s*-/ ) {
        #     if ( ind_curr - ind_prev > indent ) { # over-indented
        #         fmt = "%" (length(l) + indent) "s\n"
        #         fixed = 1
        #     }
        # }

    }
    if ( fixed ) {
        printf(fmt, l)
    } else { print }

    ind_prev = ind_curr
}
