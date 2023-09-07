#!/usr/bin/env bash

curl -X POST 'https://api-free.deepl.com/v2/translate' \
--header "Authorization: DeepL-Auth-Key $DEEPL_APIKEY" \
--data-urlencode 'text=Hello, world!' \
--data-urlencode 'target_lang=DE' 
