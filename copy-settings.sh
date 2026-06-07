#!/usr/bin/env bash
# symlink settings into $HOME, e.g. .bashrc -> ~/.bashrc

CURR_DIR=$(pwd)

DOTFILES='
    .bashrc
    .gitconfig
    .inputrc
    .tmux.conf
    .pip.conf
'

for f in $DOTFILES; do
    target=$HOME/$f
    if [[ -L $target || ! -e $target ]]; then
        # missing or already a symlink (possibly stale): (re)link it
        ln -sfn "$CURR_DIR/$f" "$target"
        echo "linked $target -> $CURR_DIR/$f"
    else
        echo "skipped $target: real file exists, move it away first"
    fi
done

mkdir -p $HOME/.config
if [[ -L $HOME/.config/starship.toml || ! -e $HOME/.config/starship.toml ]]; then
    ln -sfn "$CURR_DIR/starship.toml" "$HOME/.config/starship.toml"
    echo "linked $HOME/.config/starship.toml -> $CURR_DIR/starship.toml"
fi

mkdir -p $HOME/.claude
for f in CLAUDE.md settings.json; do
    target=$HOME/.claude/$f
    if [[ -L $target || ! -e $target ]]; then
        ln -sfn "$CURR_DIR/agent/$f" "$target"
        echo "linked $target -> $CURR_DIR/agent/$f"
    else
        echo "skipped $target: real file exists, move it away first"
    fi
done

mkdir -p $HOME/.agents $HOME/.codex
for target in $HOME/.claude/skills $HOME/.agents/skills $HOME/.codex/skills; do
    if [[ -L $target || ! -e $target ]]; then
        ln -sfn "$CURR_DIR/agent/skills" "$target"
        echo "linked $target -> $CURR_DIR/agent/skills"
    else
        echo "skipped $target: real dir exists, move it away first"
    fi
done

mkdir -p $HOME/.config/opencode
for target in $HOME/.config/opencode/AGENTS.md $HOME/.codex/AGENTS.md; do
    if [[ -L $target || ! -e $target ]]; then
        ln -sfn "$CURR_DIR/agent/CLAUDE.md" "$target"
        echo "linked $target -> $CURR_DIR/agent/CLAUDE.md"
    fi
done

if [[ -L $HOME/.config/mpv || ! -e $HOME/.config/mpv ]]; then
    ln -sfn "$CURR_DIR/mpv" "$HOME/.config/mpv"
    echo "linked $HOME/.config/mpv -> $CURR_DIR/mpv"
else
    echo "skipped $HOME/.config/mpv: real dir exists, move it away first"
fi

# rime / squirrel (macOS)
RIME_DIR=$HOME/Library/Rime
if [[ -d $RIME_DIR && (-L $RIME_DIR/default.custom.yaml || ! -e $RIME_DIR/default.custom.yaml) ]]; then
    ln -sfn "$CURR_DIR/squirrel/default.custom.yaml" "$RIME_DIR/default.custom.yaml"
    ln -sfn "$CURR_DIR/squirrel/squirrel.custom.yaml" "$RIME_DIR/squirrel.custom.yaml"
    ln -sfn "$CURR_DIR/squirrel/alternative.yaml" "$RIME_DIR/alternative.yaml"
    ln -sfn "$CURR_DIR/squirrel/luna_pinyin.custom.yaml" "$RIME_DIR/luna_pinyin.custom.yaml"
    echo "linked rime configs to $RIME_DIR"
fi

# rime on linux, fcitx5 (apt install fcitx5-rime); squirrel.custom.yaml is macOS-only
RIME_DIR=$HOME/.local/share/fcitx5/rime
if [[ -d $RIME_DIR && (-L $RIME_DIR/default.custom.yaml || ! -e $RIME_DIR/default.custom.yaml) ]]; then
    ln -sfn "$CURR_DIR/squirrel/default.custom.yaml" "$RIME_DIR/default.custom.yaml"
    ln -sfn "$CURR_DIR/squirrel/alternative.yaml" "$RIME_DIR/alternative.yaml"
    ln -sfn "$CURR_DIR/squirrel/luna_pinyin.custom.yaml" "$RIME_DIR/luna_pinyin.custom.yaml"
    echo "linked rime configs to $RIME_DIR"
fi
