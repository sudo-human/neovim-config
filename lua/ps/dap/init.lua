-- local fs = require("filesystem")
--
-- for file in fs.list("./adapters") do
--   if fs.isDirectory(file) then
--     _ = pcall(require, "lua.ps.dap.adapters." .. file)
--   end
-- end
--
-- for file in fs.list("./configs") do
--   if fs.isDirectory(file) then
--     _ = pcall(require, "lua.ps.dap.config." .. file)
--   end
-- end

require("ps.dap.lldb")
require("ps.dap.cpp")
