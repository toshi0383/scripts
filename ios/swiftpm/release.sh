#!/bin/bash
APP_NAME=${1:?}
EXECUTABLE=.build/release/${APP_NAME}
install_name_tool -delete_rpath `xcode-select -p`/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/macosx $EXECUTABLE
