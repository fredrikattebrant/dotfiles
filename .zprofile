# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:$HOME/.docker/bin"
# End of Docker Desktop section.

#
# .zprofile
#
# Makes assumptions on where homebrew is installed so adjust as needed
#
#echo ".zprofile"

if [ -d /opt/homebrew ]
then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi
