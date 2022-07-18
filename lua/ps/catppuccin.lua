local status, catppuccin = pcall(require, "catppuccin")
if not status then return end

local cp = require("catppuccin.palettes").get_palette()

catppuccin.setup {
  dim_inactive = {
    enabled = true,
    shade = "dark",
    percentage = 0.15,
  },
  transparent_background = false,
  term_colors = true,
  compile = {
    enabled = true,
    path = vim.fn.stdpath "cache" .. "/catppuccin",
    suffix = "_compiled"
  },
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
      },
    },
    coc_nvim = false,
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
      show_root = true,
      transparent_panel = false,
    },
    dap = {
      enabled = true,
      enable_ui = true,
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
    mini = false,
  },
  custom_highlights = {
    DiagnosticError = { bg = "NONE", fg = cp.red },
    DiagnosticWarn = { bg = "NONE", fg = cp.yellow },
    DiagnosticInfo = { bg = "NONE", fg = cp.sky },
    DiagnosticHint = { bg = "NONE", fg = cp.teal },
    GitSignsAdd = { bg="NONE", fg = cp.green },
    GitSignsChange = { bg="NONE", fg = cp.yellow },
    GitSignsDelete = { bg="NONE", fg = cp.red },
		TSParameter = { fg = cp.text, style = {} }, -- For parameters of a function.
  }
}

vim.g.catppuccin_flavour = "mocha"

-- local util = require("catppuccin.utils.util")
-- local error = cp.red
-- local warning = cp.yellow
-- local info = cp.sky
-- local hint = cp.teal
-- local darkening_percentage = 0.095
-- catppuccin.remap({
--   DiagnosticVirtualTextError = { bg = util.darken(error, darkening_percentage, cp.base), fg = error, style = "undercurl" },
--   DiagnosticVirtualTextWarn = { bg = util.darken(warning, darkening_percentage, cp.base), fg = warning, style = "undercurl" },
--   DiagnosticVirtualTextInfo = { bg = util.darken(info, darkening_percentage, cp.base), fg = info, style = "undercurl" },
--   DiagnosticVirtualTextHint = { bg = util.darken(hint, darkening_percentage, cp.base), fg = hint, style = "undercurl" },
--
--   DiagnosticError = { bg = "NONE", fg = error, style = "italic" },
--   DiagnosticWarn = { bg = "NONE", fg = warning, style = "italic" },
--   DiagnosticInfo = { bg = "NONE", fg = info, style = "italic" },
--   DiagnosticHint = { bg = "NONE", fg = hint, style = "italic" },
-- })

-- catppuccin.load()
