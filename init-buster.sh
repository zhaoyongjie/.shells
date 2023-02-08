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
    apt-transport-https
    ca-certificates
    curl
    gnupg2
    software-properties-common
    git
    sudo
    vim
    net-tools
    httpie
    gnumeric
    rsync
    liblzma-dev
    tmux
    supervisor
    smartmontools
    lm-sensors
'
sudo apt update && sudo apt install -y $APPS

# install docker and plugins
sudo mkdir -m 0755 -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER

# install python
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
$HOME/.pyenv/bin/pyenv install 3.9.16
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $HOME/.pyenv/plugins/pyenv-virtualenvwrapper

# install node
curl -L https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
# nvm install --lts

# install openJDK
wget https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u242-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u242b08.tar.gz -O /tmp/openjdk.tar.gz
sudo tar -xf /tmp/openjdk.tar.gz -C /opt

# sudo apt-add-repository -y ppa:adrozdoff/emacs
# sudo apt update
# sudo apt install -y emacs25
