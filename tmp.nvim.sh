# Download latest neovim to /tmp/.$USER and clean up when shell exits
# pl643

# eval "$(cat tmp.nvim.sh)"


nightly_neovim_url=https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
latest_neovim_url=https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz

if [ -z $n ]; then
  neovim_url=$latest_neovim_url
else
  neovim_url=$nightly_neovim_url
fi

tmp_folder=/tmp/.$USER
tmp_bin=$tmp_folder/bin

echo "$neovim_url -> $tmp_bin"
echo \$n=1 for nightly builds
[ -d $tmp_bin ] && rm -rf $tmp_bin

mkdir -p $tmp_bin

curl -sL --output - $neovim_url | tar xfz - -C $tmp_bin

cleanup() {
  if [ ! -f $tmp_folder/nocleanup ]; then
    echo rm -rf /tmp/.$USER
    rm -rf /tmp/.$USER
    sleep 2
 fi
}

trap cleanup EXIT

set -o vi
echo
alias v="$tmp_bin/nvim-linux64/bin/nvim"
alias cu=cleanup
alias nocu="touch $tmp_folder/nocleanup"
alias v cu nocu
echo
echo on exit: $(type cleanup)
echo
