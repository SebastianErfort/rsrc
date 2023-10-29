# save awk output to bash variables
val="hello|beautiful|world" # assume this string comes from a database query
read a b c <<< $( echo ${val} | awk -F"|" '{print $1" "$2" "$3}' )
echo "$a $b $c" # hello beautiful world
