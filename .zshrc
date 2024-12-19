# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -----------------------------
# Added by Zinit's installer
# -----------------------------

if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# -----------------------------
# End of Zinit's installer chunk
# -----------------------------

SCRIPT_DIR=$HOME/dotfiles

source $SCRIPT_DIR/zsh/alias.zsh
source $SCRIPT_DIR/zsh/plugins.zsh
source $SCRIPT_DIR/zsh/p10k.zsh
source $SCRIPT_DIR/zsh/peco.zsh
source $SCRIPT_DIR/zsh/cdr.zsh
source $SCRIPT_DIR/zsh/basic.zsh
source $SCRIPT_DIR/zsh/visual.zsh
source $SCRIPT_DIR/zsh/history.zsh
source $SCRIPT_DIR/zsh/complement.zsh

PATH=$PATH:$HOME/bin:/usr/local/go/bin


export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
export PATH="$JAVA_HOME/bin:$PATH"

# Load OS specific settings

if [[ "$OSTYPE" == "darwin"* ]]; then
    source $SCRIPT_DIR/zsh/macos.zsh
fi

# To customize prompt, run `p10k configure` or edit ~/dotfiles/zsh/p10k.zsh.
[[ ! -f ~/dotfiles/zsh/p10k.zsh ]] || source ~/dotfiles/zsh/p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/opt/openjdk@17/bin:$PATH"
export EDITOR=nvim
