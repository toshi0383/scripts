#!/bin/bash
/usr/libexec/PlistBuddy -c 'Print UUID' /dev/stdin <<< $(security cms -D -i $1)
