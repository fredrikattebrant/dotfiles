#
# .zshrc based on https://scriptingosx.com/2019/06/moving-to-zsh/
#

# enable "auto cd":
setopt AUTO_CD

# share history across multiple shells:
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

# enable typo corrections:
setopt CORRECT
setopt CORRECT_ALL

# aliases
alias lf='ls -F'
alias ll='ls -lF'

# Start VS Code:
code () 
{ 
    VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $*
}

#
# Set Java version
# Source:
# http://www.jayway.com/2014/01/15/how-to-switch-jdk-version-on-mac-os-x-maverick/?utm_source=twitterfeed&utm_medium=twitter
#
# Usage:
#     setjdk 1.7
#
function setjdk() {
  if [ $# -ne 0 ]; then
    removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
    if [ -n "${JAVA_HOME+x}" ]; then
      removeFromPath $JAVA_HOME
    fi
    export JAVA_HOME=`/usr/libexec/java_home -v $@`
    export PATH=$JAVA_HOME/bin:$PATH
  else
    # print available versions
    echo "Current: $(/usr/libexec/java_home -V)"
  fi
}
function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}
