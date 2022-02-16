local status, neogit = pcall(require, "neogit")
if not status then return end

neogit.setup {
  integrations = {
    diffview = true
  },
  signs = {
    -- { CLOSED, OPENED }
    section = { "⏵", "⏷" },
    item = { "⏵", "⏷" },
    hunk = { "", "" },
  },
}
