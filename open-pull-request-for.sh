#!/bin/sh
. ~/.bashrc
MainBranch=element/nitrogen
PR=`git log --reverse --merges --oneline  --ancestry-path $1...$MainBranch \
  | grep 'Merge pull request #' \
  | head -1 | cut -f5 -d' ' | sed -e 's/#//'`
if [ "$PR" == "" ];then
    echo PR not found.
    exit 1
fi
echo $PR
propen $PR
