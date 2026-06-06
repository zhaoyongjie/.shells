if [[ $(uname) != 'Darwin' ]]; then
    echo 'Run script must be on MACOS'
    exit 1
fi

APPS_GUI='
  chromedriver
  claude-code
  codex
  docker-desktop
  firefox
  google-chrome
  iterm2
  skitch
  vlc
'

APPS='
  asdf
  awscli
  bash
  bat
  btop
  cmake
  coreutils
  duckdb
  exiftool
  eza
  fd
  ffmpeg
  findutils
  fzf
  gawk
  gemini-cli
  gh
  git
  git-delta
  gnu-sed
  gnu-tar
  go
  grep
  httpie
  hyperfine
  imagemagick
  jq
  llama.cpp
  make
  maven
  mtr
  netcat
  ninja
  nmap
  ocrmypdf
  opencode
  pandoc
  poppler
  qpdf
  readline
  ripgrep
  rsync
  rust
  syncthing
  tesseract
  tesseract-lang
  tmux
  tor
  tree
  uv
  wget
  wireguard-tools
  yq
  yt-dlp
  zoxide
'

if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# brew prefix: /opt/homebrew on Apple Silicon, /usr/local on Intel
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

brew install --cask $APPS_GUI
brew install $APPS

if [[ ! -d $HOME/.pyenv ]]; then
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
fi
$HOME/.pyenv/bin/pyenv install -s 3.12
if [[ ! -d $HOME/.pyenv/plugins/pyenv-virtualenvwrapper ]]; then
    git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $HOME/.pyenv/plugins/pyenv-virtualenvwrapper
fi

if [[ ! -d $HOME/.nvm ]]; then
    curl -L https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi

read -p "Are you want auto starting syncthing? (y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    brew services start syncthing
fi
