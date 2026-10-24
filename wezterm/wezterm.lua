require("format")
-- require("status")

local wezterm = require("wezterm")

return {
	initial_cols = 100,
	initial_rows = 40,
	font_size = 15.0,
	cell_width = 1.0,
	line_height = 1.0,
	status_update_interval = 1000,
	color_scheme = "iceberg-dark",
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	window_background_opacity = 0.8,
	text_background_opacity = 0.8,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 },
	keys = require("keybinds").keys,
	key_tables = require("keybinds").key_tables,
	-- disable_default_key_bindings = true,
	font = wezterm.font("Cica"),
	use_ime = true,
	adjust_window_size_when_changing_font_size = false,

	window_frame = {
		font = wezterm.font("Cica"),
		font_size = 14.0,
	},
	-- enable_tab_bar = false,
	window_decorations = "RESIZE",

	-- default_prog = { "wezterm", "start", "--always-new-process" },
}
