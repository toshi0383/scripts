#!/bin/bash
File=${1:?}
h=`sips -g pixelHeight $File | grep pixelHeight | awk '{print $2}'`
w=`sips -g pixelWidth  $File | grep pixelWidth  | awk '{print $2}'`
echo "${w}x${h}"
