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
'
sudo apt update && sudo apt install -y $APPS

# install docker-ce
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt update && sudo apt install -y docker-ce
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod a+x /usr/local/bin/docker-compose
sudo usermod -aG docker $USER

# install python
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
$HOME/.pyenv/bin/pyenv install 3.6.8
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $HOME/.pyenv/plugins/pyenv-virtualenvwrapper

# install node
curl -L https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# install openJDK
wget https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u242-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u242b08.tar.gz -O /tmp/openjdk.tar.gz
tar -xf /tmp/openjdk.tar.gz -C /opt

sudo apt-add-repository -y ppa:adrozdoff/emacs
sudo apt update
sudo apt install -y emacs25
