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
    libmysqlclient-dev
    tk-dev

    apt-transport-https
    ca-certificates
    curl
    gnupg2
    software-properties-common
    openjdk-8-jdk
    git
'
sudo apt update && sudo apt install -y $APPS
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

curl -sL https://deb.nodesource.com/setup_8.x | sudo bash
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo add-apt-repository "deb https://dl.yarnpkg.com/debian/ stable main"

sudo apt update && sudo apt install nodejs yarn docker-ce

curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
pyenv install 2.7.15
pyenv install 3.6.6

sudo apt-add-repository -y ppa:adrozdoff/emacs
sudo apt update
sudo apt install emacs25

