local wk_status, wk = pcall(require, "which-key")
if not wk_status then return end

local nopts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["P"] = { "<cmd>Telescope projects<cr>", "Open Project" },
  ["p"] = { "<Plug>(cokeline-switch-prev)", "Switch buffer previous" },
  ["n"] = { "<Plug>(cokeline-switch-next)", "Switch buffer next" },

  -- Files
  f = {
    name = "File";
    -- f = { "<cmd>Telescope fd<cr>", "Find Files" },
    f = { "<cmd>lua require'telescope.builtin'.find_files({ file_ignore_patterns = {'^node_modules/', '^.git/', '^.cache', '%.o', '%.a', '%.out', '%.class', '%.pdf', '%.mkv', '%.mp4', '%.zip'}})<cr>", "Find Files" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
    g = { "<cmd>Telescope git_files<cr>", "Open git tracked files" },
    s = { "<cmd>w!<cr>", "Save file" },
  },

  -- Buffers
  b = {
    name = "Buffers";
    b = { "<cmd>Telescope buffers<cr>", "Open Buffers" },
    d = { "<cmd>bdelete!<cr>", "Close Buffer" },
  },

  -- Help
  h = {
    name = "Help";
    h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
  },

  -- Search
  s = {
    name = "Search";
    f = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
    b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Find in buffer" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },

  -- Vim
  v = {
    name = "Vim";
    a = { "<cmd>Telescope autocommands<cr>", "List autocommands" },
  },

  -- Git
  g = {
    name = "Git";
    g = { "<cmd>lua require 'neogit'.open()<cr>", "Neogit" },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line{ full = true }<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },

  -- LSP
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      "<cmd>Telescope diagnostics<cr>",
      "Workspace Diagnostics",
    },
    -- w = {
    --   "<cmd>Telescope lsp_workspace_diagnostics<cr>",
    --   "Workspace Diagnostics",
    -- },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
    R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    r = { "<cmd>Telescope lsp_references<cr>", "References", },
  },

  -- Open windows or toggles
  o = {
    name = "Open";
    t = { "<cmd>ToggleTerm direction=float<cr>", "Floating Terminal" },
    v = { "<cmd>ToggleTerm direction=vertical<cr>", "Vertical Terminal" },
    h = { "<cmd>ToggleTerm direction=horizontal<cr>", "Horizontal Terminal" },
    T = {
      name = "Terminal";
      n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
      h = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
      p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
      b = { "<cmd>lua _BTOP_TOGGLE()<cr>", "Btop" },
    },
  },
}

wk.register(mappings, nopts)

-- Visual Mode
local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

mappings = {
  g = {
    name = "Git";
    r = { ":lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    s = { ":lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
  },
}

wk.register(mappings, vopts)
