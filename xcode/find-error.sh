#!/bin/bash
#
# this script is work in progress
#
f=${1:?}
grep -v export $f |
    grep -v write-file |
    grep -v builtin- |
    grep -v CpHeader |
    grep -v cd\  |
    grep -v ^[0-9] |
    sed '/^$/d'
