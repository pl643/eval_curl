# this bashrc is intended to be used with eval "$(curl -L https://raw.githubusercontent.com/pl643/eval_curl/main/bashrc)"

# for bash-git & msys2 environment install with winget.exe install Git.Git; winget install MSYS2.MSYS2 
# msys2 allows additional commands to be installed with pacman -S app
msys() {
  # https://github.com/alacritty/alacritty/issues/1687 WindowsTermianal workaround for tmux in Git-bash & MSYS2
  TMUX_MSYS2_WORKAROUND='tmux () { TMUX="command tmux ${@}"; SHELL=/usr/bin/bash script -qO /dev/null -c "eval $TMUX"; }'
  eval "$TMUX_MSYS2_WORKAROUND"

  [ -z $USER ] && USER=$(whoami)
  # add paths if exist
  for path in pico nano vi vim nvim; do
    which $check > /dev/null 2>&1 && export EDITOR=$editor
  done
 
  for path in /c/msys64/usr/bin /c/Users/$USER/OneDrive/winbin /c/Users/$USER/OneDrive/winbin/nvim-win64/bin; do
    [ -d $path ] && export PATH=$path:$PATH
  done
}
[ ! -z $MSYS ] && msys

# set EDITOR to whatever vi binary is installed, preffered vi listed in desending order
for editor in pico nano vi vim nvim; do
  which $editor > /dev/null 2>&1 && export EDITOR=$editor
done

shopt -s autocd # change directory by typing path

set -o vi       # vim cmdline editing (set -o emacs for default) 

# single letter aliases
alias a='sel=$(alias|sed "s/alias //"|fzf); eval $(echo $sel|cut -f1 -d =)'
alias b='cd -'
alias e="$EDITOR"
alias h="$OHOME"
alias l='ls -lF'
alias s='ls -F'
alias u='cd ..'
alias v="$EDITOR"

# reload bashrc from url
alias gconfig='git config user.name "Peter Ly"; git config user.email peter.wt.ly@gmail.com'
alias gd='git diff'
alias gs='git status'
alias lg='lazygit'
alias ls='ls --color=auto'
alias sb='eval "$(curl -L https://raw.githubusercontent.com/pl643/eval_curl/main/bashrc)"'
alias sr='ssh -l root'
alias ssh="$(which ssh) -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null"

if which direnv > /dev/null 2>&1 ; then
	eval "$(direnv hook bash)"
	alias da='echo direnv allow; direnv allow'
	alias ee='echo $EDITOR .envrc; $EDITOR .envrc;'
fi
