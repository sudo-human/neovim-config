local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
-- keymap("n", "<S-l>", "<Plug>(cokeline-focus-next)",  { silent = true })
-- keymap("n", "<S-h>", "<Plug>(cokeline-focus-prev)",  { silent = true })


-- keymap("n", "<S-l>", ":bprevious<CR>", opts)
-- keymap("n", "<S-h>", ":bnext<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)

-- Ohhh lala re Ohh lala re
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "Y", "y$", opts)
-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- keymap("n", "<C-e>", "<cmd>NvimTreeToggle<cr>", opts)
-- keymap("i", "<C-e>", "<cmd>NvimTreeToggle<cr><esc>", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Debug mappings
if pcall(require, "dap") then
  keymap({"n", "i"}, "<F5>", require"dap".continue, { silent = true, noremap = true })
  keymap({"n", "i"}, "<F6>", require"dap".run_last, { silent = true, noremap = true })
  keymap({"n", "i"}, "<F7>", require"dapui".close, { silent = true, noremap = true })
  keymap({"n", "i"}, "<F8>", require"dap".terminate, { silent = true, noremap = true })
  keymap({"n", "i"}, "<F1>", require"dap".step_over, { silent = true, noremap = true })
  keymap({"n", "i"}, "<F2>", require"dap".step_into, { silent = true, noremap = true })
  keymap({"n", "i"}, "<F3>", require"dap".step_out, { silent = true, noremap = true })
  keymap({"n"}, "<leader>db", require"dap".toggle_breakpoint, opts)
  keymap({"n"}, "<leader>dB", function () require"dap".set_breakpoint(vim.fn.input("Breakpint condition: ")) end, opts)
  keymap({"n"}, "<leader>dl", function () require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, opts)
  keymap({"n"}, "<leader>dC", require"dap".clear_breakpoints, opts)
end


local status, telescope = pcall(require, "telescope")
if status then
  local tb = require("telescope.builtin")
  -- File
  keymap({"n"}, "<leader>ff", tb.find_files, opts)
  keymap({"n"}, "<leader>fg", tb.git_files, opts)
  keymap({"n"}, "<leader>fs", ":w!<CR>", opts)
  keymap({"n"}, "<leader>fb", function() telescope.extensions.file_browser.file_browser({path = "%:p:h"}) end, opts)

  -- Buffers
  keymap({"n"}, "<leader>bb", tb.buffers, opts)
  keymap({"n"}, "<leader>bd", "<cmd>bdelete!<CR>", opts)

  -- Help
  keymap({"n"}, "<leader>hh", tb.help_tags, opts)
  keymap({"n"}, "<leader>hm", tb.man_pages, opts)

  -- Search
  keymap({"n"}, "<leader>sf", tb.live_grep, opts)
  keymap({"n"}, "<leader>sb", tb.current_buffer_fuzzy_find, opts)
  keymap({"n"}, "<leader>sC", tb.colorscheme, opts)
  keymap({"n"}, "<leader>sr", tb.registers, opts)
  keymap({"n"}, "<leader>sk", tb.keymaps, opts)
  keymap({"n"}, "<leader>sc", tb.commands, opts)

  -- LSP
  -- keymap({"n"}, "<leader>la", "<cmd>Telescope lsp_code_actions<CR>", opts)
  keymap({"n"}, "<leader>ld", tb.diagnostics, opts)
  keymap({"n"}, "<leader>ls", tb.lsp_document_symbols, opts)
  keymap({"n"}, "<leader>ldS", tb.lsp_dynamic_workspace_symbols, opts)
  keymap({"n"}, "<leader>lS", tb.lsp_workspace_symbols, opts)
  keymap({"n"}, "<leader>lr", tb.lsp_references, opts)

  keymap({"n"}, "<leader>R", tb.resume, opts)
end

if pcall(require, "neogit") then
  keymap({"n"}, "<leader>gg", require("neogit").open, opts)
end

if pcall(require, "harpoon") then
  keymap({"n"}, "<C-n>", require('harpoon.ui').nav_next, opts)
  keymap({"n"}, "<C-p>", require('harpoon.ui').nav_prev, opts)
  keymap({"n"}, "<leader>'", require('harpoon.ui').toggle_quick_menu, opts)
  keymap({"n"}, "<leader>m", require('harpoon.mark').add_file, opts)
  keymap({"n"}, "<leader>1", function() require("harpoon.ui").nav_file(1) end, opts)
  keymap({"n"}, "<leader>2", function() require("harpoon.ui").nav_file(2) end, opts)
  keymap({"n"}, "<leader>3", function() require("harpoon.ui").nav_file(3) end, opts)
  keymap({"n"}, "<leader>4", function() require("harpoon.ui").nav_file(4) end, opts)
end

local gs_status, gs = pcall(require, "gitsigns")
if gs_status then
  keymap({"n"}, "<leader>gl", function () gs.blame_line({ full = true }) end, opts)
  keymap({"n"}, "<leader>gp", gs.preview_hunk, opts)
  keymap({"n"}, "<leader>gr", gs.reset_hunk, opts)
  keymap({"n"}, "<leader>gR", gs.reset_buffer, opts)
  keymap({"n"}, "<leader>gs", gs.stage_hunk, opts)
  keymap({"n"}, "<leader>gd", "<cmd>Gitsigns diffthis HEAD<CR>", opts)
end

keymap({"n"}, "<leader>ot", "<cmd>TeoggleTerm direction=float<cr>", opts)
keymap({"n"}, "<leader>ov", "<cmd>TeoggleTerm direction=vertical<cr>", opts)
keymap({"n"}, "<leader>oh", "<cmd>TeoggleTerm direction=horizontal<cr>", opts)
keymap({"n"}, "<leader>oq", "<cmd>copen<cr>", opts)
keymap({"n"}, "<leader>oe", "<cmd>NvimTreeToggle<cr>", opts)
