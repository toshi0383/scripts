#!/bin/bash
APP_NAME=${1:?}
BINARY_URL=$(curl -s https://api.github.com/repos/toshi0383/${APP_NAME}/releases | grep browser_download_url | head -1 | awk -F": \"" '{print $2}' | sed 's/\"//')
echo $BINARY_URL
curl -sLk $BINARY_URL -o $APP_NAME
chmod +x $APP_NAME
install_name_tool -add_rpath `xcode-select -p`/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/macosx $APP_NAME
mv $APP_NAME /usr/local/bin
