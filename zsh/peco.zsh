function peco-history-selection() {
    BUFFER=$(history -n 1 | awk '{ lines[NR]=$0 } END { for (i=NR; i>0; i--) print lines[i] }' | awk '!seen[$0]++' | peco) || return
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

function peco-cdr() {
    local selected_dir
    selected_dir=$(cdr -l | sed -E 's/^[[:space:]]*[0-9]+[[:space:]]+//' | peco --prompt='cdr >' --query "$LBUFFER") || return
    if [[ -n "$selected_dir" ]]; then
        BUFFER="cd -- ${(q)selected_dir}"
        zle accept-line
    fi
}

zle -N peco-cdr
bindkey '^E' peco-cdr
