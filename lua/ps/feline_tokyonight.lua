local status, feline = pcall(require, "feline")
if not status then return end

local lsp = require("feline.providers.lsp")
local lsp_severity = vim.diagnostic.severity
local colors = require("tokyonight.colors").setup({ style = "night" })
local utils = require("tokyonight.util")

local sett = {
	bkg = colors.bg_dark,
	extras = colors.fg_dark,
	curr_file = colors.orange,
}

local mode_colors = {
	["n"] = { "NORMAL", colors.blue },
	["no"] = { "N-PENDING", colors.blue },
	["i"] = { "INSERT", colors.green },
	["ic"] = { "INSERT", colors.green },
	["t"] = { "TERMINAL", colors.green },
	["v"] = { "VISUAL", colors.magenta },
	["V"] = { "V-LINE", colors.magenta },
	[""] = { "V-BLOCK", colors.magenta },
	["R"] = { "REPLACE", colors.red },
	["Rv"] = { "V-REPLACE", colors.red },
	["s"] = { "SELECT", colors.red },
	["S"] = { "S-LINE", colors.red },
	[""] = { "S-BLOCK", colors.red },
	["c"] = { "COMMAND", colors.purple },
	["cv"] = { "COMMAND", colors.purple },
	["ce"] = { "COMMAND", colors.purple },
	["r"] = { "PROMPT", colors.teal },
	["rm"] = { "MORE", colors.teal },
	["r?"] = { "CONFIRM", colors.green1 },
	["!"] = { "SHELL", colors.green },
}


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

local inactive_invi_sep = {
  str = " ",
  hl = {
    fg = sett.bkg,
    bg = colors.bg
  },
}

-- #################### STATUSLINE ->

-- ######## Left

-- Vim icon
table.insert(components.active[1], {
  provider = "",
  hl = function()
    return {
      fg = mode_colors[vim.fn.mode()][2],
      bg = sett.bkg,
    }
  end,
  left_sep = invi_sep
})

-- Current vim mode
table.insert(components.active[1], {
  provider = function()
    return " " .. mode_colors[vim.fn.mode()][1] .. " "
  end,
  hl = function()
    return {
      fg = mode_colors[vim.fn.mode()][2],
      bg = sett.bkg,
    }
  end,
  right_sep = invi_sep
})

-- ######## Right

-- Diagnostics ------>

-- genral diagnostics (errors, warnings. info and hints)
table.insert(components.active[1], {
  provider = "diagnostic_errors",
  enabled = function()
    return lsp.diagnostics_exist(lsp_severity.ERROR)
  end,

  hl = {
    fg = colors.error,
    bg = sett.bkg,
  },
  icon = "  ",
})

table.insert(components.active[1], {
  provider = "diagnostic_warnings",
  enabled = function()
    return lsp.diagnostics_exist(lsp_severity.WARN)
  end,
  hl = {
    fg = colors.warning,
    bg = sett.bkg,
  },
  icon = "  ",
})

table.insert(components.active[1], {
  provider = "diagnostic_info",
  enabled = function()
    return lsp.diagnostics_exist(lsp_severity.INFO)
  end,
  hl = {
    fg = colors.info,
    bg = sett.bkg,
  },
  icon = "  ",
})

table.insert(components.active[1], {
  provider = "diagnostic_hints",
  enabled = function()
    return lsp.diagnostics_exist(lsp_severity.HINT)
  end,
  hl = {
    fg = colors.hint,
    bg = sett.bkg,
  },
  icon = "  ",
})
-- Diagnostics ------>

-- Diffs ------>
table.insert(components.active[2], {
  provider = "git_diff_added",
  hl = {
    fg = colors.git.add,
    bg = sett.bkg,
  },
  icon = "  ",
})

table.insert(components.active[2], {
  provider = "git_diff_changed",
  hl = {
    fg = colors.git.change,
    bg = sett.bkg,
  },
  icon = "  ",
})

table.insert(components.active[2], {
  provider = "git_diff_removed",
  hl = {
    fg = colors.git.delete,
    bg = sett.bkg,
  },
  icon = "  ",
})

-- Current git branch
table.insert(components.active[2], {
  provider = "git_branch",
  enabled = function()
    return vim.api.nvim_win_get_width(0) > 70
  end,
  hl = {
    fg = colors.purple,
    bg = sett.bkg
  },
  icon = "  ",
  left_sep = invi_sep,
  right_sep = invi_sep,
})

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


-- Initialize the components table
local winbar_components = {
  active = {},
  inactive = {},
}

table.insert(winbar_components.active, {}) -- (1) left
table.insert(winbar_components.active, {}) -- (2) right
table.insert(winbar_components.inactive, {}) -- (1) left
table.insert(winbar_components.inactive, {}) -- (2) right

table.insert(winbar_components.active[1], {
  provider = {
    name = 'file_info',
    opts = {
      type = 'relative-short',
    }
  },
  hl = {
    fg = sett.curr_file,
    bg = sett.bkg,
  },
  left_sep = invi_sep,
  right_sep = invi_sep
})

-- table.insert(winbar_components.active[1], {
--   provider = function()
--     local location = gps.get_location()
--     if location ~= "" then
--       return "» " .. gps.get_location()
--     else
--       return ""
--     end
--   end,
--   enabled = function()
--     return gps.is_available()
--   end,
--   hl = {
--     fg = clrs.subtext0,
--     bg = sett.bkg,
--   },
-- })

table.insert(winbar_components.active[2], {
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
})

table.insert(winbar_components.inactive[1], {
  provider = {
    name = 'file_info',
    opts = {
      type = 'unique',
    }
  },
  hl = {
    fg = sett.curr_file,
    bg = colors.bg_highlight
  },
  left_sep = inactive_invi_sep,
  right_sep = inactive_invi_sep
})

-- table.insert(winbar_components.inactive[1], {
--   provider = function()
--     local location = gps.get_location()
--     if location ~= "" then
--       return "» " .. gps.get_location()
--     else
--       return ""
--     end
--   end,
--   enabled = function()
--     return gps.is_available()
--   end,
--   hl = {
--     fg = clrs.subtext0,
--     bg = clrs.base
--   },
-- })

table.insert(winbar_components.inactive[2], {
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
    bg = colors.bg_highlight
  },
})

require('feline').winbar.setup({
  components = winbar_components
})
