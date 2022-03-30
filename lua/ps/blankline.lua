local status, blankline = pcall(require, "indent_blankline")
if not status then return end

blankline.setup {
  -- show_current_context = false,
  -- show_current_context_start = false,
  -- indent_blankline_buftype_exclude = { "terminal", "nofile" },
  -- indent_blankline_filetype_exclude = {
  --   "help",
  --   "startify",
  --   "dashboard",
  --   "packer",
  --   "neogitstatus",
  --   "NvimTree",
  --   "Trouble",
  -- },
  -- indent_blankline_use_treesitter = true,
  -- indent_blankline_show_trailing_blankline_indent = false,
  -- indent_blankline_show_current_context = true,
}
