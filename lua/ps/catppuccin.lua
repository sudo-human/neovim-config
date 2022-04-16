local status, catppuccin = pcall(require, "catppuccin")
if not status then return end

catppuccin.setup {
  term_colors = true,
  integration = {
    nvimtree = {
      enabled = true,
      show_root = true,
      transparent_panel = true,
    },
    which_key = true
  }
}
