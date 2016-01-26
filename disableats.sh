#!/bin/bash
if [ ! -f "${1}" ];then
    echo "Plist file not found: ${1}"
    exit 1;
fi
/usr/libexec/PlistBuddy -c "Add NSAppTransportSecurity:NSAllowsArbitraryLoads bool true" ${1}
