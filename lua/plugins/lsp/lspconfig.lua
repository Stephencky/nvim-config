local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

local typescript_setup, typescript = pcall(require, "typescript")
if not typescript then
  return
end


local keymap = vim.keymap

-- enable key
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- set keybinds
  keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
  keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
  keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_dianostics<CR>", opts)
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_dianostics<CR>", opts)
  keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
  keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
  keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)

  -- if client.name == "tsserver" then
  --  keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>")
  -- end

end

-- used to enable autocompletion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig["clangd"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})


lspconfig["cmake"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["pylsp"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["lua_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      -- make the language server reconize "vim"
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})
