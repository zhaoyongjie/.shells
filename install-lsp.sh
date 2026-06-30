#!/usr/bin/env bash
set -e

npm install -g typescript-language-server typescript
npm install -g pyright
go install golang.org/x/tools/gopls@latest
rustup component add rust-analyzer
