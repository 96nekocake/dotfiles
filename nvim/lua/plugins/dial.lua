return {
  {
    "monaqa/dial.nvim",
    event = "VeryLazy",
    config = function()
      local dial = require("dial.map")
      local augend = require("dial.augend")

      -- キーマッピングの設定
      vim.keymap.set("n", "<C-z>", dial.inc_normal(), { noremap = true })
      vim.keymap.set("n", "<C-x>", dial.dec_normal(), { noremap = true })
      vim.keymap.set("v", "<C-z>", dial.inc_visual(), { noremap = true })
      vim.keymap.set("v", "<C-x>", dial.dec_visual(), { noremap = true })

      -- カスタムのインクリメンターテーブルの作成
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal, -- 数値のインクリメント
          augend.constant.new({ -- true/falseのトグル設定
            elements = { "true", "false" },
            word = true, -- 単語全体を対象にする
            cyclic = true, -- 循環する（falseの次はtrueに戻る）
          }),
        },
      })
    end,
  },
}
