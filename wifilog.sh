#!/bin/bash
URL="http://pocketwifi.home/api/monitoring/traffic-statistics"
response=`curl -s $URL`
PATTERN=TotalDownload
downloadByte=`echo "$response" \
  | grep $PATTERN \
  | sed -e "s/<TotalDownload>//g" -e "s~</TotalDownload>~~g"`
if [ ! $downloadByte ];then
    exit 1;
fi
downloadGigaByte=`expr $downloadByte / 1024 / 1024 / 1024` #切り捨て御免
echo "["`date "+%Y/%m/%d %H:%M:%S"`"]:" $downloadGigaByte "GB"
