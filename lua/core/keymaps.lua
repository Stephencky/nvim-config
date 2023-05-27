vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>")
-- keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>a", "ggVG")

keymap.set("n", "<leader>sv", "<C-w>v", {desc="split windows vertically"})
keymap.set("n", "<leader>sh", "<C-w>s", {desc="split window horizontally"})
keymap.set("n", "<leader>se", "<C-w>=", {desc="make split winodws equal"})
keymap.set("n", "<leader>sx", ":close<CR>", {desc="close current split winodw"})

keymap.set("n", "<leader>to", ":tabnew<CR>", {desc="open new tab"})
keymap.set("n", "<leader>tx", ":tabclose<CR>", {desc="close current tab"})
keymap.set("n", "<leader>tn", ":tabn<CR>", {desc="go to next tab"})
keymap.set("n", "<leader>tp", ":tabp<CR>", {desc="go to previous tab"})

-- 方向键替代
keymap.set("i", "<C-l>", "<right>")
keymap.set("i", "<C-h>", "<left>")
keymap.set("i", "<C-j>", "<down>")
keymap.set("i", "<C-k>", "<up>")

-- quick quit
keymap.set("n", "<leader>q", ":q!<CR>")
keymap.set("n", "<leader>w", ":wq!<CR>")
keymap.set("n", "<leader>zz", ":qa!<CR>")

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
keymap.set("n", "<c-p>", ":Telescope git_files<cr>")
keymap.set("n", "<leader><space>", ":Telescope<cr>")
keymap.set("n", "<leader>ff", ":Telescope find_files<cr>")
keymap.set("n", "<leader>fg", require("telescope").extensions.live_grep_args.live_grep_args, { noremap = true })
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
keymap.set("n", "<leader>fw", live_grep_args_shortcuts.grep_word_under_cursor)
keymap.set("n", "<leader>fb",
  function()
    require("telescope.builtin").buffers(
        require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        }
    )
  end
)
keymap.set("n", "<leader>fh", ":Telescope help_tags<cr>")
keymap.set("n", "<leader>fs",
  function()
	  require('telescope.builtin').grep_string(
      require('telescope.themes').get_dropdown {
		    winblend = 10,
  		  previewer = false,
      }
   )
  end
)

keymap.set('n', '<leader>fw',
  function()
    local opt = {default_text=vim.fn.expand('<cword>'), sorting_strategy='ascending'}
	  require('telescope.builtin').current_buffer_fuzzy_find(opt)
  end, { desc = '[/] Fuzzily search in current buffer' })

-- bufferline 
keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>")
keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>")
keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>")
keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>")
keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>")
keymap.set("n", "<leader>x", "<cmd>BufferLinePickClose<cr>")
keymap.set("n", "<leader>p", "<cmd>BufferLinePick<cr>")
keymap.set("n", "<leader>h", "<cmd>BufferLineCyclePrev<cr>")
keymap.set("n", "<leader>l", "<cmd>BufferLineCycleNext<cr>")

-- hop 替代默认设置
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true})
end, {remap=true})
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true})
end, {remap=true})
vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, hint_offset = -1, current_line_only = true })
end, {remap=true})
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, hint_offset = 1, current_line_only = true })
end, {remap=true})


-- outline
keymap.set('n', "<leader>o", ":SymbolsOutline<cr>", {desc="Show code outline"})

-- run python
keymap.set("n", "<F12>", ":TermExec cmd='python %:p'<cr>")
