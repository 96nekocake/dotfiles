function peco-history-selection() {
    local selection
    selection=$(history -n 1 | awk '{ lines[NR]=$0 } END { for (i=NR; i>0; i--) print lines[i] }' | awk '!seen[$0]++' | peco) || { zle reset-prompt; return; }
    [[ -n "$selection" ]] || { zle reset-prompt; return; }
    BUFFER=$selection
    CURSOR=${#BUFFER}
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

function peco-cdr() {
    local selected_dir
    selected_dir=$(cdr -l | sed -E 's/^[[:space:]]*[0-9]+[[:space:]]+//' | peco --prompt='cdr >' --query "$LBUFFER") || { zle reset-prompt; return; }
    if [[ -n "$selected_dir" ]]; then
        if [[ "$selected_dir" == '~' || "$selected_dir" == '~/'* ]]; then
            selected_dir=${selected_dir/#\~/$HOME}
        fi
        BUFFER="cd -- ${(q)selected_dir}"
        zle accept-line
    else
        zle reset-prompt
    fi
}

zle -N peco-cdr
bindkey '^E' peco-cdr
