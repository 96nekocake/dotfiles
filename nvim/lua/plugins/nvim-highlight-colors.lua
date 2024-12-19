return {
  {
    "brenoprata10/nvim-highlight-colors",
    version = "*",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background", -- 'background' or 'foreground' to render the color
        enable_named_colors = true, -- 名前付きカラーをハイライト
        enable_tailwind = false, -- TailwindCSSのクラスをハイライト
      })
    end,
  },
}
