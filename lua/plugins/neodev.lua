local status, neodev = pcall(require, "neodev")
if not status then
  print("Failed to load neodev")
  return
end
neodev.setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})


