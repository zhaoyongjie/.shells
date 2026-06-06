# How to use

Edit .bash_profile of current user

```
export WORK_PATH=$HOME/workspace
source $HOME/.shells/.bashrc
```

# Initialize a new machine

macOS (Homebrew, edit init-macOS.sh to customize):

```
./init-macOS.sh
```

Debian 12/13:

```
./init-debian.sh
```

# Symlink the configuration files into the user home

```
./copy-settings.sh
```
