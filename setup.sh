CURR_DIR=`pwd`

if [ ! -f ~/.eslintrc ]; then
    ln -s "$CURR_DIR/.eslintrc" ~/.eslintrc
fi

if [ ! -f ~/.pylintrc ]; then
    ln -s "$CURR_DIR/.pylintrc" ~/.pylintrc
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
