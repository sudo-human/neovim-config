local status, notify = pcall(require, "notify")
if not status then return end

notify.setup({
  -- Animation style (see below for details)
  stages = "fade_in_slide_out",

  -- Function called when a new window is opened, use for changing win settings/config
  on_open = nil,

  -- Function called when a window is closed
  on_close = nil,

  -- Render function for notifications. See notify-render()
  render = "default",

  -- Default timeout for notifications
  timeout = 3000,

  -- Max number of columns for messages
  max_width = function ()
    local curr_win_width = vim.api.nvim_win_get_width(0)
    local width = math.floor(0.3 * curr_win_width)
    return width
  end,
  -- Max number of lines for a message
  max_height = 5,

  -- For stages that change opacity this is treated as the highlight behind the window
  -- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
  background_colour = "Normal",

  -- Minimum width for notification windows
  minimum_width = 50,

  -- Icons for the different levels
  icons = {
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "✎",
  },
})

vim.notify = notify
