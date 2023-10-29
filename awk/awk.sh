---
title: AWK
tags: [awk, bash]
refs: ["https://pement.org/awk/awk1line.txt"]
---

# print last column of file
awk '{print $(NF)}' file

# Filter out empty lines
awk '!/^$/{print $0}' myfile

# Print specific line
awk 'NR == line_number {print}'

# Substitute a string/pattern by another
awk 'gsub(/pat/,"repl")'

# Sum column in file where another column matches a regular expression
[[ $# -ne "4" ]] && echo "Error. Usage: $0 col_to_match regex col_to_sum file" && exit 2
awk_str=$(printf '$%s ~ /%s/ {sum += $%s} END {print sum}' "$1" "$2" "$3")
awk "${awk_str}" "${4}"

# Modify and print values in key-value pairs where key matches regex
info=$(sudo blkid "/dev/$dev" | awk '{
  for(i=1;i<=NF;i++) {
      if(match($i,/\<UUID\>/) || match($i,/\<LABEL\>/)) {
        split($i,arr,/=/); print arr[2]}
      }
 awk '!/^$/{print $0}' myfile }' | tr -d '"')

# Apply changes in-place
awl -i inplace <awk command>
