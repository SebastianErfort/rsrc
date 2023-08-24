#!/usr/bin/env bash

lsblk -f
# -f: include filesystems

# This doesn't work on my machine
# disk=()
# size=()
# name=()
# while IFS= read -r -d $'\0' device; do
#     device=${device/\/dev\//}
#     disk+=($device)
#     name+=("`cat "/sys/class/block/$device/device/model"`")
#     size+=("`cat "/sys/class/block/$device/size"`")
# done < <(find "/dev/" -regex '/dev/sd[a-z]\|/dev/vd[a-z]\|/dev/hd[a-z]' -print0)
#
# for i in `seq 0 $((${#disk[@]}-1))`; do
#     echo -e "${disk[$i]}\t${name[$i]}\t${size[$i]}"
# done
