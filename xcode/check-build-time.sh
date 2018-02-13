#!/bin/bash
#
# name:
#   check-build-time.sh
#
# description:
#   Print build time of Swift files which you have changed in this branch.
#   Note that if you cancelled the last build, result would be empty.
#
# dependencies (Make sure you install them beforehand.)
#   - latest-build-time.sh
#   - build-time.sh
#
# options
#
#   -b <branch name>
#       Base branch to compare with. Defaults to master.
#
#   -l <Xcode build log output file>
#       Use given log file instead of the automatically found latest log.
#       Latest build log is used if omitted.
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

WORKSPACE=$(cd $(dirname $0); pwd)
LATEST_BUILD_TIME_SH=${WORKSPACE}/latest-build-time.sh
BUILD_TIME_SH=${WORKSPACE}/build-time.sh

if [ ! -f $LATEST_BUILD_TIME_SH ];then
    echo $LATEST_BUILD_TIME_SH is missing.
    exit 1
fi

if [ ! -f $BUILD_TIME_SH ];then
    echo $BUILD_TIME_SH is missing.
    exit 1
fi

# Options

while getopts l:b: OPT
do
    case $OPT in
        l)  LOG_FILE=$OPTARG
            ;;
        b)  BASE_BRANCH=$OPTARG
            ;;
        *)
            ;;
    esac
done

BASE_BRANCH=${BASE_BRANCH:-master}

# Go!

MODIFIED_FILE_NAMES=$(mktemp)

# Get modified files
git diff --name-status ${BASE_BRANCH}..HEAD \
    | gsed -nr 's?.*/(.*.swift)$?\1?p' \
    > $MODIFIED_FILE_NAMES

# Filter by modified files
if [ ! -z "$LOG_FILE" ]; then
    $BUILD_TIME_SH "$LOG_FILE" | grep -f $MODIFIED_FILE_NAMES
else
    $LATEST_BUILD_TIME_SH | grep -f $MODIFIED_FILE_NAMES
fi

rm $MODIFIED_FILE_NAMES
