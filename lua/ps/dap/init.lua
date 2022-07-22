require("ps.dap.virtual_text")
require("ps.dap.ui")

local signs = {
	{ name = "DapBreakpoint", text = "" },
	{ name = "DapBreakpointCondition", text = "" },
	{ name = "DapLogPoint", text = "" },
	{ name = "DapStopped", text = "⮞" },
	{ name = "DapBreakpointRejected", text = "" },
}

-- TODO: Make it colorscheme based
vim.cmd("hi dap ctermfg=red guifg=red")

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = "Dap", text = sign.text, numhl = "" })
end

-- Language specific configurations
require("ps.dap.python")
