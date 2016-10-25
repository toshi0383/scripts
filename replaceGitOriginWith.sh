#!/bin/bash
if [ $# -ne 1 ];then
    echo Please specify new origin URL.
    exit 1
fi
new=$1
current=`git remote -v | head -1 | awk '{print $2}'`
git remote add upstream $current
if [ $? -ne 0 ];then
    exit $?
fi
git remote remove origin
git remote add origin $new
git fetch --all --tag --prune
git remote -v
