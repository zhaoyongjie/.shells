# dotfiles

Personal shell setup and machine bootstrap scripts (macOS + Debian).

# How to use

```
git clone <this repo> ~/.shells
cd ~/.shells
./init-macOS.sh      # or ./init-debian.sh
./copy-settings.sh
./install-utils.sh
```

Then add to `.bash_profile` (or `.zprofile`) of the current user:

```
export WORK_PATH=$HOME/workspace
source $HOME/.shells/.bashrc
```

# Scripts

- `environments.sh` - pins global Python/Node versions (`GLOBAL_PYTHON_VERSION`,
  `GLOBAL_NODE_VERSION`) and resolves `GLOBAL_PYTHON_PATH` / `GLOBAL_NODE_PATH`
  from pyenv/nvm. Sourced by the other scripts; edit this file to bump versions.
- `init-macOS.sh` - installs GUI and CLI apps via Homebrew.
- `init-debian.sh` - installs GUI and CLI apps via apt.
- `install-utils.sh` - installs language servers (npm), Python packages
  (`requirements.txt`), gopls, and rust-analyzer using the versions from
  `environments.sh`.
- `copy-settings.sh` - symlinks the dotfiles/configs in this repo into
  `$HOME` (`.bashrc`, `.gitconfig`, `.inputrc`, `.tmux.conf`, `.pip.conf`,
  starship config, mpv config, Claude/Codex/opencode agent config and
  skills, macOS key bindings, Zed CLI, Rime/Squirrel input method configs).

# Layout

- `agent/` - `CLAUDE.md`, `settings.json`, and `skills/` shared across
  Claude Code, Codex, and opencode.
- `mpv/` - mpv player config and scripts.
- `squirrel/` - Rime/Squirrel input method configs (macOS Squirrel and
  Linux fcitx5-rime).
- `themes/` - terminal/editor color themes (Tomorrow Night Bright).
- `requirements.txt` - Python packages installed by `install-utils.sh`.
