#!/bin/bash
#
# name:
#   release.sh
#
# description:
#   Archive your SwiftPM executable.
#   Created zip is intended to distributed via GitHub releases page and installed by using install.sh.
#   Executable should be built with `-static-stdlib` option.
#     e.g. `swift build -c release -Xswiftc -static-stdlib`
#
# parameters:
#   1: executable name ... e.g. cmdshelf
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

APP_NAME=${1:?}

RELEASE_DIR=.build/release
EXECUTABLE=${RELEASE_DIR}/${APP_NAME}
DOC=docs/man
install_name_tool -delete_rpath `xcode-select -p`/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/macosx $EXECUTABLE
mkdir -p usr/local/bin
cp $EXECUTABLE usr/local/bin/

# manual pages
MAN_DIR=doc/man
MAN_PREFIX=usr/local/share
mkdir -p $MAN_PREFIX
cp -R $MAN_DIR $MAN_PREFIX/

zip -r ${APP_NAME}.zip usr
