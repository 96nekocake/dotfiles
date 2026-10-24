return {
  {
    "anuvyklack/pretty-fold.nvim",
    config = function()
      require("pretty-fold").setup({
        fill_char = "─", -- 折りたたみの線に使う文字
        sections = {
          left = {
            "content", -- 折りたたまれた行の内容を左側に表示
          },
          right = {
            " ",
            "number_of_folded_lines",
            ": ",
            "percentage",
            " ── ",
            "function_name",
          },
        },
        remove_fold_markers = true, -- 折りたたみマーカーを表示しない
        keep_indentation = true, -- インデントを維持する
        process_comment_signs = "delete", -- コメントを削除して表示
        add_close_pattern = true, -- 閉じるパターンを追加
        matchup_patterns = {
          { "def", "end" }, -- 関数の開始と終了に対するパターン
          { "{", "}" }, -- ブロックの開始と終了
          { "%(", "%)" }, -- 丸括弧のペア
        },
      })
    end,
  },
}
