# download linux_amd64 binaries to /tmp/.xdg.$USER

if [ -z $XDG_CONFIG_HOME ]; then
  export XDG_CONFIG_HOME=/tmp/.xdg.$USER
fi

INSTALLPATH=$XDG_CONFIG_HOME
mkdir -p $INSTALLPATH
if cd $INSTALLPATH; then
  BINPATH=https://github.com$(curl -sL https://github.com/junegunn/fzf/releases \
    | grep linux_amd64.tar.gz | grep download | cut -d \" -f2)
  curl -sL $BINPATH -o - | tar xfz -
else
  echo No download performed.
fi
