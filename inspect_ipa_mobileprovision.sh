# name:
#   inspect_ipa_mobileprovision.sh 
#
# description:
#   Extract ipa file and decode all embedded.mobileprovision file inside.
#
# author:
#   Toshihiro Suzuki (@toshi0383)
#
# license:
#   MIT
#

#!/bin/bash
IPA_PATH=${1:?ipa path is missing}
if [ ! -f "$IPA_PATH" ];then
    echo "No such file ${IPA_PATH}"
    exit 1
fi
tmp=`mktemp`
tmppayload=`mktemp -d`

cmsdecrypt='security cms -D -i'

unzip ${IPA_PATH} Payload/**/*mobileprovision -d $tmppayload

find $tmppayload -name "*mobileprovision" > $tmp

while read line;
do
    $cmsdecrypt $line
done < $tmp
rm $tmp
rm -rf $tmppayload
