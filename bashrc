# this bashrc is intended to be used with eval $(curl -L raw github location of this file)

alias b='cd -'
alias e="$EDITOR"
alias l='ls -lF'
alias s='ls -F'
alias u='cd ..'
alias v=nvim
alias sr='ssh -l root'
alias ssh="$(which ssh) -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null"

set -o vi

if which direnv; then
	eval "$(direnv hook bash)"
fi
