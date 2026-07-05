#!/usr/bin/env bash
set -e

source "$(dirname "$0")/environments.sh"

if [[ -n $GLOBAL_NODE_PATH ]]; then
    "$(dirname "$GLOBAL_NODE_PATH")/npm" install -g typescript-language-server typescript pyright
else
    echo "skipped npm installs: global node not found"
fi

if [[ -n $GLOBAL_PYTHON_PATH ]]; then
    "$GLOBAL_PYTHON_PATH" -m pip install -r "$(dirname "$0")/requirements.txt"
else
    echo "skipped pip installs: global python not found"
fi

go install golang.org/x/tools/gopls@latest
rustup component add rust-analyzer
