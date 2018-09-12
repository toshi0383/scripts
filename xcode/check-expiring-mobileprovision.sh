#!/bin/bash
#
# name:
#   check-expiring-mobileprovision.sh
#
# description:
#   Search for expiring mobileprovision file and prints them in console.
#
# parameter:
#   - files list
#
# author:
#   鈴木  俊裕
#
# dependency:
#   - gdate: to format date string to unixtime
#
# copyright:
#   Copyright © 2018年 toshi0383 All rights reserved.
#
# license:
#   MIT
#

if [ $# -eq 0 ];then
    echo "no files given."
    echo "  e.g."
    echo "    $0 \$(ls certs/*mobileprovision)"
    exit 1
fi

for m in $@
do
    security cms -D -i "$m" > a

    d=$(/usr/libexec/PlistBuddy -c 'Print ExpirationDate' a)

    if [ $(gdate -d "$d" +%s) -lt $(expr $(date +%s) + 43200) ]; then
        # Expires in less than 30 days
        echo $m : $d
        STATUS=1
    fi

    rm a
done

exit $STATUS
