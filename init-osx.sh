CASK_APPS='
  psequel
  sequel-pro
  docker
  iterm2
  emacs
  rowanj-gitx
  google-chrome
  firefox
  shadowsocksx
  balsamiq-mockups
  adobe-acrobat-reader
  dash2
  thunderbird
  tunnelblick
  vox
  neteasemusic
  squirrel
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
  tree
  wget
  tmux
  httpie
  nmap
  mtr
  siege
  syncthing
  python
  python3
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
    pip install ipython virtualenvwrapper
    pip3 install ipython
    . install.sh
else
    echo 'Run script must be on MACOS'
fi