local status, catppuccin = pcall(require, "catppuccin")
if not status then return end

catppuccin.setup {
  transparent_background = false,
  term_colors = true,
  styles = {
    comments = "italic",
    conditionals = "italic",
    loops = "NONE",
    functions = "NONE",
    keywords = "NONE",
    strings = "NONE",
    variables = "NONE",
    numbers = "NONE",
    booleans = "NONE",
    properties = "NONE",
    types = "NONE",
    operators = "NONE",
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = "italic",
        hints = "italic",
        warnings = "italic",
        information = "italic",
      },
      underlines = {
        errors = "undercurl",
        hints = "undercurl",
        warnings = "undercurl",
        information = "undercurl",
      },
    },
    lsp_trouble = false,
    cmp = true,
    lsp_saga = false,
    gitgutter = false,
    gitsigns = true,
    telescope = true,
    nvimtree = {
      enabled = true,
      show_root = true,
      transparent_panel = false,
    },
    neotree = {
      enabled = false,
      show_root = false,
      transparent_panel = false,
    },
    which_key = false,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    dashboard = true,
    neogit = true,
    vim_sneak = false,
    fern = false,
    barbar = false,
    bufferline = true,
    markdown = true,
    lightspeed = false,
    ts_rainbow = false,
    hop = false,
    notify = true,
    telekasten = true,
    symbols_outline = true,
  }}

vim.g.catppuccin_flavour = "mocha"

local cp = require'catppuccin.api.colors'.get_colors()
local util = require("catppuccin.utils.util")
local error = cp.red
local warning = cp.yellow
local info = cp.sky
local hint = cp.teal
local darkening_percentage = 0.095
catppuccin.remap({
  DiagnosticVirtualTextError = { bg = util.darken(error, darkening_percentage, cp.base), fg = error, style = "undercurl" },
  DiagnosticVirtualTextWarn = { bg = util.darken(warning, darkening_percentage, cp.base), fg = warning, style = "undercurl" },
  DiagnosticVirtualTextInfo = { bg = util.darken(info, darkening_percentage, cp.base), fg = info, style = "undercurl" },
  DiagnosticVirtualTextHint = { bg = util.darken(hint, darkening_percentage, cp.base), fg = hint, style = "undercurl" },

  DiagnosticError = { bg = "NONE", fg = error, style = "italic" },
  DiagnosticWarn = { bg = "NONE", fg = warning, style = "italic" },
  DiagnosticInfo = { bg = "NONE", fg = info, style = "italic" },
  DiagnosticHint = { bg = "NONE", fg = hint, style = "italic" },
})

catppuccin.load()
