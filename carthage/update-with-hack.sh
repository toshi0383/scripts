#!/bin/bash
#
# name:
#   update-with-hack.sh
#
# description:
#   Shrink Cartfile, perform update, then revert to original state,
#   applying updated state to Cartfile.resolved.
#   This way it's faster without unwanted clone and fetch.
#   Do not use for installing a new library. (Only for updating)
#
#   Cartfileを対象のみに絞ってからcarthage/updateを実行したのち
#   更新された情報をresolvedに反映してCartfileも戻します.
#   こうした方が余計なclone/fetchが走らないため高速です.
#   新規追加がある時は使えません.
#
#   tvOS: PLATFORM=tvOS cmdshelf run carthage/update-with-hack.sh ${LIBRARY_NAME}
#
# author:
#   Toshihiro Suzuki
#
# since:
#   2017-12-15
#
# dependencies:
#   cmdshelf
#   toshi0383/scripts
#
# copyright:
#   Copyright © 2018年 Toshihiro Suzuki, Inc. All rights reserved.
#

if [ $# -eq 0 ];then
    echo "パラメータにライブラリを1つ以上指定してください."
    exit 1
fi

if [ ! -f Cartfile.resolved ];then
    echo "Cartfile.resolvedがありません."
    exit 1
fi

MODULES=$@

for MODULE in $MODULES
do
    if ! grep $MODULE Cartfile.resolved > /dev/null
    then
        echo ライブラリ名が不正なようです: $MODULE
        exit 1
    fi
done

TMP=$(mktemp)
CARTFILE_TMP=$(mktemp)
NEWLY_RESOLVED=$(mktemp)


## Cartfileを退避して対象のみに絞る

cp Cartfile $CARTFILE_TMP

for MODULE in $MODULES
do
    grep $MODULE Cartfile >> $TMP
done

cat $TMP > Cartfile
rm $TMP

## resolvedを一旦退避
mv Cartfile.resolved $TMP

## carthage update
cmdshelf run carthage/update $@

## 新しいresolvedを一旦退避
for MODULE in $MODULES
do
    grep $MODULE Cartfile.resolved >> $NEWLY_RESOLVED
done

## 退避しておいた古いresolvedを戻し、更新された分を反映.
mv $TMP Cartfile.resolved

while read LINE
do
    MODULE=$(echo $LINE | awk '{print $2}' | sed 's/"//g')
    sed -i "" -e "s,.*${MODULE}.*,${LINE}," Cartfile.resolved
done < $NEWLY_RESOLVED

rm $NEWLY_RESOLVED

## 最後にCartfileを戻しておしまい
mv $CARTFILE_TMP Cartfile

