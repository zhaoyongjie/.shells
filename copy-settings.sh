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
