# this bashrc is intended to be used with
#  eval "$(curl -L https://raw.githubusercontent.com/pl643/eval_curl/main/bashrc)"

#
# Exports
#
if [ -z ${HOME_SAVED+x} ]; then
  export HOME_SAVED=$HOME
  export HOME=/tmp/.home.$USER
  [ -d ~/.local/bin ] && export PATH=~/.local/bin:$PATH
fi

# binaries tools
# https://github.com/mosajjal/binary-tools
# https://github.com/junegunn/fzf

#### function definations ####

enable_direnv() {
  if which direnv > /dev/null 2>&1 ; then
    eval "$(direnv hook bash)"
    alias da='echo direnv allow; direnv allow'
    alias ee='echo $EDITOR .envrc; $EDITOR .envrc;'
  fi
}

# git-bash and msys specific
msys() {
  echo "NOTE: MSYS2 environemnt detected, function msys() called"
  # https://github.com/alacritty/alacritty/issues/1687 WindowsTermianal workaround for tmux in Git-bash & MSYS2
  TMUX_MSYS2_WORKAROUND='tmux () { TMUX="command tmux ${@}"; SHELL=/usr/bin/bash script -qO /dev/null -c "eval $TMUX"; }'
  eval "$TMUX_MSYS2_WORKAROUND"

  [ -z $USER ] && USER=$(whoami)
 
  for path in /c/msys64/usr/bin /c/Users/$USER/OneDrive/winbin /c/Users/$USER/OneDrive/winbin/nvim-win64/bin; do
    if test -d $path; then
       export PATH=$path:$PATH
       echo NOTE: $path added to PATH
    fi
  done
}

# set EDITOR to whatever vi binary is installed, preffered vi listed in desending order
set_editor() {
  for editor in pico nano vi vim nvim; do
    which $editor > /dev/null 2>&1 && export EDITOR=$editor
  done
  echo NOTE: $EDITOR exported to \$EDITOR
}

# wget https://github.com/mosajjal/binary-tools/raw/master/x64/fzf
dlbinarytools() {
  localbin=~/.local/bin
  [ -d $localbin ] && mkdir -p $localbin
  cd $localbin
  wget https://github.com/mosajjal/binary-tools/raw/master/x64/$1
  chmod +x $1
}

# Downloads fzf into ~/.local/bin
dlfzf() { 
  localbin=~/.local/bin
  [ -d $localbin ] && mkdir -p $localbin
  cd $localbin
  wget https://github.com/mosajjal/binary-tools/raw/master/x64/fzf
  chmod +x fzf
}

# download tmux
dltmux() { 
  localbin=~/.local/bin
  [ -d $localbin ] && mkdir -p $localbin
  cd $localbin
  wget https://github.com/mosajjal/binary-tools/raw/master/x64/tmux
  chmod +x tmux
}

# download vim
dlvim() { 
  localbin=~/.local/bin
  [ -d $localbin ] && mkdir -p $localbin
  cd $localbin
  wget https://github.com/mosajjal/binary-tools/raw/master/x64/vim
  chmod +x vim
}

# downloads zoxide to ~/.local/bin
dlzoxide() {
  # https://github.com/ajeetdsouza/zoxide#installation 
  curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
  export PATH=~/.local/bin:$PATH
  eval "$(zoxide init bash)" 
}

shopt -s autocd # change directory by typing path

set -o vi       # vim cmdline editing (set -o emacs for default) 

##### execution starts here #####

echo NOTE: https://raw.githubusercontent.com/pl643/eval_curl/main/bashrc

# for bash-git & msys2 environment install with winget.exe install Git.Git; winget install MSYS2.MSYS2 
# msys2 allows additional commands to be installed with pacman -S app
[[ "$OSTYPE" == "msys" ]] && msys

# EDITOR variable needed to be set before aliases are defined
set_editor

# source local aliases
f=~/.bash_aliases; [ -f $f ] && source $f

# single letter aliases
alias a='sel=$(alias|sed "s/alias //"|fzf); eval $(echo $sel|cut -f1 -d =)'
alias b='cd -'
alias e="$EDITOR"
alias f='fg'
alias h="$HOME_SAVED"
alias j=jobs
alias l='ls -lF'
alias s='ls -F'
alias u='cd ..'
alias v="$EDITOR"

# reload bashrc from url
alias alb='export PATH=~/.local/bin:$PATH'
alias dlb='curl -o bashrc -L https://raw.githubusercontent.com/pl643/eval_curl/main/bashrc'
alias git.config='git config user.name "Peter Ly"; git config user.email peter.wt.ly@gmail.com'
alias f1='%1'
alias f2='%2'
alias f3='%3'
alias gd='git diff'
alias gl='git log'
alias gs='git status'
alias la='ls -alF'
alias lg='lazygit'
alias ls='ls --color=auto'
alias path="echo $PATH"
alias sa='ls -aF'
alias sb='eval "$(curl -L https://raw.githubusercontent.com/pl643/eval_curl/main/bashrc)"'
alias sr='ssh -l root'
alias ssh="$(which ssh) -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null"

echo NOTE: available features:  enable_direnv, a - select aliases with fzf
