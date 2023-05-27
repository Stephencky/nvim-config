local setup, dashboard = pcall(require, "dashboard")
if not setup then
  print("Failed to setup dashboard")
  return
end

dashboard.setup({})
