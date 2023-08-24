#!/bin/bash
# See https://lifesaver.codes/answer/get-the-error-no-encrypted-data-with-known-secret-key-found-in-stream-on-any-new-passwords-173
set -euo pipefail
export IFS=$'\n\t'

export KEYID=49EE7315E9688BCBB800329D7038C1E4E8610C47 # Put your key id here

GPG=$(which gpg) # the path for the gpg program
PASSWORD_STORE_DIR=${PASSWORD_STORE_DIR:=$HOME/.password-store}
TEMP_DIR=$(mktemp --directory)

for path in $(find ${PASSWORD_STORE_DIR} -iname '*.gpg'); do
  echo "Processing ${path}"
  temp_file="${TEMP_DIR}/${path##*/}"

  ${GPG} -q --decrypt "${path}" | ${GPG} --no-throw-keyids --encrypt -r $KEYID --output "${temp_file}"

  mv -f "${temp_file}" "${path}"
done
rm -r "${TEMP_DIR}"

echo
echo "Creating git commit with all the changes"
read -n 1 -s -r -p "Press any key to continue, ctrl+c to stop"
echo
pass git commit -a -m "Adding key ids (i.e. gpg --no-throw-keyids)"

echo
echo "Pushing the commit"
read -n 1 -s -r -p "Press any key to continue, ctrl+c to stop"
echo
pass git push
