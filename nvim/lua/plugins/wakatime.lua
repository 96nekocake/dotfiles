return {
  {
    "wakatime/vim-wakatime",
    lazy = false,
    cond = function()
      return (vim.env.WAKATIME_API_KEY or "") ~= ""
        or vim.fn.filereadable(vim.fn.expand("~/.wakatime.cfg")) == 1
    end,
  },
}
