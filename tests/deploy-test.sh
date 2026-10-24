#!/usr/bin/env bash
set -euo pipefail

repo=$(cd "$(dirname "$0")/.." && pwd -P)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
fixture="$tmp/clone with spaces"
export HOME="$tmp/empty home"
mkdir -p "$fixture/starship" "$fixture/nvim" "$fixture/spotifyd" "$fixture/hypr" "$fixture/skhd" "$HOME/.config/nvim" "$HOME/.config/spotifyd"
cp "$repo/deploy.sh" "$fixture/deploy.sh"
printf 'new\n' > "$fixture/.zshrc"
printf 'theme\n' > "$fixture/starship/starship.toml"
printf '[global]\n' > "$fixture/spotifyd/spotifyd.conf"
printf 'old\n' > "$HOME/.zshrc"
printf 'old nvim\n' > "$HOME/.config/nvim/init.lua"
printf 'old spotifyd\n' > "$HOME/.config/spotifyd/spotifyd.conf"
printf 'legacy root config\n' > "$HOME/.spotifyd.conf"

bash "$fixture/deploy.sh" --dry-run > "$tmp/preview"
[[ -f "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]]
[[ -d "$HOME/.config/nvim" && ! -L "$HOME/.config/nvim" ]]
[[ -d "$HOME/.config/spotifyd" && ! -L "$HOME/.config/spotifyd" ]]
[[ ! -e "$HOME/.config/starship.toml" ]]
if compgen -G "$HOME/.zshrc.backup.*" > /dev/null; then
  printf 'Dry run unexpectedly created a backup\n' >&2
  exit 1
fi

bash "$fixture/deploy.sh" --apply > "$tmp/apply"
[[ $(readlink "$HOME/.zshrc") == "$fixture/.zshrc" ]]
[[ $(readlink "$HOME/.config/nvim") == "$fixture/nvim" ]]
[[ $(readlink "$HOME/.config/spotifyd") == "$fixture/spotifyd" ]]
[[ $(readlink "$HOME/.config/starship.toml") == "$fixture/starship/starship.toml" ]]
[[ $(cat "$HOME"/.zshrc.backup.*) == old ]]
[[ $(cat "$HOME"/.config/nvim.backup.*/init.lua) == 'old nvim' ]]
[[ $(cat "$HOME"/.config/spotifyd.backup.*/spotifyd.conf) == 'old spotifyd' ]]
[[ $(cat "$HOME/.spotifyd.conf") == 'legacy root config' ]]
[[ ! -e "$HOME/.config/nvim/nvim" ]]
if [[ $(uname -s) == Linux ]]; then
  [[ $(readlink "$HOME/.config/hypr") == "$fixture/hypr" ]]
  [[ ! -e "$HOME/.config/skhd" ]]
fi

bash "$fixture/deploy.sh" --apply > "$tmp/again"
[[ $(find "$HOME" -name '*.backup.*' | wc -l | tr -d ' ') == 3 ]]
[[ ! -e "$HOME/.config/nvim/nvim" ]]

# A fresh home must get ~/.config, and a dangling symlink must be preserved.
export HOME="$tmp/another empty home"
mkdir -p "$HOME"
ln -s "$tmp/no-such-file" "$HOME/.zshrc"
bash "$fixture/deploy.sh" --apply > "$tmp/fresh"
[[ -d "$HOME/.config" ]]
[[ $(readlink "$HOME/.config/spotifyd") == "$fixture/spotifyd" ]]
[[ $(readlink "$HOME/.zshrc") == "$fixture/.zshrc" ]]
[[ $(readlink "$HOME"/.zshrc.backup.*) == "$tmp/no-such-file" ]]

printf 'deploy test passed\n'
