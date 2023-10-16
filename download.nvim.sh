# download latest fzf from github

if [ -z $XDG_CONFIG_HOME ]; then
	export XDG_CONFIG_HOME=/tmp/.xdg.$USER
fi

INSTALLPATH=$XDG_CONFIG_HOME
mkdir -p $INSTALLPATH
if cd $INSTALLPATH; then
  BINPATH=https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
  curl -sL $BINPATH -o - | tar xfz -
  echo \$XDG_CONFIG_HOME/nvim-linux64/bin/nvim > $INSTALLPATH/nvim
  chmod +x $INSTALLPATH/nvim
else
  echo No download performed.
fi

