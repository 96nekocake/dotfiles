return {
  {
    "skanehira/denops-silicon.vim",
    dependencies = { "vim-denops/denops.vim" },
    cond = function()
      return vim.fn.executable("deno") == 1
    end,
    init = function()
      vim.g["denops#enable"] = 1
      vim.g.silicon_options = {
        font = "Cica",
        no_line_number = false,
        no_round_corner = false,
        no_window_controls = false,
        background_color = "#333333",
        line_offset = 1,
        line_pad = 2,
        pad_horiz = 80,
        pad_vert = 100,
        shadow_blur_radius = 0,
        shadow_color = "#555555",
        shadow_offset_x = 0,
        shadow_offset_y = 0,
        tab_width = 4,
        theme = "Dracula",
      }
    end,
  },
}
