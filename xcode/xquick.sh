#!/bin/bash
FILE=${1:?}
sed -i "" -e 's/  describe/  xdescribe/;s/  context/  xcontext/;s/  it/  xit/' "$FILE"
