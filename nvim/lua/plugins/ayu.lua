return {
  "ayu-theme/ayu-vim",
  config = function()
    -- テーマスタイルを設定 (light, mirage, dark のいずれか)
    vim.g.ayucolor = "mirage"
    vim.cmd("colorscheme ayu")
  end,
}
