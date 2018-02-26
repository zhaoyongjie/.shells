CASK_APPS='
  psequel
  sequel-pro
  docker
  iterm2
  emacs
  rowanj-gitx
  google-chrome
  firefox
  shadowsocksx-ng
  tunnelblick
  adobe-acrobat-reader
  dash2
  thunderbird
  vox
  neteasemusic
  squirrel
  typora
  burp-suite
  wireshark
  virtualbox
  intellij-idea-ce
  pycharm-ce
  grammarly
  gimp
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
  syncthing
  python
  python3
  pyenv
  node@6
  yarn --without-node
  go
'

if [[ $(uname) == 'Darwin' ]]; then
    xcode-select --install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap caskroom/cask
    brew tap caskroom/versions
    brew cask install $CASK_APPS
    brew install $APPS --with-default-names
    pip install ipython virtualenvwrapper ipdb rope jedi flake8 importmagic autopep8 yapf
    pip3 install ipython ipdb
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
