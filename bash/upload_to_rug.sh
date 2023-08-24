#!/bin/bash

# usage: `bash upload_to_groningen.sh /path/to/raw/data NAME_OF_FOLDER_ON_DESINATION`
server="eht@ssh.lwp.rug.nl"
upload_partition="/tmphome/eht"

function upload() {
	# resolves link for the input folder
	# calculates its size
	# sends notification that upload has started
	# and starts the upload with proper flags
	# notifying everyone if it has failed
        SOURCE=$(realpath "$1")
        SOURCE_NAME="${SOURCE##*/}"
        TARGET=$2
        curl -d "$(date +%F-%T): started uploading data, total size $(du -sh "${SOURCE}" | awk '{print $1}') to RUG" ${NTFY}
        rsync -aHhP --numeric-ids --ignore-existing --progress -e "ssh -T -o Compression=no -x" "$SOURCE" \
                ${server}:${upload_partition}/${TARGET} \
                && curl -d "Uploaded ${SOURCE_NAME} to RUG" ${NTFY} \
                || curl -d "Failed to upload ${SOURCE_NAME} to RUG" ${NTFY}
}

export NTFY="ntfy.sh/rug_upload"

if [[ -z "$2" ]]; then
	T=$(date +%F)
else
	T=$2
fi

upload $1 ${T}
