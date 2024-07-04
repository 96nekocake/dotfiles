#!/bin/bash

directories=(nvim sketchybar skhd wezterm yabai neofetch silicon alacritty hypr)
files=(.zshrc .tmux.conf .gitconfig .gitconfig.local)

# デプロイ確認
read -p "ドットファイルを更新しますか？ (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit 1
fi

# ドットファイルのシンボリック作成
for file in "${files[@]}"; do
  if [ -e "$HOME/dotfiles/$file" ]; then
    ln -svf "$HOME/dotfiles/$file" "$HOME/"
  else
    echo "警告: $file が存在しません、スキップします"
  fi
done

# ディレクトリのシンボリック作成
for dirName in "${directories[@]}"; do
  if [ -d "$HOME/dotfiles/$dirName" ]; then
    ln -svf "$HOME/dotfiles/$dirName/" "$HOME/.config/"
  else
    echo "警告: ディレクトリ $dirName が存在しません、スキップします"
  fi
done

echo "Deployment complete!"
