#!/bin/bash
# from https://www.howtogeek.com/814925/linux-signals-bash/

trap "echo 'do not interrupt me!'" SIGINT # SIGQUIT SIGTERM

graceful_shutdown()
{
  echo -e "\nRemoving temporary file:" "$temp_file"
  rm -rf "$temp_file"
  exit
}

temp_file=$(mktemp -p /tmp tmp.XXXXXXXXXX)
echo "Created temporary file: ${temp_file}"

counter=0

while true
do 
  echo "Loop number:" $((++counter))
  sleep 1
done
