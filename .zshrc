#
# .zshrc based on https://scriptingosx.com/2019/06/moving-to-zsh/
#

PATH=$PATH:$HOME/bin
export PATH

# enable "auto cd":
setopt AUTO_CD

# share history across multiple shells:
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

# enable typo corrections:
setopt CORRECT
setopt CORRECT_ALL

# enable help for built-ins
# https://stackoverflow.com/a/56874094/816977
unalias run-help
autoload run-help

# get slash for directory completions, e.g. cd ..<TAB>
# https://unix.stackexchange.com/a/114243/45202
zstyle ':completion:*' special-dirs true

# keep slash added by completion when typing
# https://unix.stackexchange.com/a/160144/45202
setopt no_auto_remove_slash

# allow bash style comments:
setopt interactivecomments

# aliases
alias lf='ls -F'
alias ll='ls -lF'

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

#
# Enable completion
#
autoload -Uz compinit && compinit

#
# Show git branch and repository in the RPROMPT
#
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git
