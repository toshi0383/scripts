#!/bin/bash
#
# name:
#   build-time.sh
#
# description:
#   Extracts build log and prints build duration per file.
#   Output is sorted in descending order of compile time.
#
#   Make sure to build with these `OTHER_SWIFT_FLAGS`:
#     -Xfrontend -debug-time-function-bodies
#
# parameters:
#   - 1 (Optional): Log file name. Reads stdin if omitted.
#
# usage:
#   You can either use stdin or filename parameter.
#   e.g.
#     `echo $log_file | ./build-time.sh`
#     `./build-time.sh $log_file`
#
#   You may want to filter output like this.
#      `./build-time.sh $log_file | head`
#      `./build-time.sh $log_file | grep YourSpecificFile.swift
#
#   Invoke via cmdshelf
#      `cmdshelf run build-time.sh $log_file`
#      `make build | cmdshelf run build-time.sh`
#
#      https://github.com/toshi0383/cmdshelf
#
# dependencies (Make sure you install them beforehand.)
#   - mac2unix
#   - gnu-sed
#
# author:
#   Toshihiro Suzuki
#
# since:
#   2018-02-05
#
# copyright:
#   Copyright © 2018年 toshi0383 All rights reserved.
#

LOG_FILE=${1:-/dev/stdin}

# Check dependencies
if ! which mac2unix > /dev/null 2>&1
then
    echo 'mac2unix is missing. Please install first. e.g. `brew install dos2unix`'
    exit 1
fi

if ! which gsed > /dev/null 2>&1
then
    echo 'gnu-sed is missing. Please install first. e.g. `brew install gnu-sed`'
    exit 1
fi

EXTRACT_FILE_AND_DURATION='s?(^|.*")([0-9]+\.[0-9]+)ms\t.*/(.*\.swift)(.*)?\3 \2 \4,?p'
SUMMARIZE_PER_FILE='{if(o!=$1){i+=1;n[i]=$1}sum[i]+=$2;o=$1;}END{for(key in sum){print n[key]": "sum[key]}}'

cat $LOG_FILE \
    | gzcat 2> /dev/null \
    | mac2unix \
    | gsed -nr "$EXTRACT_FILE_AND_DURATION" \
    | sort -u \
    | awk "$SUMMARIZE_PER_FILE" \
    | sort -k 2 -nr


if [ ${PIPESTATUS[1]} -ne 0 ];then

    # Maybe it wasn't gzip input.
    # Try again as if it's redirect from xcodebuild's output.
    cat $LOG_FILE \
        | mac2unix \
        | gsed -nr "$EXTRACT_FILE_AND_DURATION" \
        | sort -u \
        | awk "$SUMMARIZE_PER_FILE" \
        | sort -k 2 -nr
fi
