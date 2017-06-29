#!/bin/bash
#
# name:
#   install.sh
#
# description:
#   Download latest release from GitHub and install.
#   Uploaded binary must be created with release.sh.
#
# parameters:
#   1: "user/app" ... your github repository name. (e.g. toshi0383/cmdshelf)
#
# author:
#   Toshihiro Suzuki
#
# since:
#   2017-06-29
#
# copyright:
#   Copyright © 2017 Toshihiro Suzuki All rights reserved.
#

REPO_NAME=${1:?}
# Separate an argument by '/'
OLD_IFS=$IFS; IFS=/; set -- $@; IFS=$OLD_IFS
# e.g. toshi0383/cmdshelf => cmshelf
APP_NAME=${2:?}

TEMPORARY_FOLDER=/tmp/${APP_NAME}.dst
rm -rf $TEMPORARY_FOLDER
mkdir -p $TEMPORARY_FOLDER 2> /dev/null
CLIENT_ID=6da3e83e315e51292de6
CLIENT_SECRET=a748acd67f2e95d6098ff29243f415133b055226

# Get binary URL via github api
BINARY_URL=$(curl -s "https://api.github.com/repos/${REPO_NAME}/releases?client_id=${CLIENT_ID}&client_secret=${CLIENT_SECRET}" | grep browser_download_url | head -1 | awk -F": \"" '{print $2}' | sed 's/\"//')
echo $BINARY_URL

# Download zip
cd ${TEMPORARY_FOLDER}
ZIP_NAME=${APP_NAME}.zip
curl -sLk $BINARY_URL -o ${ZIP_NAME}

# Install
unzip ${ZIP_NAME}
chmod +x usr/local/bin/$APP_NAME
install_name_tool -add_rpath "@executable_path/../Frameworks/${APP_NAME}" "usr/local/bin/${APP_NAME}"
cp -Rf usr /
