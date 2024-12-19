return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20, -- ターミナルのデフォルトサイズ
        open_mapping = [[<C-\>]], -- ターミナルを開くためのキーバインド
        hide_numbers = true, -- バッファ番号を非表示にする
        shade_filetypes = {},
        shade_terminals = true, -- ターミナルの色調整を有効化
        shading_factor = 2, -- 色の濃さの調整
        start_in_insert = true, -- ターミナルを開いたときに挿入モードで開始
        insert_mappings = true, -- 挿入モードでのキーバインドを有効にする
        terminal_mappings = true, -- ターミナルモードでのキーマッピングを有効にする
        persist_size = true, -- ターミナルのサイズを記憶
        direction = "horizontal", -- ターミナルの表示方法（horizontal, vertical, float）
        close_on_exit = true, -- プロセス終了時にターミナルを閉じる
        shell = vim.o.shell, -- 使用するシェル
      })
    end,
  },
}
