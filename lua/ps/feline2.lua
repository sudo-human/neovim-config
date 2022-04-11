local status, feline = pcall(require, "feline")
if not status then return end

local catppuccin, cat_colors = pcall(require,"catppuccin.api.colors")
if not catppuccin then
  feline.setup()
  return
end

local lsp = require("feline.providers.lsp")
local lsp_severity = vim.diagnostic.severity
local b = vim.b
local gps = require("nvim-gps")
local clrs = cat_colors.get_colors()

-- settings
local sett = {
	bkg = clrs.black3,
	diffs = clrs.mauve,
	extras = clrs.gray1,
	curr_file = clrs.maroon,
	curr_dir = clrs.flamingo,
}

local mode_colors = {
	["n"] = { "NORMAL", clrs.lavender },
	["no"] = { "N-PENDING", clrs.lavender },
	["i"] = { "INSERT", clrs.green },
	["ic"] = { "INSERT", clrs.green },
	["t"] = { "TERMINAL", clrs.green },
	["v"] = { "VISUAL", clrs.flamingo },
	["V"] = { "V-LINE", clrs.flamingo },
	[""] = { "V-BLOCK", clrs.flamingo },
	["R"] = { "REPLACE", clrs.maroon },
	["Rv"] = { "V-REPLACE", clrs.maroon },
	["s"] = { "SELECT", clrs.maroon },
	["S"] = { "S-LINE", clrs.maroon },
	[""] = { "S-BLOCK", clrs.maroon },
	["c"] = { "COMMAND", clrs.peach },
	["cv"] = { "COMMAND", clrs.peach },
	["ce"] = { "COMMAND", clrs.peach },
	["r"] = { "PROMPT", clrs.teal },
	["rm"] = { "MORE", clrs.teal },
	["r?"] = { "CONFIRM", clrs.mauve },
	["!"] = { "SHELL", clrs.green },
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
  hl = {
    fg = sett.extras,
    bg = sett.bkg,
  },
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
		fg = clrs.rosewater,
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
		fg = clrs.red,
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
		fg = clrs.yellow,
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
		fg = clrs.sky,
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
		fg = clrs.rosewater,
		bg = sett.bkg,
	},
	icon = "  ",
}
-- Diagnostics ------>

-- Diffs ------>
components.active[2][5] = {
	provider = "git_diff_added",
	hl = {
		fg = clrs.green,
		bg = sett.bkg,
	},
	icon = "  ",
}

components.active[2][6] = {
	provider = "git_diff_changed",
	hl = {
		fg = clrs.yellow,
		bg = sett.bkg,
	},
	icon = "  ",
}

components.active[2][7] = {
	provider = "git_diff_removed",
	hl = {
		fg = clrs.red,
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

-- Current file
components.active[2][9] = {
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
  left_sep = invi_sep
}

-- File percentage
components.active[2][10] = {
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
