#!/bin/bash
# name:
#   latest-build-time.sh
#
# description:
#   Find the latest Xcode build log file and pass it to `build-time.sh`.
#
# dependencies (Make sure you install them beforehand.)
#   - build-time.sh
#   - gls
#
# author:
#   Toshihiro Suzuki
#
# since:
#   2018-02-07
#
# copyright:
#   Copyright © 2018年 toshi0383 All rights reserved.

# Check dependencies

if ! which gls > /dev/null 2>&1
then
    echo 'gls is missing. Please install first. e.g. `brew install coreutils`'
    exit 1
fi

BUILD_TIME_SH=$(cd $(dirname $0); pwd)/build-time.sh

if [ ! -f $BUILD_TIME_SH ];then
    echo $BUILD_TIME_SH is missing.
    exit 1
fi

# Go!

if [ -z ${DERIVED_DIR} ];then

    # `find` is slow. Let's use `ls` with wild-card by default.
    LATEST_LOG_FILE=$(gls --numeric-uid-gid --time-style=+%s ~/Library/Developer/Xcode/DerivedData/**/Logs/Build/*.xcactivitylog \
        | sort -k 6 -n \
        | tail -1 \
        | awk '{print $7}')

else
    # Fallback to `find` if DERIVED_DIR is specified.
    LATEST_LOG_FILE=$(find ${DERIVED_DIR} -name "*.xcactivitylog" \
        | xargs gls --numeric-uid-gid --time-style=+%s \
        | sort -k 6 -n \
        | tail -1 \
        | awk '{print $7}')

fi

if [ ! -f "$LATEST_LOG_FILE" ];then
    echo No such file: $LATEST_LOG_FILE
    exit 1
fi

$BUILD_TIME_SH "$LATEST_LOG_FILE"
