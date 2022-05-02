pcall(require, "impatient") -- Speed up loading Lua modules in Neovim to improve startup time

require "ps.options"
require "ps.autocommands"
require "ps.plugins"
require "ps.keymaps"
-- require "ps.which-key"
require "ps.colorscheme"
require "ps.telescope"
require "ps.lsp"
require "ps.cmp"

require'colorizer'.setup()
