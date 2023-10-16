# download latest lazyvim from github

INSTALLPATH=~/.local/bin
[ ! -d $INSTALLPATH ] && mkdir -p $INSTALLPATH
if cd $INSTALLPATH; then
  BINPATH=https://github.com/jesseduffield/lazygit/releases/download/v0.40.2/lazygit_0.40.2_Linux_x86_64.tar.gz
  curl -sL $BINPATH -o - | tar xfz -
else
  echo No download performed.
fi

