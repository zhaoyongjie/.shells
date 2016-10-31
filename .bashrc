# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

export PS1='\u@:\W$ '
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$HOME/.npm-packages/bin:$PATH
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/workspace
export TERM=xterm-256color
export VIRTUALENV_PYTHON=/usr/local/opt/python/bin/python
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi

if [ -f ~/.shells/git-envs ]; then
    # export GIT_AUTHOR_NAME=
    # export GIT_AUTHOR_EMAIL=
    # export GIT_COMMITTER_NAME=
    # export GIT_COMMITTER_EMAIL=
    source ~/.shells/git-envs
fi

source $HOME/.git-completion.bash

alias grep='grep -I --color=auto --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=bower_components'
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -A'

unset GREP_OPTIONS

if [ ! -z $WORK_PATH ]; then
    cd $WORK_PATH
fi

