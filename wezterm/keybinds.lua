local wezterm = require("wezterm")
local act = wezterm.action

return {
	keys = {
		{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
		{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
		{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

		{ key = "v", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "d", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

		{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
		{ key = "]", mods = "LEADER", action = act.PasteFrom("Clipboard") },
		{ key = "C", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
		{ key = "V", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },

		{ key = "N", mods = "CMD", action = wezterm.action({ SpawnCommandInNewWindow = {} }) },
	},
}
