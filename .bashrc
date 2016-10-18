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

alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -A'

if [ ! -z $WORK_PATH ]; then
    cd $WORK_PATH
fi
