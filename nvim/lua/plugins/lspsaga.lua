return {
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach", -- LSPがアタッチされたときにプラグインをロード
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } }, -- アイコンの表示に必要
  },
}
