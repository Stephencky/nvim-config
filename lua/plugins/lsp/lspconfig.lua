local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  print("Failed to load lsp config")
  return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  print("Failed to load nvim lsp cmp")
  return
end

local overloads_setup, overloads = pcall(require, "lsp-overloads")
if not overloads_setup then
  print("Failed to load nvim overload")
end

local keymap = vim.keymap

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
  -- keybind options
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- set keybinds
  keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
  keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
  keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
  keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
  keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
  keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
  keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor

  -- 代码提示设置
  if client.server_capabilities.signatureHelpProvider then
    overloads.setup(client, {
        -- UI options are mostly the same as those passed to vim.lsp.util.open_floating_preview
        ui = {
          border = "single",           -- The border to use for the signature popup window. Accepts same border values as |nvim_open_win()|.
          height = nil,               -- Height of the signature popup window (nil allows dynamic sizing based on content of the help)
          width = nil,                -- Width of the signature popup window (nil allows dynamic sizing based on content of the help)
          wrap = true,                -- Wrap long lines
          wrap_at = nil,              -- Character to wrap at for computing height when wrap enabled
          max_width = nil,            -- Maximum signature popup width
          max_height = nil,           -- Maximum signature popup height
          -- Events that will close the signature popup window: use {"CursorMoved", "CursorMovedI", "InsertCharPre"} to hide the window when typing
          close_events = {"CursorMoved", "CursorMovedI", "InsertCharPre"},
          focusable = true,           -- Make the popup float focusable
          focus = false,              -- If focusable is also true, and this is set to true, navigating through overloads will focus into the popup window (probably not what you want)
          offset_x = 0,               -- Horizontal offset of the floating window relative to the cursor position
          offset_y = 0,                -- Vertical offset of the floating window relative to the cursor position
          floating_window_above_cur_line = false -- Attempt to float the popup above the cursor position 
                                                 -- (note, if the height of the float would be greater than the space left above the cursor, it will default 
                                                 -- to placing the float below the cursor. The max_height option allows for finer tuning of this)
        },
      })
  end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'cmake', 'clangd', 'pylsp' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

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
