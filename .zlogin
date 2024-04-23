#echo .zlogin

# Store ssh keys in the keychain
ssh-add --apple-use-keychain

if [ "$(uname -m)" = "arm64" ]
then
  # Apple Silicon
  # default to node 18:
  nvm use 18
else
  # default Java:
  setjdk 17
fi

