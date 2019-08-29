#!/bin/bash
#
# Usage:
#   1. Copy URL to your paste board. (e.g. via hands-off api from iPhone)
#   2. `cmdshelf run fabric/download-ipa.sh`
#
PLIST=`mktemp`
DOWNLOAD_PATH=~/Downloads/downloaded.ipa

if [ -e "$DOWNLOAD_PATH" ];then
    echo File already exists: "$DOWNLOAD_PATH"
    exit 1
fi

curl -L $(curl -s $(pbpaste | gsed -rn 's/.*=(https.*)/\1/p' | perl -MURI::Escape -ne 'print uri_escape($_)') -o $PLIST; /usr/libexec/PlistBuddy -c 'Print :items:0:assets:0:url' $PLIST; rm $PLIST) -o "${DOWNLOAD_PATH}"
if [ $? -eq 0 ];then
    say 'Downloaded an IPA file successfully.'
else
    say 'Download failed.'
fi
