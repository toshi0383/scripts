#!/bin/bash
# name:
#   fix-framework-infoplist-if-needed.sh
#
dir=${1:?}
if [ ! -d "$dir" ];then
    echo "Directory not found: ${dir}"
    exit 1
fi
for i in `find $dir -name "*.plist"`; do
    plutil -remove 'UIRequiredDeviceCapabilities' "$i"
done;

