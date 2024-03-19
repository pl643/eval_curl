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

tmp_bin=/tmp/.$USER/bin
echo $neovim_url to $tmp_bin
echo \$n=1 for nightly builds
[ -d $tmp_bin ] && rm -rf $tmp_bin

mkdir -p $tmp_bin

curl -sL --output - $neovim_url | tar xfz - -C $tmp_bin

cleanup() {
  echo rm -rf /tmp/.$USER
  rm -rf /tmp/.$USER
  sleep 2
}

trap cleanup EXIT

set -o vi
alias v="$tmp_bin/nvim-linux64/bin/nvim"
alias rv="echo \"rm -rf $tmp_bin\"; rm -rf $tmp_bin"
alias v rv
echo on exit: $(type cleanup)
