CASK_APPS='
  postico
  sequel-pro
  docker
  iterm2
  emacs
  rowanj-gitx
  google-chrome
  firefox
  shadowsocksx-ng
  tunnelblick
  torbrowser
  adobe-acrobat-reader
  dash2
  thunderbird
  squirrel
  typora
  burp-suite
  wireshark
  virtualbox
  grammarly
  skitch
  vlc
  java8
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
    xcode-select --install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap caskroom/cask
    brew tap caskroom/versions
    brew cask install $CASK_APPS
    brew install $APPS --with-default-names

    # install python
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
    $HOME/.pyenv/bin/pyenv install 2.7.16
    $HOME/.pyenv/bin/pyenv install 3.6.8
    git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $HOME/.pyenv/plugins/pyenv-virtualenvwrapper

    # install node
    curl -L https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

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
