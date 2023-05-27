local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true
opt.number = true


-- tab & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping 
opt.wrap = false

-- search 
opt.ignorecase = true
opt.smartcase = true


-- cursor line 
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace 
opt.backspace = "indent,eol,start"

--clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")


opt.title = false

vim.g.blamer_enabled = 1
vim.g.blamer_delay = 500
vim.g.template = '<committer>, <commit-short> <committer-time> • <summary'
