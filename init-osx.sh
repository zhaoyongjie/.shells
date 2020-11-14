CASK_APPS='
  docker
  iterm2
  emacs
  rowanj-gitx
  google-chrome
  firefox
  shadowsocksx-ng
  tunnelblick
  adobe-acrobat-reader
  squirrel
  typora
  burp-suite
  wireshark
  grammarly
  skitch
  vlc
'

APPS='
  readline
  git
  bash
  coreutils
  findutils
  gnu-tar
  gnu-sed
  gawk
  gnutls
  gnu-indent
  gnu-getopt
  grep
  make
  tree
  wget
  tmux
  httpie
  nmap
  netcat
  mtr
  iproute2mac
  siege
  tor
  go
  maven
  textql
  gnumeric
'

if [[ $(uname) == 'Darwin' ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap homebrew/cask
    brew cask install $CASK_APPS
    brew install $APPS

    # install python
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
    $HOME/.pyenv/bin/pyenv install 2.7.18
    $HOME/.pyenv/bin/pyenv install 3.8.6
    git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $HOME/.pyenv/plugins/pyenv-virtualenvwrapper

    # install node
    curl -L https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | bash

    . install.sh

    read -p "Are you want auto starting syncthing? (y/n) " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        brew services start syncthing
    fi
else
    echo 'Run script must be on MACOS'
fi
