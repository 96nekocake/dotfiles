#!/usr/bin/env bash
set -euo pipefail

repo=$(cd "$(dirname "$0")/.." && pwd -P)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
fixture="$tmp/clone with spaces"
export HOME="$tmp/empty home"
mkdir -p "$fixture/starship" "$fixture/nvim" "$fixture/hypr" "$fixture/skhd" "$HOME/.config/nvim"
cp "$repo/deploy.sh" "$fixture/deploy.sh"
printf 'new\n' > "$fixture/.zshrc"
printf 'theme\n' > "$fixture/starship/starship.toml"
printf 'old\n' > "$HOME/.zshrc"
printf 'old nvim\n' > "$HOME/.config/nvim/init.lua"

bash "$fixture/deploy.sh" --dry-run > "$tmp/preview"
[[ -f "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]]
[[ -d "$HOME/.config/nvim" && ! -L "$HOME/.config/nvim" ]]
[[ ! -e "$HOME/.config/starship.toml" ]]
if compgen -G "$HOME/.zshrc.backup.*" > /dev/null; then
  printf 'Dry run unexpectedly created a backup\n' >&2
  exit 1
fi

bash "$fixture/deploy.sh" --apply > "$tmp/apply"
[[ $(readlink "$HOME/.zshrc") == "$fixture/.zshrc" ]]
[[ $(readlink "$HOME/.config/nvim") == "$fixture/nvim" ]]
[[ $(readlink "$HOME/.config/starship.toml") == "$fixture/starship/starship.toml" ]]
[[ $(cat "$HOME"/.zshrc.backup.*) == old ]]
[[ $(cat "$HOME"/.config/nvim.backup.*/init.lua) == 'old nvim' ]]
[[ ! -e "$HOME/.config/nvim/nvim" ]]
if [[ $(uname -s) == Linux ]]; then
  [[ $(readlink "$HOME/.config/hypr") == "$fixture/hypr" ]]
  [[ ! -e "$HOME/.config/skhd" ]]
fi

bash "$fixture/deploy.sh" --apply > "$tmp/again"
[[ $(find "$HOME" -name '*.backup.*' | wc -l | tr -d ' ') == 2 ]]
[[ ! -e "$HOME/.config/nvim/nvim" ]]

# A fresh home must get ~/.config, and a dangling symlink must be preserved.
export HOME="$tmp/another empty home"
mkdir -p "$HOME"
ln -s "$tmp/no-such-file" "$HOME/.zshrc"
bash "$fixture/deploy.sh" --apply > "$tmp/fresh"
[[ -d "$HOME/.config" ]]
[[ $(readlink "$HOME/.zshrc") == "$fixture/.zshrc" ]]
[[ $(readlink "$HOME"/.zshrc.backup.*) == "$tmp/no-such-file" ]]

printf 'deploy test passed\n'
