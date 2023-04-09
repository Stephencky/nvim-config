vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>")
-- keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "x", '"_x')

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

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
keymap.set("n", "<c-p>", ":Telescope git_files<cr>")
keymap.set("n", "<leader>ff", ":Telescope find_files<cr>")
keymap.set("n", "<leader>fs", ":Telescope live_grep<cr>")
keymap.set("n", "<leader>fg", require("telescope").extensions.live_grep_args.live_grep_args, { noremap = true })
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
keymap.set("n", "<leader>fw", live_grep_args_shortcuts.grep_word_under_cursor)
keymap.set("n", "<leader>fc", ":Telescope grep_string<cr>")
keymap.set("n", "<leader>fb", ":Telescope buffers<cr>")
keymap.set("n", "<leader>fh", ":Telescope help_tags<cr>")
keymap.set("n", "<leader><Space>", ":Telescope<cr>")

-- bufferline 
keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>")
keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>")
keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>")
keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>")
keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>")
keymap.set("n", "<leader>x", "<cmd>BufferLinePickClose<cr>")
keymap.set("n", "<leader>h", "<cmd>BufferLineCyclePrev<cr>")
keymap.set("n", "<leader>l", "<cmd>BufferLineCycleNext<cr>")
