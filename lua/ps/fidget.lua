local status, fidget = pcall(require, "fidget")
if not status then return end


fidget.setup {
  text = {
    spinner = "square_corners"
  }
}
