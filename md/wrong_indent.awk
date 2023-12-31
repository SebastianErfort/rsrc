#!/usr/bin/env awk
# TODO: apply fixes also to ordered lists

BEGIN {
    # defaults if not set as option -v <var>=<val>
    if ( !indent ) { indent = 2 }
    if ( !fix ) { fix = 1 }
    ind_curr_was = 0; ind_curr_is = 0
    ind_prev_was = 0; ind_prev_is = 0
    lvl = 0; ind_lvl = 0
    fm=0; cb=0; lst=0
}

# front matter (ignore in code block)
/^---/ && cb%2 != 1 { fm++ }
# code blocks
/^\s*```/ { cb++ }

# MAIN
{
    fixed = 0
    l = $0; sub(/^\s*/,"",l) # line without indentation
    ind_curr_was = length($0) - length(l) # current indentation

    if ( /^\S+/ ) {
        if ( !/^\s*[-+*]/ && !/^\s*[1-9]\./ ) { lst = 0 } # exited list
        lvl = 0; ind_lvl = 0
        ind_curr_is = 0 ; ind_prev_was = 0; ind_prev_is = 0; ind_prev_li_was = 0
    }

    if ( !/^$/ && fm%2 == 0 ) {
        # Anything but a code block's content
        if ( cb%2 != 1 || /```/ ) {
            fixed = 1
            if ( /^\s*[-+*]/ || /^\s*[1-9]\./ ) { # new list item
                lst = 1
                if ( /^\s*[-+*]/ ) { # unordered list
                    # lst_type = ul
                    lst_ind = 2 # for `- `
                } else {             # ordered list
                    # list_type = ol
                    lst_ind = 3 # for `x. `
                }
                # TODO: clean up ugly quick bodge ind_prev_li_was
                ind_diff = ind_curr_was - ind_prev_li_was
                if ( ind_diff > 0 ) { lvl++ }
                if ( ind_diff < 0 ) { lvl-- }
                if ( lvl == 1 ) { indent_guess = ind_curr_was } # use as original indent
                ind_lvl = indent*lvl
                ind_curr_is = ind_lvl
                ind_prev_li_was = ind_curr_was
            } else {
                ind_diff = ind_curr_was - ind_prev_was
                if ( lst ) {
                    if ( ind_diff < 0 ) { # still in list, but back to outer level
                        lvl = int( (ind_curr_was - lst_ind) / indent_guess )
                        ind_lvl = indent*lvl
                    }
                    ind_curr_is = ind_lvl + lst_ind
                } else {
                    ind_curr_is = ind_lvl
                }

                if ( /```/ && cb%2 == 1 ) { # start of code block
                    ind_cb_was = ind_curr_was
                    ind_cb_is = ind_curr_is
                }

                # print ind_curr_was, ind_curr_is, ind_prev_was, ind_prev_is
            }
        } else { # code block content
            if ( ind_curr_was != 0 ) {
                fixed = 1
                ind_curr_is = ind_cb_is + ind_curr_was - ind_cb_was
            }
        }
    }

    if ( fixed ) {
        # print result
        fmt="%"(length(l) + ind_curr_is)"s\n" # format string re-indented line
        if ( debug ) {
            printf("%s", ind_curr_was ", " ind_curr_is ", " ind_prev_was ", " ind_prev_is ", " lvl " | ")
        }
        printf(fmt,l)
    } else {
        if ( debug ) {
            print(ind_curr_was ", " ind_curr_is ", " ind_prev_was ", " ind_prev_is ", " lvl " | " $0)
        } else {
            print
        }
    }

    if ( lst && !/^\s*$/ ) {
        ind_prev_is=ind_curr_is
        ind_prev_was=ind_curr_was
    }
}
