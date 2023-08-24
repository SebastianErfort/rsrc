#!/usr/bin/env bash

# === FILES & DIRECTORIES
# show file inodes
ls -i
# rm file(s) by inode
find . -inum ... -exec rm {} +

# === VARIABLES
# Variable expansion
fname=john
john=thomas
echo ${!fname} # returns thomas by double expansion
# Arrays
declare -a arr # indexed array
${arr[0]} # access entry by index
"${arr[@]}" # access entire array
${#arr[@]} # length of array, number of entries
arr+=("el1" "el2") # add elements
mapfile -t arr < <( my_cmd ) # direct output of command to array
declare -A dict # associative array

# === Arguments
$0 # command/script/shell name
$1 .. # access arguments by number
"$@" # all arguments as separate entities, preserving whitespace and quotation
"$*" # all arguments as single entity, arguments are space-separated
$# # number of arguments
shift # remove first positional parameter
# overwrite positional parameters/arguments
set -- "@{newparams[@]}"

# === Loops
# loop over file content/command output
while read -r l; do
    echo "$l"
done < myfile # or <<< $(<cmd>)

# === FUNCTIONS
# show/print function definition
declare -f function_name

# === TESTS
[[ -s /path/to/file ]] # success if file exists and has size greater 0

# === STDIN, STDOUT and exit codes
my_cmd >/dev/null 2>&1 # re-direct STDOUT and STDERR (bashism)
my_cmd >/dev/null >&2 # re-direct STDERR (bashism)
my_cmd &>/dev/null # shorthand (bashism)
# collect exit codes of commands in array using trap, then unset it
trap 'exs+=($?)' DEBUG; cmd1; cmd2; cmd3; trap - DEBUG

# === CONFIG
set -v # Print shell input lines as they are read.
set -x # Print commands and their arguments as they are executed.
set -e # Exit immediately if a pipeline returns a non-zero status, same as -o errexit
set -o errtrace # Functions and subshells inherit -e (errexit)

# === Keyboard commands
# ~. # disconnect (stuck) SSH connection
