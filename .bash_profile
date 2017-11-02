#
# .profile for fredrik
#
PATH=/usr/local/bin:$PATH:$HOME/bin
export PATH

## Homebrew
#PATH=/usr/local/sbin:$PATH
#Failed workaround for duplicity:
#PYTHONPATH=/usr/local/lib/python2.7/site-packages
#See: https://github.com/Homebrew/homebrew/issues/22584

# ImageMagick:
#MAGICK_HOME=$HOME/Applications/ImageMagick-latest
#export MAGICK_HOME
#PATH=$PATH:$MAGICK_HOME/bin
#DYLD_LIBRARY_PATH=$MAGICK_HOME/lib
#export DYLD_LIBRARY_PATH

MAGICK_CONFIGURE_PATH=$HOME/.magick
export MAGICK_CONFIGURE_PATH

### Functions:

# list directory stack on per line
function DIRS
{
  dirs | sed 's- -\
-g'
}

# create dir and cd into it:
function mkcddir
{
  mkdir "$1"
  cd "$1"
}

# launch Visual Code Studio:
function code
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
setjdk 1.8

# Store ssh keys in the keychain
ssh-add -K

# Scala
#SCALA_HOME=/Applications/dev/scala
#export SCALA_HOME
#PATH=$PATH:$SCALA_HOME/bin

#maven
#M3_HOME=/usr/local/Cellar/maven/3.1.1
#export M3_HOME
##PATH=$PATH:$M3_HOME/bin

#PS1="\h:\W \u\$ "
PS1="\h:\W \$ "

if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.git_rmb ]; then
  source ~/.git_rmb
fi

function xtt
{
#
# Usage:	xtt { title }	# default is username@hostname
#
#PS1='$ '
if [ "$1" != "" ]
then
	title="$1"
else
	if [ "$USER" = "fxo" ]
	then
		title=`uname -n`
	else
		title="`whoami`@`uname -n`"
	fi
fi

echo -n "]0;$title"
}

# enable "next command" with ctrl-o:
# see: http://apple.stackexchange.com/questions/3253/ctrl-o-behavior-in-terminal-app?answertab=votes#tab-top
stty discard undef

# adjust limits:
ulimit -n 1024   # allow more open files

#
# enable bash completion:
#
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

