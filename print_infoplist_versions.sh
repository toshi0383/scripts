#!/bin/bash
DIR=${1:?}
for i in `find "$DIR" -name "*plist"` ;do result=`plutil -p ${i}|grep CFBundleShortVersionString`;echo "$result" ${i}; done
for i in `find "$DIR" -name "*plist"` ;do result=`plutil -p ${i}|grep CFBundleVersion`;echo "$result" ${i}; done
