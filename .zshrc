# Keep Powerlevel10k's instant prompt near the beginning of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zinit installs itself on the first interactive startup.
if [[ ! -f "$HOME/.local/share/zinit/zinit.git/zinit.zsh" ]]; then
  print -P "%F{33}Installing zinit…%f"
  command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
  command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" ||
    print -P "%F{160}The zinit installation failed.%f"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# :A resolves the ~/.zshrc symlink to its checkout, including paths with spaces.
SCRIPT_DIR="${${(%):-%x}:A:h}"

source "$SCRIPT_DIR/zsh/alias.zsh"
source "$SCRIPT_DIR/zsh/plugins.zsh"
source "$SCRIPT_DIR/zsh/basic.zsh"
source "$SCRIPT_DIR/zsh/visual.zsh"
source "$SCRIPT_DIR/zsh/history.zsh"
source "$SCRIPT_DIR/zsh/complement.zsh"

# Initialize completion once, after zsh-completions has been added to fpath.
autoload -Uz compinit
compinit

source "$SCRIPT_DIR/zsh/cdr.zsh"
if (( $+commands[peco] )); then
  source "$SCRIPT_DIR/zsh/peco.zsh"
fi

export PATH="$PATH:$HOME/bin:/usr/local/go/bin"

if [[ "$OSTYPE" == darwin* ]]; then
  source "$SCRIPT_DIR/zsh/macos.zsh"
  if (( $+commands[brew] )); then
    java_prefix=$(brew --prefix openjdk@17 2>/dev/null) || java_prefix=''
    if [[ -n "$java_prefix" && -d "$java_prefix/bin" ]]; then
      export JAVA_HOME="$java_prefix"
      export PATH="$JAVA_HOME/bin:$PATH"
    fi
    unset java_prefix
  fi
fi

# Load the prompt configuration only once.
[[ ! -r "$SCRIPT_DIR/zsh/p10k.zsh" ]] || source "$SCRIPT_DIR/zsh/p10k.zsh"

export NVM_DIR="$HOME/.nvm"
[[ ! -s "$NVM_DIR/nvm.sh" ]] || source "$NVM_DIR/nvm.sh"
[[ ! -s "$NVM_DIR/bash_completion" ]] || source "$NVM_DIR/bash_completion"
export EDITOR=nvim
