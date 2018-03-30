#!/bin/bash
#
# description:
#   Download recent errored build logs into current directory.
#
# usage:
#   APP_SLUG=abcdefghijk download-recent-error-logs.sh 1
#
# parameter 1: fetch limit
#
LIMIT=${1:-1}
for BUILD_SLUG in $(curl -sS -H "Authorization: token $BITRISE_API_TOKEN" "https://api.bitrise.io/v0.1/apps/${APP_SLUG:?}/builds?status=2&limit=${LIMIT}" | jq '.data | map(.slug)' | gsed -nr -e 's/.*"(.*)".*/\1/p')
do
    LOG_URL=$(curl -sS -H "Authorization: token $BITRISE_API_TOKEN" "https://api.bitrise.io/v0.1/apps/${APP_SLUG}/builds/${BUILD_SLUG}/log" | jq .expiring_raw_log_url)
    echo "$LOG_URL" | xargs curl > ${BUILD_SLUG}.log
done
