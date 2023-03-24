local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
  print("Failed to load nvim cmp")
  return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
  print("Failed to load luasnip")
  return
end

-- import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
  return
end

-- load friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(), -- 显示代码提示
    ["<C-e>"] = cmp.mapping.abort(), -- 关闭代码提示 
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- snippets
    { name = "luasnip" }, -- snippets
    { name = "buffer" }, -- text within current buffer
    { name = "path" }, -- file system paths
  }),
  -- configure lspkind for vs-code like icons
  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 50,
      ellipsis_char = "...",
    }),
  },
})

