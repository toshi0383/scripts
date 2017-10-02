#!/bin/bash
OS=${1:-'[a-z]'}
for xcode in `ls -d /Applications/Xcode*.app`
do
    case $OS in
    i[oO][sS])
        dirs="$dirs ${xcode}/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport"
        ;;
    tv[oO][sS])
        dirs="$dirs ${xcode}/Contents/Developer/Platforms/AppleTVOS.platform/DeviceSupport"
        ;;
    watch)
        dirs="$dirs ${xcode}/Contents/Developer/Platforms/WatchOS.platform/DeviceSupport"
        ;;
    [mM]ac)
        dirs="$dirs ${xcode}/Contents/Developer/Platforms/MacOSX.platform/DeviceSupport"
        ;;
    *)
        echo invalid os: $OS
        exit 1
        ;;
    esac
done
for dir in $dirs
do
    open "${dir}"
done
