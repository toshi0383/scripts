#!/bin/bash
OS=${1:-'[a-z]'}
PLATFORMS="AppleTVOS iPhoneOS WatchOS"
TMP=$(mktemp)

for platform in $PLATFORMS
do
    :>$TMP
    for xcode in `ls -d /Applications/Xcode*.app`
    do
        path=${xcode}/Contents/Developer/Platforms/${platform}.platform/DeviceSupport/
        cd $path
        ls -d $PWD/* >> $TMP
    done
    # echo "======= ${platform} ======="
    # cat $TMP
    for xcode in `ls -d /Applications/Xcode*.app`
    do
        while read dir
        do
            path=${xcode}/Contents/Developer/Platforms/${platform}.platform/DeviceSupport/
            cp -fR "$dir" $path/ 2> /dev/null
        done < $TMP
    done
done

