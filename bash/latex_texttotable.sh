#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
    echo "Error, no argument specified. Usage: $0 file"
    exit 1
fi
# FIELDWIDTHS are the column widths, so adjust as needed
# TODO Make this externally accessible
fw=(11 3 12 13 14 17 11 15 12 9 12 14)
awkstr='BEGIN { FIELDWIDTHS="'
for i in ${fw[@]}; do 
    awkstr=$(printf "$awkstr %i" $i)
done
awkstr="$awkstr\" }{print "
coln=(1 2 4 5 6 7)
for i in ${coln[@]}; do 
    awkstr=$(printf "$awkstr\$%i,\"&\"," $i)
done
awkstr="${awkstr%',"&",'},\"\\\\\\\\\"}"

awk "$awkstr" $1
