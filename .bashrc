# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# ======== common: history / locale / prompt ========

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000
HISTIGNORE='ls:ll:pwd:exit:history*'

export TERM=xterm-256color
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PS1='\u@:\W$ '

OS=$(uname)

# ======== macOS ========

if [[ $OS == 'Darwin' ]]; then
    # brew prefix: /opt/homebrew on Apple Silicon, /usr/local on Intel
    if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    BREW_OPT=$HOMEBREW_PREFIX/opt

    export GOBIN=$HOME/go/bin
    export MANPATH="$BREW_OPT/coreutils/libexec/gnuman:$MANPATH"
    export PATH="\
$BREW_OPT/grep/libexec/gnubin:\
$BREW_OPT/gnu-tar/libexec/gnubin:\
$BREW_OPT/gnu-sed/libexec/gnubin:\
$BREW_OPT/findutils/libexec/gnubin:\
$BREW_OPT/coreutils/libexec/gnubin:\
$GOBIN:\
/usr/local/sbin:\
$HOME/.local/bin:\
$PATH"

    if /usr/libexec/java_home >/dev/null 2>&1; then
        export JAVA_HOME=$(/usr/libexec/java_home)
        export PATH="$JAVA_HOME/bin:$PATH"
    fi

    # for compilers to find openssl and for pkg-config to find openssl
    if [[ -d $BREW_OPT/openssl@3 ]]; then
        export LDFLAGS="-L$BREW_OPT/openssl@3/lib"
        export CPPFLAGS="-I$BREW_OPT/openssl@3/include"
        export PKG_CONFIG_PATH="$BREW_OPT/openssl@3/lib/pkgconfig"
    fi

    # bash-completion@2 (bash 4+) or v1 fallback
    if [[ -f $HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh ]]; then
        . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
    elif [[ -f $HOMEBREW_PREFIX/etc/bash_completion ]]; then
        . "$HOMEBREW_PREFIX/etc/bash_completion"
    fi
    export BASH_SILENCE_DEPRECATION_WARNING=1

    # `open <file>` opens text files in Sublime Text (override with $GUI_EDITOR);
    # apps, dirs, URLs and binary files still go to the system open
    function open() {
        local f
        [[ $# -eq 0 ]] && { command open; return; }
        for f in "$@"; do
            if [[ ! -f $f ]] || ! file -b --mime-type "$f" | grep -qE '^text/|json|xml|yaml|javascript|x-sh'; then
                command open "$@"
                return
            fi
        done
        command open -a "${GUI_EDITOR:-Sublime Text}" "$@"
    }
fi

# ======== Linux (Debian) ========

if [[ $OS == 'Linux' ]]; then
    if [[ -d /usr/lib/jvm/default-java ]]; then
        export JAVA_HOME=/usr/lib/jvm/default-java
        export PATH="$JAVA_HOME/bin:$PATH"
    fi
    if [[ -f /etc/bash_completion ]]; then
        . /etc/bash_completion
    fi
fi

# ======== cross-platform PATH ========

export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$PATH"

if [[ -d ${ASDF_DATA_DIR:-$HOME/.asdf}/shims ]]; then
    export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fi

# ======== pyenv ========

export PYENV_ROOT="$HOME/.pyenv"
if [[ -d $PYENV_ROOT ]]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    # pyenv remembers its global version; only override when explicitly asked
    if [[ -n $PYTHON_GLOBAL_VERSION ]]; then
        pyenv global $PYTHON_GLOBAL_VERSION
    fi
    if [[ -d $PYENV_ROOT/plugins/pyenv-virtualenvwrapper ]]; then
        pyenv virtualenvwrapper
    fi
    export PIP_CONFIG_FILE=$HOME/.shells/.pip.conf
    export WORKON_HOME=$HOME/.virtualenvs
fi

# ======== nvm ========

export NVM_DIR="$HOME/.nvm"
if [[ -s $NVM_DIR/nvm.sh ]]; then
    . "$NVM_DIR/nvm.sh"
    [[ -s $NVM_DIR/bash_completion ]] && . "$NVM_DIR/bash_completion"
fi

# ======== optional tools (guarded) ========

# fzf key bindings (Ctrl-R history, Ctrl-T files) and completion
if [[ -x "$(command -v fzf)" ]]; then
    FZF_INIT=$(fzf --bash 2>/dev/null)   # needs fzf >= 0.48
    if [[ -n $FZF_INIT ]]; then
        eval "$FZF_INIT"
    elif [[ -f /usr/share/doc/fzf/examples/key-bindings.bash ]]; then
        . /usr/share/doc/fzf/examples/key-bindings.bash   # debian 12 fallback
    fi
    unset FZF_INIT
fi

# zoxide: smarter cd, use `z <dir>` to jump
if [[ -x "$(command -v zoxide)" ]]; then
    eval "$(zoxide init bash)"
fi

if [[ -x "$(command -v starship)" ]]; then
    eval "$(starship init bash)"
fi

# ======== aliases ========

# on macOS gnubin puts GNU grep/ls first, so flags work on both platforms
alias grep='grep -IE --color=auto --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=bower_components --exclude-dir=dist'
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -A'

if [[ -n $WORKSPACE ]]; then
    cd $WORKSPACE
fi
