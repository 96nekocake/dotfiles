-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.opt.clipboard = "unnamedplus"

vim.cmd([[
  let g:denops#enable = 1
]])

vim.g.silicon_options = {
  font = "Cica",
  no_line_number = false,
  no_round_corner = false,
  no_window_controls = false,
  background_color = "#333333", -- 背景色
  line_offset = 1,
  line_pad = 2,
  pad_horiz = 80,
  pad_vert = 100,
  shadow_blur_radius = 0,
  shadow_color = "#555555",
  shadow_offset_x = 0,
  shadow_offset_y = 0,
  tab_width = 4,
}
