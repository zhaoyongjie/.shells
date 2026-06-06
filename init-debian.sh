#!/usr/bin/env bash

if [[ ! -f /etc/debian_version ]]; then
    echo 'Run script must be on Debian'
    exit 1
fi

APPS='
    build-essential
    libbz2-dev
    libssl-dev
    libffi-dev
    libldap2-dev
    libpq-dev
    libreadline-dev
    libsqlite3-dev
    libpng-dev
    libfreetype6-dev
    libsasl2-dev
    tk-dev
    liblzma-dev
    ca-certificates
    curl
    sudo
    bash-completion
    smartmontools
    lm-sensors
    git
    vim
    gawk
    tree
    wget
    rsync
    tmux
    httpie
    nmap
    netcat-openbsd
    mtr-tiny
    tor
    golang
    maven
    default-jdk
    cmake
    ninja-build
    awscli
    syncthing
    wireguard-tools
    ripgrep
    fd-find
    fzf
    bat
    jq
    yq
    zoxide
    git-delta
    gh
    btop
    hyperfine
    poppler-utils
    qpdf
    ocrmypdf
    tesseract-ocr
    tesseract-ocr-chi-sim
    imagemagick
    libimage-exiftool-perl
    pandoc
    ffmpeg
    yt-dlp
'

sudo apt update && sudo apt install -y $APPS

sudo apt install -y eza || echo 'eza not in apt (Debian 12), skipping'

mkdir -p $HOME/.local/bin
[[ -x /usr/bin/fdfind && ! -e $HOME/.local/bin/fd ]] && ln -s /usr/bin/fdfind $HOME/.local/bin/fd
[[ -x /usr/bin/batcat && ! -e $HOME/.local/bin/bat ]] && ln -s /usr/bin/batcat $HOME/.local/bin/bat

# rime input method, only on desktop machines (then run copy-settings.sh to link configs)
if [[ -n $XDG_CURRENT_DESKTOP || -n $DISPLAY || -n $WAYLAND_DISPLAY ]]; then
    sudo apt install -y fcitx5 fcitx5-rime
    command -v im-config >/dev/null 2>&1 && im-config -n fcitx5
fi

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER

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

if ! command -v uv >/dev/null 2>&1; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

if ! command -v duckdb >/dev/null 2>&1; then
    curl -fsSL https://install.duckdb.org | sh
fi

if ! command -v claude >/dev/null 2>&1; then
    curl -fsSL https://claude.ai/install.sh | bash
fi

if [[ ! -x $HOME/.opencode/bin/opencode ]]; then
    curl -fsSL https://opencode.ai/install | bash
fi
