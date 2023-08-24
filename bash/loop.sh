# loop over file content
while read l; do
    echo $l
done < myfile
# loop over command output
while read l; do
    echo $l
done <<< $(mycmd)
