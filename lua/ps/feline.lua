local status, feline = pcall(require, "feline")
if not status then return end

local catppuccin, components = pcall(require,"catppuccin.core.integrations.feline")
if not catppuccin then
  feline.setup()
  return
end

feline.setup({
	components = components,
})
