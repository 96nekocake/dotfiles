#!/usr/bin/env bash
set -euo pipefail

# Preview by default. Apply only when explicitly requested.
apply=false
case "${1:-}" in
  ""|--dry-run) ;;
  --apply) apply=true ;;
  *) printf 'Usage: %s [--dry-run|--apply]\n' "$0" >&2; exit 2 ;;
esac
if (( $# > 1 )); then
  printf 'Usage: %s [--dry-run|--apply]\n' "$0" >&2
  exit 2
fi

repo_dir=$(cd "$(dirname "$0")" && pwd -P)
config_dir="$HOME/.config"
stamp=$(date +%Y%m%d-%H%M%S)

case "$(uname -s)" in
  Darwin) platform_dirs=(skhd yabai) ;;
  Linux)  platform_dirs=(hypr) ;;
  *) printf 'Unsupported operating system\n' >&2; exit 1 ;;
esac

link_one() {
  local source=$1 destination=$2 backup candidate suffix
  if [[ ! -e "$source" ]]; then
    printf 'Skip missing source: %s\n' "$source"
    return
  fi
  if [[ -L "$destination" && $(readlink "$destination") == "$source" ]]; then
    printf 'Already linked: %s\n' "$destination"
    return
  fi
  if [[ -e "$destination" || -L "$destination" ]]; then
    candidate="${destination}.backup.${stamp}"
    backup=$candidate
    suffix=1
    while [[ -e "$backup" || -L "$backup" ]]; do
      backup="${candidate}.${suffix}"
      ((suffix += 1))
    done
    printf 'Backup: %s -> %s\n' "$destination" "$backup"
    if "$apply"; then mv "$destination" "$backup"; fi
  fi
  printf 'Link: %s -> %s\n' "$destination" "$source"
  if "$apply"; then
    mkdir -p "$(dirname "$destination")"
    ln -s "$source" "$destination"
  fi
}

for file in .zshrc .tmux.conf .gitconfig; do
  link_one "$repo_dir/$file" "$HOME/$file"
done

for dir in nvim wezterm neofetch silicon alacritty "${platform_dirs[@]}"; do
  link_one "$repo_dir/$dir" "$config_dir/$dir"
done
link_one "$repo_dir/starship/starship.toml" "$config_dir/starship.toml"

if "$apply"; then
  printf 'Deployment complete. Backups are next to the original paths.\n'
else
  printf 'Preview only. Run %s --apply to make these changes.\n' "$0"
fi
