# export LC_CTYPE=en_US.UTF-8
# export LC_ALL=en_US.UTF-8

# Setting the editor of choice
export EDITOR='nvim'
export GIT_EDITOR='nvim'
export VISUAL=$EDITOR
export SVN_EDITOR=$EDITOR
export BUNDLER_EDITOR=$EDITOR
export GEMEDITOR=$EDITOR

export LT_HOMEA='/Applications'

# Paths
export PATH="/usr/local/bin:$PATH"
if [[ -d "/usr/local/sbin" ]]; then
  export PATH=$PATH:/usr/local/sbin
fi
export PATH=$PATH:$HOME/.dotfiles/bin
# Load Node.js bin:
export PATH="/usr/local/share/npm/bin:$PATH"
export NODE_PATH="/usr/local/lib/node_modules"

# General aliases
alias l='ls -halo'
alias ltr='ls -lt'
alias lth='l -t|head'
alias lh='ls -Shl | less'
alias tf='tail -f -n 100'
alias less='less -R' # color codes in less
alias m='mvim --remote-silent' # open file in existing mvim
alias grep='grep --colour=always'

# Ruby aliases
alias rdm='rake db:migrate db:test:prepare'
alias rr='mkdir -p tmp && touch tmp/restart.txt'
alias c='bundle exec cucumber -r features'
alias wip='c --profile wip'
alias specdoc='time rspec -fd'
alias s='rspec --require ~/.dotfiles/script/rspec_focus --order default --color --tty'
alias be='bundle exec'
alias irb='pry'
alias guard='bundle exec guard'

# Git aliases
alias cdb='base=$(git rev-parse --show-cdup) && cd $base'
alias st='git status'
alias status='git status'
alias co='git checkout'
alias checkout='git checkout'
alias ci='git commit'
alias commit='git commit'
alias amend='git commit --amend'
alias cm='git commit --message'
alias up='git up'
alias upstash='git stash && git pull --ff-only && git stash pop'
alias br='git branch'
alias branch='git branch'
alias lg='git log -p'
alias ll='git l'
alias la='git la'
alias aa='git add --all && git status -sb'
alias d='git diff'
alias df='git diff'
alias dc='git diff --cached'
alias f='git fetch'
alias fetch='git fetch'
alias gf='git fetch && git status'
alias push='git push'
alias gs='git status --short'
alias ap='git add -p'


function r() {
  if [ -f "./script/rails" ]; then
    ./script/rails $*
  else
    ./bin/rails $*
  fi
}
# checks to see if bundler is installed, if it isn't it will install it
# checks to see if your bundle is complete, runs bundle install if it isn't
# if any arguments have been passed it will run it with bundle exec
function b() {
  gem which bundler > /dev/null 2>&1 || gem install bundler --no-ri --no-rdoc
  bundle check || bundle install
  if [ $1 ]; then
    bundle exec $*
  fi
}

# unstage and by making it a function it will autocomplete files
unstage() {
  git reset HEAD -- $*
  echo
  git status
}

function github-init () {
  git config branch.$(git-branch-name).remote origin
  git config branch.$(git-branch-name).merge refs/heads/$(git-branch-name)
}

function github-url () {
  git config remote.origin.url | sed -En 's/git(@|:\/\/)github.com(:|\/)(.+)\/(.+).git/https:\/\/github.com\/\3\/\4/p'
}

# Seems to be the best OS X jump-to-github alias from http://tinyurl.com/2mtncf
function github-go () {
  open $(github-url)
}

# grep for a process
function psg {
  FIRST=`echo $1 | sed -e 's/^\(.\).*/\1/'`
  REST=`echo $1 | sed -e 's/^.\(.*\)/\1/'`
  ps aux | grep "[$FIRST]$REST"
}
