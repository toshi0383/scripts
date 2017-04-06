#!/bin/bash
set -eo pipefail

plbuddy='/usr/libexec/PlistBuddy'
PROJ=${1:?}
SED_FILE=$(cd $(dirname $0);pwd)/plbuddy-pretty.sed

print() {
    $plbuddy -c "Print ${1}" $PROJ
}

printBuildSettings() {
    addr=${1:?}
    targetName=${2:?}
    ConfigurationObjects=$(print objects:$addr:buildConfigurations)
    for configuration in $ConfigurationObjects
    do
        if [ "${configuration}" == "Array" ];then
            continue
        fi
        if [ "${configuration}" == "{" ];then
            continue
        fi
        if [ "${configuration}" == "}" ];then
            continue
        fi
        configurationName=$(print objects:$configuration:name)
        buildSettings=$(print objects:$configuration:buildSettings)
        echo
        echo "=== ${targetName}-${configurationName} ==="
        echo $buildSettings | sed -f $SED_FILE
    done
}

ROOTOBJ=`$plbuddy -c 'Print rootObject' AbemaTV.xcodeproj/project.pbxproj`

echo "###"
echo "### Base ###"
echo "###"
printBuildSettings $(print objects:$ROOTOBJ:buildConfigurationList) Base
targets=$(print objects:$ROOTOBJ:targets)
for target in $targets
do
    if [ "${target}" == "Array" ];then
        continue
    fi
    if [ "${target}" == "{" ];then
        continue
    fi
    if [ "${target}" == "}" ];then
        continue
    fi
    targetName=$(print objects:$target:name)
    echo
    echo "###"
    echo "### ${targetName} (Native Target) ###"
    echo "###"
    printBuildSettings $(print objects:$target:buildConfigurationList) $targetName
done
