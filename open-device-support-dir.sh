#!/bin/bash
OS=${1:-'[a-z]'}
for xcode in `ls -d /Applications/Xcode*`
do
    path=${xcode}/Contents/Developer/Platforms
    dirs="${dirs} $(find ${path} -d 2 -name DeviceSupport -type d | grep --ignore-case $OS)"
done
for dir in $dirs
do
    open "${dir}"
done
