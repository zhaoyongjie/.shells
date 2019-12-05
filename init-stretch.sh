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
    openjdk-8-jdk
    git
    sudo
    vim
    net-tools
    httpie
    mysql-client
    gnumeric
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
$HOME/.pyenv/bin/pyenv install 2.7.16
$HOME/.pyenv/bin/pyenv install 3.6.8
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $HOME/.pyenv/plugins/pyenv-virtualenvwrapper

# install node
curl -L https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

sudo apt-add-repository -y ppa:adrozdoff/emacs
sudo apt update
sudo apt install -y emacs25
