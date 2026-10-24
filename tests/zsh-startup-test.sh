#!/usr/bin/env bash
set -euo pipefail

repo=$(cd "$(dirname "$0")/.." && pwd -P)
for file in .zshrc zsh/basic.zsh zsh/complement.zsh zsh/macos.zsh; do
  zsh -n "$repo/$file"
done

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
export HOME="$tmp/home"
export ZDOTDIR="$HOME"
export EXPECTED_REPO="$tmp/clone with spaces"
mkdir -p "$HOME/.local/share/zinit/zinit.git" "$HOME/stubfuncs" "$EXPECTED_REPO/zsh/myPlug"
ln -s "$EXPECTED_REPO/.zshrc" "$HOME/.zshrc"
cp "$repo/.zshrc" "$EXPECTED_REPO/.zshrc"
cp "$repo/zsh/basic.zsh" "$repo/zsh/complement.zsh" "$repo/zsh/macos.zsh" "$EXPECTED_REPO/zsh/"

printf '%s\n' 'zinit() { :; }' > "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
printf '%s\n' 'compinit() { print -r -- compinit >> "$HOME/compinit.calls"; }' > "$HOME/stubfuncs/compinit"
for file in alias plugins visual history cdr peco; do
  printf '%s\n' ':' > "$EXPECTED_REPO/zsh/$file.zsh"
done
printf '%s\n' 'print -r -- prompt >> "$HOME/prompt.calls"' > "$EXPECTED_REPO/zsh/p10k.zsh"
printf '%s\n' 'print -r -- browser >> "$HOME/browser.calls"' > "$EXPECTED_REPO/zsh/myPlug/browserSearch.zsh"

zsh -fic 'fpath=("$HOME/stubfuncs" $fpath); source "$HOME/.zshrc"; [[ "$SCRIPT_DIR" == "$EXPECTED_REPO" ]] || exit 1'
[[ $(wc -l < "$HOME/compinit.calls") -eq 1 ]]
[[ $(wc -l < "$HOME/prompt.calls") -eq 1 ]]

# The macOS module must also use the resolved checkout path.
zsh -fc 'SCRIPT_DIR="$EXPECTED_REPO"; source "$SCRIPT_DIR/zsh/macos.zsh"'
[[ $(wc -l < "$HOME/browser.calls") -eq 1 ]]
printf 'zsh startup test passed\n'
