#
# .zshrc based on https://scriptingosx.com/2019/06/moving-to-zsh/
#
#set -xv
#echo .zshrc

PATH=$PATH:$HOME/bin
export PATH

# enable "auto cd":
setopt AUTO_CD

# share history across multiple shells:
#setopt SHARE_HISTORY
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
if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

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

# Default to Java 8 due to DependencyMap and Atlassian ...
setjdk 1.8

#
# Enable completion
#
plugins=(... docker docker-compose
)

# Disabling this:
# zsh-completions
# (https://formulae.brew.sh/formula/zsh-completions)
#if type brew &>/dev/null; then
#  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
#fi
# autoload -Uz compinit && compinit

# Switching to this:
# https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

#
# Timestamp in prompt
#
#
PS1="[%m %D{%Y-%m-%d} %T] %1~ %# "

# Show git branch and repository in the PROMPT
#
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

#
# NVM (Versioned NPM / Node)
# 
if [ "$(uname -m)" = "arm64" ]
then
  # Apple Silicon
  export NVM_DIR="$HOME/.nvm"
  # This loads nvm:
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  
  # This loads nvm bash_completion:
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

  #
  # Atlassian forge completion config - added by running: forge autocomplete install:
  #
  # begin forge completion
  . <(forge --completion)
  # end forge completion
 
  # Load pyenv automatically:
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
else
  # Intel
  export NVM_DIR=~/.nvm
  # source $(brew --prefix nvm)/nvm.sh
  # This loads nvm:
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  
  # This loads nvm bash_completion:
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] \
    && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  
fi

#
# Converts image file to base64 encoded imageURL string
#
function img-data() {
  TYPE=$(file --mime-type -b $1)
  ENC=$(base64 $1)
  echo "data:$TYPE;base64,$ENC"
}
#
# ngrok
#
if command -v ngrok &>/dev/null; then
   eval "$(ngrok completion)"
fi
