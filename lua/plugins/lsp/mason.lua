local mason_status, mason = pcall(require, "mason")
if not mason_status then
  print("Failed to load mason")
  return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  print("Failed to load mason lsp config")
  return
end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    },
    opts = {
        ensure_installed = {
          "clangd",
          "clang-format",
          "codelldb",
      }
    }
})

mason_lspconfig.setup({
  ensure_installed = {
    "clangd",
    "lua_ls",
    "cmake",
    "pylsp",
  },
  automatic_installation = true,
})
