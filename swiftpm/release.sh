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
#   2..: required framework name[s] if needed ... e.g. libCYaml.dylib
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
shift
RELEASE_DIR=.build/release
EXECUTABLE=${RELEASE_DIR}/${APP_NAME}
DOC=docs/man
install_name_tool -delete_rpath `xcode-select -p`/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/macosx $EXECUTABLE
mkdir -p usr/local/Frameworks/${APP_NAME}
for lib in $@
do
	install_name_tool -change "$(pwd)/.build/release/${lib}" "@rpath/${lib}" $EXECUTABLE
	LIB=${RELEASE_DIR}/${lib}
	cp -R $LIB usr/local/Frameworks/${APP_NAME}/
done
mkdir -p usr/local/bin
cp $EXECUTABLE usr/local/bin/

# manual pages
MAN_DIR=doc/man
MAN_PREFIX=usr/local/share
mkdir -p $MAN_PREFIX
cp -R $MAN_DIR $MAN_PREFIX/

zip -r ${APP_NAME}.zip usr
