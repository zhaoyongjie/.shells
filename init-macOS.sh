if [[ $(uname) != 'Darwin' ]]; then
    echo 'Run script must be on MACOS'
    exit 1
fi

CASK_APPS='
  docker-desktop
  iterm2
  google-chrome
  firefox
  skitch
  vlc
  claude-code
  codex
  chromedriver
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
  tor
  go
  maven
  duckdb
  syncthing
  ripgrep
  fd
  fzf
  bat
  eza
  jq
  yq
  zoxide
  git-delta
  gh
  btop
  hyperfine
  poppler
  qpdf
  ocrmypdf
  tesseract
  tesseract-lang
  imagemagick
  exiftool
  pandoc
  ffmpeg
  gemini-cli
  opencode
  uv
  asdf
  yt-dlp
  llama.cpp
  awscli
  cmake
  ninja
  rust
  wireguard-tools
'

# install homebrew
if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# brew prefix: /opt/homebrew on Apple Silicon, /usr/local on Intel
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

brew install --cask $CASK_APPS
brew install $APPS

# install python
if [[ ! -d $HOME/.pyenv ]]; then
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
fi
$HOME/.pyenv/bin/pyenv install -s 3.12
if [[ ! -d $HOME/.pyenv/plugins/pyenv-virtualenvwrapper ]]; then
    git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $HOME/.pyenv/plugins/pyenv-virtualenvwrapper
fi

# install node
if [[ ! -d $HOME/.nvm ]]; then
    curl -L https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi

read -p "Are you want auto starting syncthing? (y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    brew services start syncthing
fi
