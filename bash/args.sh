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
    eval "local -n arg=${1}" # create name ref.
    echo "${arg[$2]}"
}
arg_array arr1 2 # pass name of external array

# use slice/range of argument array $@
function arg_slice () {
    echo "${@:2}" # starts counting at 1, not 0!
}
arg_slice 0 1 2 3 # returns 1 2 3, not 2 3!
