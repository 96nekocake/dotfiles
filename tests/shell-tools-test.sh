#!/usr/bin/env bash
set -euo pipefail

repo=$(cd "$(dirname "$0")/.." && pwd -P)
zsh -n "$repo/zsh/peco.zsh" "$repo/zsh/plugins.zsh"
[[ $(printf '1  /tmp/a b\n' | sed -E 's/^[[:space:]]*[0-9]+[[:space:]]+//') == '/tmp/a b' ]]

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
git init -q --bare "$tmp/remote.git"
git init -q "$tmp/work"
git -C "$tmp/work" -c user.name=Test -c user.email=test@example.invalid commit -q --allow-empty -m seed
git -C "$tmp/work" branch topic
git -C "$tmp/work" remote add origin "$tmp/remote.git"
git -C "$tmp/work" push -q origin topic

GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG_GLOBAL="$repo/.gitconfig" git -C "$tmp/work" brdel topic > "$tmp/deletion.log"
[[ -z $(git -C "$tmp/work" ls-remote --heads origin topic) ]]
if GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG_GLOBAL="$repo/.gitconfig" git -C "$tmp/work" brdel > "$tmp/usage.log" 2>&1; then
  printf 'Git alias accepted a missing branch name\n' >&2
  exit 1
fi

printf 'shell tools test passed\n'
