--local coq_status, coq = pcall(require, "coq")
--if not coq_status then
--  return
--end

vim.g.coq_settings = {
	auto_start = "shut-up",
	xdg = true,
}
