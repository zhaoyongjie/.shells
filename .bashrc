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
    HOMEBREW_PREFIX=/opt/homebrew/opt
    export GOBIN=$HOME/go/bin
    export MANPATH=$HOMEBREW_PREFIX/coreutils/libexec/gnuman:$MANPATH
    export JAVA_HOME=$(/usr/libexec/java_home)
    export PATH="\
$HOMEBREW_PREFIX/grep/libexec/gnubin:\
$HOMEBREW_PREFIX/gnu-tar/libexec/gnubin:\
$HOMEBREW_PREFIX/gnu-sed/libexec/gnubin:\
$HOMEBREW_PREFIX/findutils/libexec/gnubin:\
$HOMEBREW_PREFIX/coreutils/libexec/gnubin:\
$HOMEBREW_PREFIX/openssl@1.1/bin:\
$HOMEBREW_PREFIX/go/libexec/bin:\
$JAVA_HOME:\
$GOBIN:\
/usr/local/sbin:\
$PATH"

    # for compilers to find openssl and for pkg-config to find openssl
    export LDFLAGS="-L$HOMEBREW_PREFIX/openssl@1.1/lib -L$HOMEBREW_PREFIX/zlib/lib -L$HOMEBREW_PREFIX/bzip2/lib"
    export CPPFLAGS="-I$HOMEBREW_PREFIX/openssl@1.1/include -I$HOMEBREW_PREFIX/zlib/include -I$HOMEBREW_PREFIX/bzip2/include"
    export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/openssl@1.1/lib/pkgconfig:$HOMEBREW_PREFIX/zlib/lib/pkgconfig"

    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
    export BASH_SILENCE_DEPRECATION_WARNING=1
fi

if [[ $(uname) == 'Linux' ]]; then
    # placeholder for Linux
    export JAVA_HOME=/opt/jdk8u242-b08
    export PATH=$JAVA_HOME/bin:$PATH
fi

# This loads pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"
eval "$(pyenv init -)"
pyenv global ${PYTHON_GLOBAL_VERSION:-'3.8.6'}
pyenv virtualenvwrapper
export PIP_CONFIG_FILE=$HOME/.shells/.pip.conf
export WORKON_HOME=$HOME/.virtualenvs

if [[ -x "$(command -v pygmentize)" ]]; then
    alias pat='pygmentize -g -O style=colorful,linenos=1'
fi

#if [[ -f "$HOME/.nvm/nvm.sh" ]]; then
#    source "$HOME/.nvm/nvm.sh"
#fi

if [[ -x "$(command -v direnv)" ]]; then
    eval "$(direnv hook bash)"
fi

alias grep='ggrep -IE --color=auto --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=bower_components --exclude-dir=dist'
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -A'
function sn() {
    grep -ri"$2" --exclude=*.{html,} "$1" ~/Dropbox/Notebooks/ ~/Dropbox/Diary/
}
alias sn=sn

unset GREP_OPTIONS

if [[ -n $WORKSPACE ]]; then
    cd $WORKSPACE
fi

if [[ -f $HOME/.cargo/env ]]; then
    . "$HOME/.cargo/env"
fi

