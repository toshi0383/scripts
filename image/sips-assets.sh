#!/bin/bash
#
# name:
#   sips-assets.sh
#
# description:
#   Generate given size of @1x,@2x,@3x variants using `sips` utility.
#   Looks for *.png in current directory and generate all variants by default.
#   Make sure the original images are large enough to correctly generate the largest variant of resolution.
#
#   svg2png:
#      http://svgtopng.com

GIVEN_SIZE=${1:?Please specify target image size.}

for line in `ls *.png`
do
    line=${line}
    for n in `seq 1 3`
    do
        NEW_FILENAME=$(echo $line | gsed -rn "s/(.*)(\.png)/\1@${n}x\2/p")
        cp $line "$NEW_FILENAME"
        sips -Z $(expr $n \* $GIVEN_SIZE) $NEW_FILENAME
    done
done
