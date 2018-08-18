#!/bin/bash
#
# warning: never tested. Use this on your own risk.
#
PLATFORMS="AppleTVOS iPhoneOS WatchOS"

for platform in $PLATFORMS
do
    for origin in `ls -d /Applications/Xcode*.app/Contents/Developer/Platforms/${platform}.platform/DeviceSupport/`
    do
        for dest in $(ls -d /Applications/Xcode*.app/Contents/Developer/Platforms/${platform}.platform/DeviceSupport/ | grep -v $x)
        do
            rsync -r $origin/* $dest
        done
    done
done

