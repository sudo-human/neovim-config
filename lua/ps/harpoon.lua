local status, harpoon = pcall(require, "harpoon")
if not status then
  return
end

harpoon.setup({
  menu = {
    width = math.floor(vim.api.nvim_win_get_width(0) * 0.4),
  },
})
