# -----------------------------
# Basic settings
# -----------------------------
setopt auto_cd #cd省略
setopt no_beep #ピープ音を鳴らさないように変更
setopt auto_param_keys #括弧の対応を自動補完
setopt correct #コマンドスペルチェック
setopt correct_all #コマンドラインのスペルチェック
setopt complete_in_word # 単語の入力途中でもtab補完有効化
setopt correct # コマンドミスを修正
setopt auto_list # 補完候補を一覧表示にする
setopt auto_menu # TAB で順に補完候補を切り替える
setopt no_flow_control
autoload -Uz compinit && compinit # 自動補完
function chpwd() { ls } # 自動ls
