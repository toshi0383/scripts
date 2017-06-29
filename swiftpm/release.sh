#!/bin/bash
APP_NAME=${1:?}
RELEASE_DIR=.build/release
EXECUTABLE=${RELEASE_DIR}/${APP_NAME}
LIBCYAML_DYLIB=${RELEASE_DIR}/libCYaml.dylib
install_name_tool -delete_rpath `xcode-select -p`/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/macosx $EXECUTABLE
install_name_tool -change "$(pwd)/.build/release/libCYaml.dylib" "@rpath/libCYaml.dylib" $EXECUTABLE
mkdir -p usr/local/bin
mv $EXECUTABLE usr/local/bin/
mkdir -p usr/local/Frameworks/${APP_NAME}
mv $LIBCYAML_DYLIB usr/local/Frameworks/${APP_NAME}/
zip -r ${APP_NAME}.zip usr
