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

export TERM=xterm-256color
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [[ $(uname) == 'Darwin' ]]; then
    export PS1='\u@:\W$ '
    LP=/usr/local/opt
    export GOBIN=$HOME/go/bin
    export MANPATH=$LP/coreutils/libexec/gnuman:$MANPATH
    export JAVA_HOME=$(/usr/libexec/java_home)
    export PATH=$LP/coreutils/libexec/gnubin:$HOME/.npm-packages/bin:$LP/node@8/bin:$LP/go/libexec/bin:$GOBIN:/usr/local/sbin:$PATH
    source /usr/local/etc/bash_completion.d/git-completion.bash
fi

if [[ $(uname) == 'Linux' ]]; then
    # placeholder for Linux
    echo 'placeholder' > /dev/null
fi

# This loads nvm
export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# This loads pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
pyenv global 3.6.8
pyenv virtualenvwrapper
export PIP_CONFIG_FILE=$HOME/.shells/.pip.conf
export WORKON_HOME=$HOME/.virtualenvs

if [ -f ~/.shells/git-envs ]; then
    # export GIT_AUTHOR_NAME=
    # export GIT_AUTHOR_EMAIL=
    # export GIT_COMMITTER_NAME=
    # export GIT_COMMITTER_EMAIL=
    source ~/.shells/git-envs
fi

if [[ -x "$(command -v pygmentize)" ]]; then
    alias pat='pygmentize -g -O style=colorful,linenos=1'
fi

alias grep='grep -I --color=auto --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=bower_components --exclude-dir=dist'
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -A'

unset GREP_OPTIONS

if [ ! -z $WORK_PATH ]; then
    cd $WORK_PATH
fi
