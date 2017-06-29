#!/bin/bash
APP_NAME=${1:?}
shift
RELEASE_DIR=.build/release
EXECUTABLE=${RELEASE_DIR}/${APP_NAME}
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
zip -r ${APP_NAME}.zip usr
