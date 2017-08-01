#!/bin/bash
# name:
#   fix-framework-version.sh
#
# description:
#   指定されたディレクトリ配下にあるInfo.plistの中身をAppStoreでエラーにならないように修正します.
#   注意：面倒なのでバージョンはCFBundleVersionもCFBundleShortVersionStringも全部1 になります.
#         ライブラリのCFBundle...なんて大抵は関係ないでしょう.
#
dir=${1:?}
if [ ! -d "$dir" ];then
    echo "Directory not found: ${dir}"
    exit 1
fi

prompt() {
    echo -n "${1}?:"
    read line
    echo $line
}
major=`prompt CFBundleVersion(major)`
minor=`prompt CFBundleShortVersionString(minor)`

for i in `find $dir -name "*.plist"`; do
    plutil -replace 'CFBundleShortVersionString' -string ${major} "$i"
    plutil -replace 'CFBundleVersion' -string ${minor} "$i"
done

