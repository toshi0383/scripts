#!/bin/bash
for BUILD_SLUG in $(curl -sS -H "Authorization: token $BITRISE_API_TOKEN" "https://api.bitrise.io/v0.1/apps/${APP_SLUG:?}/builds?status=2&limit=10" | jq '.data | map(.slug)' | gsed -nr -e 's/.*"(.*)".*/\1/p')
do
    LOG_URL=$(curl -sS -H "Authorization: token $BITRISE_API_TOKEN" "https://api.bitrise.io/v0.1/apps/${APP_SLUG}/builds/${BUILD_SLUG}/log" | jq .expiring_raw_log_url)
    echo "$LOG_URL" | xargs curl > ${BUILD_SLUG}.log
done
