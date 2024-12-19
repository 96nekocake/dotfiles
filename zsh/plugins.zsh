# plugin
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light paulirish/git-open
zinit light zsh-users/zsh-completions

zinit ice as"program" from"gh-r" mv"fzf* -> fzf" pick"fzf/fzf"
zinit light junegunn/fzf

zinit ice as"program" from"gh-r" mv"ripgrep* -> rg" pick"rg/rg"
zinit light BurntSushi/ripgrep

zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

zinit ice as"program" from"gh-r" mv"eza* -> eza" pick"eza/eza"
zinit light eza-community/eza

zinit ice as"program" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

# setting
bindkey '^j' autosuggest-accept
