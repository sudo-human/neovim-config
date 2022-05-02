local status, feline = pcall(require, "feline")
if not status then return end

-- local catppuccin, cat_colors = pcall(require,"catppuccin.api.colors")
-- if not catppuccin then
--   feline.setup()
--   return
-- end

local lsp = require("feline.providers.lsp")
local lsp_severity = vim.diagnostic.severity
-- local b = vim.b
local gps = require("nvim-gps")
-- local clrs = cat_colors.get_colors()

local clrs = {
  dark0_hard = "#1d2021",
  dark0 = "#282828",
  dark0_soft = "#32302f",
  dark1 = "#3c3836",
  dark2 = "#504945",
  dark3 = "#665c54",
  dark4 = "#7c6f64",
  light0_hard = "#f9f5d7",
  light0 = "#fbf1c7",
  light0_soft = "#f2e5bc",
  light1 = "#ebdbb2",
  light2 = "#d5c4a1",
  light3 = "#bdae93",
  light4 = "#a89984",
  bright_red = "#fb4934",
  bright_green = "#b8bb26",
  bright_yellow = "#fabd2f",
  bright_blue = "#83a598",
  bright_purple = "#d3869b",
  bright_aqua = "#8ec07c",
  bright_orange = "#fe8019",
  neutral_red = "#cc241d",
  neutral_green = "#98971a",
  neutral_yellow = "#d79921",
  neutral_blue = "#458588",
  neutral_purple = "#b16286",
  neutral_aqua = "#689d6a",
  neutral_orange = "#d65d0e",
  faded_red = "#9d0006",
  faded_green = "#79740e",
  faded_yellow = "#b57614",
  faded_blue = "#076678",
  faded_purple = "#8f3f71",
  faded_aqua = "#427b58",
  faded_orange = "#af3a03",
  gray = "#928374",
}

-- settings
local sett = {
	bkg = clrs.dark1,
	diffs = clrs.bright_purple,
	extras = clrs.gray,
	curr_file = clrs.bright_blue,
	curr_dir = clrs.faded_aqua,
}

local mode_colors = {
	["n"] = { "NORMAL", clrs.bright_blue },
	["no"] = { "N-PENDING", clrs.bright_blue },
	["i"] = { "INSERT", clrs.neutral_green },
	["ic"] = { "INSERT", clrs.neutral_green },
	["t"] = { "TERMINAL", clrs.neutral_green },
	["v"] = { "VISUAL", clrs.neutral_purple },
	["V"] = { "V-LINE", clrs.neutral_purple },
	[""] = { "V-BLOCK", clrs.neutral_purple },
	["R"] = { "REPLACE", clrs.faded_purple },
	["Rv"] = { "V-REPLACE", clrs.faded_purple },
	["s"] = { "SELECT", clrs.faded_purple },
	["S"] = { "S-LINE", clrs.faded_purple },
	[""] = { "S-BLOCK", clrs.faded_purple },
	["c"] = { "COMMAND", clrs.neutral_orange },
	["cv"] = { "COMMAND", clrs.neutral_orange },
	["ce"] = { "COMMAND", clrs.neutral_orange },
	["r"] = { "PROMPT", clrs.faded_aqua },
	["rm"] = { "MORE", clrs.faded_aqua },
	["r?"] = { "CONFIRM", clrs.neutral_aqua },
	["!"] = { "SHELL", clrs.neutral_green },
}

local shortline = false

-- Initialize the components table
local components = {
	active = {},
	inactive = {},
}

table.insert(components.active, {}) -- (1) left
table.insert(components.active, {}) -- (3) right

-- global components
local invi_sep = {
	str = " ",
	hl = {
		fg = sett.bkg,
		bg = sett.bkg
	},
}

-- #################### STATUSLINE ->

-- ######## Left

-- Vim icon
components.active[1][1] = {
  provider = "",
  hl = function()
    return {
      fg = mode_colors[vim.fn.mode()][2],
      bg = sett.bkg,
    }
  end,
  left_sep = invi_sep
}

-- Current vim mode
components.active[1][2] = {
  provider = function()
    return " " .. mode_colors[vim.fn.mode()][1] .. " "
  end,
  -- hl = {
  --   fg = sett.extras,
  --   bg = sett.bkg,
  -- },
  hl = function()
    return {
      fg = mode_colors[vim.fn.mode()][2],
      bg = sett.bkg,
    }
  end,
  right_sep = invi_sep
}

-- nvim-gps component
components.active[1][3] = {
	provider = function()
		return gps.get_location()
	end,
	enabled = function()
		return gps.is_available()
	end,
	hl = {
		fg = clrs.gray,
		bg = sett.bkg,
	},
}

-- ######## Right

-- Diagnostics ------>

-- genral diagnostics (errors, warnings. info and hints)
components.active[2][1] = {
	provider = "diagnostic_errors",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.ERROR)
	end,

	hl = {
		fg = clrs.bright_red,
		bg = sett.bkg,
	},
	icon = "  ",
}

components.active[2][2] = {
	provider = "diagnostic_warnings",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.WARN)
	end,
	hl = {
		fg = clrs.bright_yellow,
		bg = sett.bkg,
	},
	icon = "  ",
}

components.active[2][3] = {
	provider = "diagnostic_info",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.INFO)
	end,
	hl = {
		fg = clrs.bright_blue,
		bg = sett.bkg,
	},
	icon = "  ",
}

components.active[2][4] = {
	provider = "diagnostic_hints",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.HINT)
	end,
	hl = {
		fg = clrs.light0_soft,
		bg = sett.bkg,
	},
	icon = "  ",
}
-- Diagnostics ------>

-- Diffs ------>
components.active[2][5] = {
	provider = "git_diff_added",
	hl = {
		fg = clrs.neutral_aqua,
		bg = sett.bkg,
	},
	icon = "  ",
}

components.active[2][6] = {
	provider = "git_diff_changed",
	hl = {
		fg = clrs.bright_orange,
		bg = sett.bkg,
	},
	icon = "  ",
}

components.active[2][7] = {
	provider = "git_diff_removed",
	hl = {
		fg = clrs.neutral_red,
		bg = sett.bkg,
	},
	icon = "  ",
}

-- Current git branch
components.active[2][8] = {
	provider = "git_branch",
	enabled = shortline or function()
		return vim.api.nvim_win_get_width(0) > 70
	end,
	hl = {
		fg = sett.extras,
		bg = sett.bkg
	},
	icon = "  ",
	left_sep = invi_sep,
  right_sep = invi_sep,
}

-- File percentage
components.active[2][9] = {
  provider = function()
		local current_line = vim.fn.line(".")
		local total_line = vim.fn.line("$")

		if current_line == 1 then
			return " Top "
		elseif current_line == vim.fn.line("$") then
			return " Bot "
		end
		local result, _ = math.modf((current_line / total_line) * 100)
		return " " .. result .. "%% "
	end,
	hl = {
		fg = sett.extras,
		bg = sett.bkg
	},
	left_sep = invi_sep,
}

-- Current file
components.active[2][10] = {
  provider = {
    name = 'file_info',
    opts = {
      type = 'unique',
    }
  },
	hl = {
		fg = sett.curr_file,
		bg = sett.bkg,
	},
  left_sep = invi_sep,
  right_sep = invi_sep
}


-- ######## Right

feline.setup({
	components = components,
  force_inactive = {
    filetypes = {
      '^NvimTree$',
      '^packer$',
      '^startify$',
      '^fugitive$',
      '^fugitiveblame$',
      '^qf$',
      '^help$',
      '^aerial$',
    },
    buftypes = {
      -- '^terminal$',
      '^netrw$'
    },
    bufnames = {}
  }
})
