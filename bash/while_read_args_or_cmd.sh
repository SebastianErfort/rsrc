# read from CL arguments or command if none given
while read -r l; do
    echo "size: $l"
done <<< "${@:-$(lsblk -n /dev/nvme0n1 | awk '{print $4}')}"
