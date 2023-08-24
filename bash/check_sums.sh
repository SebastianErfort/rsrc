# Retrieve check sum and perform check against local files
alias algorithm='md5sum'
curl -s $URL | algorithm -c --status --ignore-missing
# -c: check sums
# --status: silent, only exit code reports status
# --ignore-missing: don't give error for missing files
