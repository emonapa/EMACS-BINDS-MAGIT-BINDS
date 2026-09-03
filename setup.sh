#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="$(dirname "$DIR")"

FILES=(
    .emacs
    .emacs.custom.el
    .emacs.local
    .emacs.rc
    .emacs.snippets
)

for file in "${FILES[@]}"; do
    ln -sfn "$DIR/dotfiles/$file" "$TARGET/$file"
    echo "$TARGET/$file -> $DIR/dotfiles/$file"
done
