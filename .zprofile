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

#
# ngrok
#
if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
fi