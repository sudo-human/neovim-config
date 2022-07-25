local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
	on_attach = require("ps.lsp.handlers").on_attach,
	capabilities = require("ps.lsp.handlers").capabilities,
})

lspconfig.sumneko_lua.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

lspconfig.pyright.setup({})
lspconfig.tsserver.setup({})
lspconfig.clangd.setup({})
lspconfig.jsonls.setup({})
lspconfig.rust_analyzer.setup({})
