if [[ $(uname) != 'Darwin' ]]; then
    echo 'Run script must be on MACOS'
    exit 1
fi

APPS_GUI='
  claude-code@latest
  codex
  docker-desktop
  firefox
  google-chrome
  iterm2
'

APPS='
  asdf
  awscli
  bash
  bash-completion@2
  btop
  cmake
  chromedriver
  coreutils
  diffnav
  duckdb
  exiftool
  fd
  ffmpeg
  findutils
  fzf
  gawk
  gemini-cli
  gh
  git
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
  mpv
  mtr
  ninja
  nmap
  ocrmypdf
  opencode
  openjdk@17
  pandoc
  poppler
  qpdf
  readline
  ripgrep
  rsync
  rust
  starship
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
  zlib
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

brew install --cask --adopt $APPS_GUI
brew install $APPS

BREW_BASH=$HOMEBREW_PREFIX/bin/bash
if ! grep -qx "$BREW_BASH" /etc/shells; then
    echo "$BREW_BASH" | sudo tee -a /etc/shells
fi
if [[ $(dscl . -read /Users/$USER UserShell | awk '{print $2}') != "$BREW_BASH" ]]; then
    chsh -s "$BREW_BASH"
fi

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
