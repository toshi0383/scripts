#!/bin/bash
#
# name:
#   decimal2hex.sh
#

while read line
do
    printf "%x\n" $line
done < "${1:-/dev/stdin}"
