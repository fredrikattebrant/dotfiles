export PATH=$PATH:$HOME/bin

export EDITOR=/usr/bin/vim

export HISTSIZE=5000
export HISTCONTROL=ignoredups:erasedups
export HISTTIMEFORMAT='%F %T '

export COLOR_NC='\e[0m' # No Color
export COLOR_WHITE='\e[1;37m'
export COLOR_BLACK='\e[0;30m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_GRAY='\e[0;30m'
export COLOR_LIGHT_GRAY='\e[0;37m'
alias colorslist="set | egrep 'COLOR_\w*'"  # lists all the color

#
#export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'

# git prompt
source ~/.gitcompletion.sh
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1="\[$COLOR_LIGHT_BLUE\]\w\[$COLOR_NC\] \$(__git_ps1 '(%s)') \[$COLOR_LIGHT_PURPLE\]\$ \[$COLOR_NC\]"

if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.git_rmb ]; then
  source ~/.git_rmb
fi


# autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh


# node
export NODE_PATH=/usr/local/lib/node_modules
export PATH=/usr/local/share/npm/bin:$PATH


# sencha Command
export PATH=/Users/andreasarledal/bin/Sencha/Cmd/4.0.0.203:$PATH


# GVM
#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/andreasarledal/.gvm/bin/gvm-init.sh" && -z $(which gvm-init.sh | grep '/gvm-init.sh') ]] && source "/Users/andreasarledal/.gvm/bin/gvm-init.sh"


