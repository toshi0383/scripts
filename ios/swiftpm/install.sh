#!/bin/bash
APP_NAME=${1:?}
TEMPORARY_FOLDER=/tmp/${APP_NAME}.dst
rm -rf $TEMPORARY_FOLDER
mkdir -p $TEMPORARY_FOLDER 2> /dev/null
CLIENT_ID=6da3e83e315e51292de6
CLIENT_SECRET=a748acd67f2e95d6098ff29243f415133b055226

BINARY_URL=$(curl -s "https://api.github.com/repos/toshi0383/${APP_NAME}/releases?client_id=${CLIENT_ID}&client_secret=${CLIENT_SECRET}" | grep browser_download_url | head -1 | awk -F": \"" '{print $2}' | sed 's/\"//')
echo $BINARY_URL

# Download zip
cd ${TEMPORARY_FOLDER}
ZIP_NAME=${APP_NAME}.zip
curl -sLk $BINARY_URL -o ${ZIP_NAME}

# Install
unzip ${ZIP_NAME}
chmod +x usr/local/bin/$APP_NAME
install_name_tool -add_rpath "@executable_path/../Frameworks/${APP_NAME}" "usr/local/bin/${APP_NAME}"
install_name_tool -add_rpath "`xcode-select -p`/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/macosx" "usr/local/bin/${APP_NAME}"
cp -Rf usr /
