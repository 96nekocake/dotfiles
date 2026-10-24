local handlers = {}
package.preload.wezterm = function()
  return {
    on = function(event, callback)
      handlers[event] = callback
    end,
  }
end

dofile("wezterm/format.lua")

local window_title = assert(handlers["format-window-title"])
assert(window_title({ active_pane = { foreground_process_name = "/usr/bin/zsh", title = "shell" } }) == "zsh")
assert(window_title({ active_pane = { foreground_process_name = [[C:\Tools\pwsh.exe]], title = "shell" } }) == "pwsh.exe")
assert(window_title({ active_pane = { foreground_process_name = nil, title = "remote shell" } }) == "remote shell")

local tab_title = assert(handlers["format-tab-title"])
local active = tab_title({ is_active = true, active_pane = { is_zoomed = false, title = "shell" } }, {}, {}, {}, false, 40)
assert(active[1].Foreground.Color == "#ffb2cc")
assert(active[6].Text == "shell")

local inactive = tab_title({ is_active = false, active_pane = { is_zoomed = true, title = "editor" } }, {}, {}, {}, true, 40)
assert(inactive[1].Foreground.Color == "#a4a4a4")
assert(inactive[2].Background.Color == "#434343")
assert(inactive[3].Text:find("🔎", 1, true))

print("WezTerm format callbacks passed")
