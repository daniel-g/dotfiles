[[ -s "/Users/Daniel/.rvm/scripts/rvm" ]] && source "/Users/Daniel/.rvm/scripts/rvm"  # This loads RVM into a shell session.

parse_git_branch () {
	        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (git: \1)/'
}
parse_svn_branch() {
        parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk '{print " (svn: "$1")" }'
}
parse_svn_url() {
        svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}
parse_svn_repository_root() {
        svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
}

BLACK="\[\033[0;38m\]"
RED="\[\033[0;31m\]"
RED_BOLD="\[\033[01;31m\]"
BLUE="\[\033[01;34m\]"
GREEN="\[\033[0;32m\]"

export PS1="\u@$BLACK\h: $BLACK\w$GREEN\$(parse_git_branch)\$(parse_svn_branch)$BLACK $ "

alias g='git'
alias gpoh='git push origin HEAD'

alias r='rspec'
alias st='script/test'
alias sp='script/push'
alias gs='bundle exec guard start'
alias be='bundle exec'
alias v='mvim'
alias fhistory='history | grep'
alias fps='ps -ax | grep'
alias mig='be rake db:migrate db:test:prepare'
alias j='jump'
alias kj='kill -s KILL'
alias cpmod="find . | perl -ne 'chomp; $a = (stat $_)[2] & 07777; $a = ($a & 07707) | (($a >> 3) & 070); chmod($a, $_)'"
alias fcache='dscacheutil -flushcache'
alias depintegration='git push origin HEAD && git push integration HEAD:master'
alias depstaging='git push origin HEAD && git push staging HEAD:master'
alias depproduction='git push origin HEAD && git push production HEAD:master'
alias gitk='gitx'

export PATH=/usr/local/bin:$PATH
export EDITOR=vim
export SHOWOFF_EVAL_RUBY=1

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
source ~/.git-flow-completion.sh
source ~/.completion-rake.sh

eval "$(hub alias -s)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

git() { command git "$@"; if [[ "$1" == *checkout* ]] || [[ "$1" == *co* ]]; then [[ -s .rvmrc ]] && . .rvmrc; fi }
