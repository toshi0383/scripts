#!/bin/bash
SETTING_DIR=/Users/$USER/Setting

cat > ~/.bashrc << EOF
alias ll='ls -l'
alias lrt='ls -lrt'
alias g='git'

source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash

export EDITOR=vi
export XCODE_FILE_TEMPLATES_DIR="/Users/$USER/Library/Developer/Xcode/Templates/File Templates/Custom"

export ANDROID_HOME=/Users/$USER/Library/Android/sdk/
export ANDROID_PLATFORM_TOOLS=$ANDROID_HOME/platform-tools
export ANDROID_TOOLS=$ANDROID_HOME/tools
if [ -d $ANDROID_TOOLS ];then
  export PATH=$PATH:$ANDROID_PLATFORM_TOOLS:$ANDROID_TOOLS
fi

export MAVEN_HOME=$SETTING_DIR/apache-maven-3.2.5
if [ -d $MAVEN_HOME ];then
  export PATH=$PATH:$MAVEN_HOME/bin
fi

export JD_CMD_HOME=$SETTING_DIR/jd-cmd/
if [ -d $JD_CMD_HOME ];then
  export PATH=$PATH:$JD_CMD_HOME/bin
fi
alias javac='javac -J-Duser.language=en'
EOF
