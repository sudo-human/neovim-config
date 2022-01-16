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
  -- Files
  f = {
    name = "File";
    f = { "<cmd>Telescope fd<cr>", "Find Files" },
    b = { "<cmd>Telescope buffers<cr>", "Open Buffers" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
    g = { "<cmd>Telescope git_files<cr>", "Open git tracked files" },
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
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
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

-- Command Search
wk.register({
  ["<c-r><c-r>"] = { "<Plug>(TelescopeFuzzyCommandSearch)" }
  }, {
    mode = "c",
    noremap = false,
    nowait = true,
  })
