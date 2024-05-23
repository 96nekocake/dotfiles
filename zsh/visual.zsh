# -----------------------------
# visual Settings
# -----------------------------
autoload -Uz colors ; colors #色を使用
export LSCOLORS=Exfxcxdxbxegedabagacad #色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30' # 補完時の色設定
autoload -U colors ; colors ; zstyle ':completion:*' list-colors "${LS_COLORS}" # 補完候補に色つける
