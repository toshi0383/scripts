#!/bin/bash
BASEDIR=$(cd $(dirname $0);pwd)
PROJ=${1:?}
XCCONFIG_OUT_DIR=${2:-.}
$BASEDIR/extract-build-settings-to-xcconfigs.sh $PROJ $XCCONFIG_OUT_DIR
awk -F= -f $BASEDIR/filter-build-settings.awk $PROJ > a && mv a $PROJ

