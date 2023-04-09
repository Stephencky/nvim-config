local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  print("Failed to load nvim tree")
  return
end

-- 推荐的nvim-tree设置
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd[[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]]

local function open_nvim_tree(data)
  -- buffer is a [No Name]
  -- local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  if directory then
    vim.cmd.cd(data.file)
  end

  -- open the tree
  require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

nvimtree.setup({
  renderer = {
    icons = {
      glyphs = {
        folder = {
          arrow_closed = "➜",
          arrow_open = "↓",
        },
      },
    },
  },
  view = {
    width = 35
  },
  filters = {
    dotfiles = true,
  },
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true
  },
})
