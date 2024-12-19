return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "f3fora/cmp-spell", -- 英語入力時のスペル補完ソース
      "hrsh7th/cmp-nvim-lsp", -- LSPからの補完
      "hrsh7th/cmp-buffer", -- バッファからの補完
      "hrsh7th/cmp-path", -- ファイルパスからの補完
      "hrsh7th/cmp-cmdline", -- コマンドラインでの補完
      "onsails/lspkind.nvim", -- 補完候補にアイコンを追加するプラグイン
      "L3MON4D3/LuaSnip", -- スニペットエンジン
      "saadparwaiz1/cmp_luasnip", -- LuaSnipとの連携
      "rafamadriz/friendly-snippets", -- 多くの言語用のスニペット集
    },
    config = function()
      -- 基本設定
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- friendly-snippetsを読み込む
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- LuaSnipを使ってスニペットを展開
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enterキーで選択した補完を確定
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- LSPからの補完
          { name = "luasnip" }, -- スニペットからの補完
          { name = "buffer" }, -- バッファからの補完
          { name = "path" }, -- ファイルパスからの補完
        }),
      })

      -- コマンドラインでの補完設定
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
}
