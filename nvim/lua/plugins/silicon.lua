return {
  "vim-denops/denops.vim", -- 依存プラグイン
  {
    "skanehira/denops-silicon.vim", -- denops-siliconの追加
    dependencies = { "vim-denops/denops.vim" },
    config = function()
      vim.g.silicon = {
        theme = "Dracula", -- 使用するテーマ
        background = "#000000", -- 背景色を黒に変更
        font = "Hack", -- 使用するフォント
      }
    end,
  },
}
