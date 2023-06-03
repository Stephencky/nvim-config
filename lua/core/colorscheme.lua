-- vim.cmd[[colorscheme nightfly]]
-- local status, _ = pcall(vim.cmd, "colorscheme nightfly")
-- if not status then
--   print("Color scheme not found")
--   return
-- end

-- vim.cmd[[colorscheme darkplus]]
-- local status, _ = pcall(vim.cmd, "colorscheme darkplus")
-- if not status then
--   print("Color scheme not found")
--   return
-- end

vim.cmd[[colorscheme gruvbox]]
local status, _ = pcall(vim.cmd, "colorscheme gruvbox")
if not status then
  print("Color scheme not found")
  return
end
