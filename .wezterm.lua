-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
-- Ligatures: => -> !=
-- config.font = wezterm.font("Hack Nerd Font Mono")
config.font = wezterm.font("Maple Mono")
config.line_height = 1.5
config.font_size = 10
-- config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }

-- appearance
config.use_fancy_tab_bar = false
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.6
config.text_background_opacity = 0.3
config.window_padding = {
	left = 5,
	right = 3,
	top = 5,
	bottom = 5,
}

config.initial_rows = 40
config.initial_cols = 160

--keymaps (experimental)
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
	},
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "t", mods = "LEADER", action = act.ActivateKeyTable({ name = "change_page", one_shot = true }) },
	{ key = "|", mods = "LEADER|SHIFT", action = act.SplitPane({ direction = "Right", size = { Percent = 50 } }) },
	{ key = "\\", mods = "LEADER", action = act.SplitPane({ direction = "Right", size = { Percent = 25 } }) },
	{ key = "_", mods = "LEADER|SHIFT", action = act.SplitPane({ direction = "Down", size = { Percent = 50 } }) },
	{ key = "-", mods = "LEADER", action = act.SplitPane({ direction = "Down", size = { Percent = 25 } }) },
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	-- Fix neovim+lazygit issue with SHIFT+Space combination
	{ key = "Space", mods = "SHIFT", action = wezterm.action({ SendString = " " }) },
}
config.key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 4 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 4 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 4 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 4 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}
-- theme
config.color_scheme = "tokyonight_night"
-- and finally, return the configuration to wezterm
return config
