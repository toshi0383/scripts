#!/bin/bash

# Original script:
#   https://gist.github.com/AndyIbanez/7715e6849adaa8d27e0207d585dde139

# Takes a 1024x1024 app icon and produces all app icon sizes based on it.
# Requires imagemagick to work.
# USAGE iair ORIGINAL_FILE PATH_TO_OUTPUT_DIR
# Example: iair icon.png .

if ! which convert > /dev/null
then
    echo Please install imagemagick. e.g. \`brew install imagemagick\`
    exit 1
fi

original_file=$1
output_dir=$2

if [ ! -f $original_file ]; then
	echo 'File $original_file not found'
	exit
fi

if [ ! -e "$output_dir" ];then
    mkdir -p "$output_dir"
fi

#Array of all required sizes
declare -a sizes=(
"20.0"
"29.0"
"40.0"
"60.0"
"76.0"
"83.5"
"40.0"
"58.0"
"80.0"
"120.0"
"152.0"
"167.0"
"60.0"
"87.0"
"120.0"
"180.0"
"228.0"
"250.5"
"1024"
)

for size in ${sizes[@]}
do
  convert $original_file -resize $size'x'$size "$output_dir/Icon-$size.png"
done
