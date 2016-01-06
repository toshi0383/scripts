#!/bin/bash
if [ ! -f "${1}" ];then
    echo "Plist file not found: ${1}"
    exit 1;
fi
defaults write "${1}" NSAppTransportSecurity -dict NSAllowsArbitraryLoads "<true/>"
