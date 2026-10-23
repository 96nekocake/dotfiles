#!/usr/bin/env bash
set -euo pipefail

repo=$(cd "$(dirname "$0")/.." && pwd -P)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
export XDG_CONFIG_HOME="$tmp/config"
export XDG_DATA_HOME="$tmp/data"
export XDG_STATE_HOME="$tmp/state"
export XDG_CACHE_HOME="$tmp/cache"
mkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME"
ln -s "$repo/nvim" "$XDG_CONFIG_HOME/nvim"

# Install plugins in a disposable XDG tree. Keep failures visible to Actions.
log="$tmp/nvim.log"
timeout 240 nvim --headless '+Lazy! sync' '+qa' 2>&1 | tee "$log"
timeout 60 nvim --headless \
  -c 'lua if not package.loaded.lazy then vim.cmd("cquit 1") end' \
  -c 'qa' 2>&1 | tee -a "$log"
if grep -E 'Error in command line:|Failed to run `config`|Vim:E[0-9]+|Error detected while processing' "$log"; then
  printf 'Neovim reported a startup or plugin error\n' >&2
  exit 1
fi
printf 'Neovim headless smoke test passed\n'
