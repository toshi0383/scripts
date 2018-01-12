#!/bin/bash
#
# this script is work in progress
#
f=${1:-"/dev/fd/0"}
cat $f |
    grep -v export |
    grep -v write-file |
    grep -v builtin- |
    grep -v CpHeader |
    grep -v cd\  |
    grep -v ^[0-9] |
    sed '/^$/d'
