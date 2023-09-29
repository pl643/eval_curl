# this bashrc is intended to be used with eval "$(curl -L https://raw.githubusercontent.com/pl643/eval_curl/main/bashrc)"

alias b='cd -'
alias e="$EDITOR"
alias l='ls -lF'
alias s='ls -F'
alias u='cd ..'
alias v=nvim

# reload bashrc from url
alias sb='eval "$(curl -L https://raw.githubusercontent.com/pl643/eval_curl/main/bashrc)"'
alias sr='ssh -l root'
alias ssh="$(which ssh) -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null"

set -o vi

if which direnv; then
	eval "$(direnv hook bash)"
fi
