[ ! -f test.txt ] && echo 'enter disk name /dev/xxx' && read dev && sudo parted $dev unit B print free
