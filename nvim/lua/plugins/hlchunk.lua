return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" }, -- NeovimのUIが起動したときにロード
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          use_treesitter = true,
          style = {
            -- { fg = "#A0A0A0" }, -- カスタムカラー
            { fg = "#FF5733" }, -- カスタムカラー
          },
        },
        indent = {
          enable = false,
          chars = { "│" },
          style = {
            { fg = "#707070" }, -- インデントラインの色
          },
        },
        line_num = {
          enable = true, -- 行番号のハイライト
        },
        blank = {
          enable = true, -- 空白行のハイライト
        },
      })
    end,
  },
}
