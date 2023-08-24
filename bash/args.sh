#!/usr/bin/env bash

# special variables
$0 # command/script name
$1 .. # access arguments by number
"$@" # all arguments as separate entities, preserving whitespace and quotation
"$*" # all arguments as single entity, arguments are space-separated
$# # number of arguments

shift # remove first positional parameter

# overwrite positional parameters/arguments
newparams=("foo" "bar")
set -- "@{newparams[@]}"

# remove argument
unset "${newparams[1]}"
set -- "${newparams[@]}"

# pass array to function by passing the name and creating a name reference
arr1=(3 5 7)
function arg_array () {
    local -n arg=$1
    echo "${arg[$2]}"
}
arg_array arr1 2
