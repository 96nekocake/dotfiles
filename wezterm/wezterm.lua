require("format")
require("status")

local wezterm = require("wezterm")

return {
	status_update_interval = 1000,

	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 },
	keys = require("keybinds").keys,
	key_tables = require("keybinds").key_tables,
	-- disable_default_key_bindings = true,
	font = wezterm.font("Cica"),
	use_ime = true,
	font_size = 14.0,
	color_scheme = "iceberg-dark",
	adjust_window_size_when_changing_font_size = false,
	window_background_opacity = 0.3,

	window_frame = {
		font = wezterm.font("Cica"),
		font_size = 14.0,
	},
	-- enable_tab_bar = false,
	window_decorations = "RESIZE",
}
