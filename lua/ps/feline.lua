local status, feline = pcall(require, "feline")
if not status then return end

feline.setup {
  theme = "catppuccin"
}