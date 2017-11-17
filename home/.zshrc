# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
# export TERM="xterm-256color"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="jaischeema"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git gem brew bundler cap rails ruby textmate thor rvm pow powder osx heroku github)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export CC=/usr/local/bin/gcc-4.2
export CPPFLAGS=-I/opt/X11/include

# export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH=/Users/rizwanreza/bin:/Users/rizwanreza/.bin:/usr/local/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/git/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:$PATH

PROMPT_TITLE='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
export PROMPT_COMMAND="${PROMPT_COMMAND} ${PROMPT_TITLE}; "

# Aliases

alias ..='cd ..'
alias please='sudo'
alias tlog='tail -f log/development.log'
alias rst='touch tmp/restart.txt'

alias g='git status -s'
alias gl='git la'
alias gd='git diff --word-diff=color'
alias gdc='git diff --cached --word-diff=color'

alias bx='bundle exec'
alias gi='gem install'
alias r='rails'
alias mrails='mate app config db doc features lib public spec test vendor/plugins Gemfile'

alias generate_tags='ctags -R --exclude=.git --exclude=log --exclude=tmp --exclude=autotest --exclude=db -f .tags *'

# alias vim='mvim -v'
# alias v='mvim -v'
alias mon='cd ~/code/monaqasat && rvm use ruby-1.9.3-p448-railsexpress@monaqasat'
alias mic='cd ~/code/microment'

# Prompt modifications

autoload -U colors
colors
setopt prompt_subst

local smiley="%(?,%{$fg[green]%}:)%{$reset_color%},%{$fg[red]%}:(%{$reset_color%})"

PROMPT='
%~
${smiley}  %{$reset_color%}'
RPROMPT='$(~/.bin/git-cwd-info.rb)%{$fg[yellow]%} $(~/.rvm/bin/rvm-prompt)%{$reset_color%}'

PROMPT_TITLE='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
export PROMPT_COMMAND="${PROMPT_COMMAND} ${PROMPT_TITLE}; "
export CC=/usr/bin/gcc

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source ~/.iterm2_shell_integration.`basename $SHELL`

