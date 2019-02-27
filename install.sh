CURR_DIR=`pwd`

if [ ! -f ~/.bashrc ]; then
    ln -s "$CURR_DIR/.bashrc" ~/.bashrc
fi

if [ ! -f ~/.git-completion.bash ]; then
    ln -s "$CURR_DIR/.git-completion.bash" ~/.git-completion.bash
fi

if [ ! -f ~/.gitconfig ]; then
    ln -s "$CURR_DIR/.gitconfig" ~/.gitconfig
fi

if [ ! -f ~/.inputrc ]; then
    ln -s "$CURR_DIR/.inputrc" ~/.inputrc
fi

if [ ! -f ~/.tmux.conf ]; then
    ln -s "$CURR_DIR/.tmux.conf" ~/.tmux.conf
fi

if [ ! -f ~/.npmrc ]; then
    ln -s "$CURR_DIR/.npmrc" ~/.npmrc
fi

if [ ! -f ~/.pip.conf ]; then
    ln -s "$CURR_DIR/.pip.conf" ~/.pip.conf
fi

if [[ -x "$(command -v ipython)" && ! -f "$CURR_DIR/ipython_config.py" ]]; then
    ln -s "$CURR_DIR/ipython_config.py" ~/.ipython/profile_default/ipython_config.py
fi

RIME_DIR=~/Library/Rime
if [[ -d ~/Library/Rime && ! -f "$RIME_DIR/squirrel/default.custom.yaml" ]]; then
    ln -s "$CURR_DIR/squirrel/default.custom.yaml" $RIME_DIR/default.custom.yaml
    ln -s "$CURR_DIR/squirrel/squirrel.custom.yaml" $RIME_DIR/squirrel.custom.yaml
    ln -s "$CURR_DIR/squirrel/alternative.yaml" $RIME_DIR/alternative.yaml
    ln -s "$CURR_DIR/squirrel/luna_pinyin.custom.yaml" $RIME_DIR/luna_pinyin.custom.yaml
fi
