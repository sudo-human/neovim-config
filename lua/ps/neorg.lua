require("neorg").setup({
	load = {
		["core.defaults"] = {},
		-- ["core.neorg.concealer"] = {},
		["core.norg.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.integrations.nvim-cmp"] = {},
		["core.integrations.treesitter"] = {},
		["core.ui"] = {},
		["core.integrations.telescope"] = {},
	},
})
