local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save this file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerInstall
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
  -- 外观
  use "wbthomason/packer.nvim"
  -- use { "bluz71/vim-nightfly-guicolors", as="nightfly"}
  use { "ellisonleao/gruvbox.nvim" }
  use "lunarvim/darkplus.nvim"

  -- 许多插件使用的lua函数
  use "nvim-lua/plenary.nvim"

  -- tmux && split相关插件
  use "christoomey/vim-tmux-navigator"
  use "szw/vim-maximizer"
  
  -- 基础插件
  use "tpope/vim-surround"
  use "vim-scripts/ReplaceWithRegister"

  -- comment with gc
  use "numToStr/Comment.nvim"

  -- 文件管理
  use "nvim-tree/nvim-tree.lua"

  -- icons
  use "kyazdani42/nvim-web-devicons"

  -- statusline
  use "nvim-lualine/lualine.nvim"

  -- telescope fuzzy finding
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use { "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = {{"nvim-telescope/telescope-live-grep-args.nvim"}}}
  use { "nvim-telescope/telescope-file-browser.nvim", dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" } }
  use {'nvim-telescope/telescope-ui-select.nvim' }
  use { "ahmedkhalf/project.nvim" }

  -- auto completion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  
  -- 显示函数提示
  use { 'Issafalcon/lsp-overloads.nvim'}
  -- snippets
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"
  use "rafamadriz/friendly-snippets"

  -- managing & installing lsp servers
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"

  -- configuring lsp serers
  use "neovim/nvim-lspconfig"
  use "hrsh7th/cmp-nvim-lsp"
  use { "glepnir/lspsaga.nvim", branch = 'main' }
  -- use "jose-elias-alvarez/typescript.nvim"
  use "onsails/lspkind.nvim"

  -- formatting & linting
  use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
  use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

  -- treesitter configuration
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })

  -- auto closing
  use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
  use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

  -- git integration
  use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

  --toggle term 
  use {"akinsho/toggleterm.nvim", tag = '*'}

  -- auto save 
  use "Pocco81/auto-save.nvim"

  -- bufferline 
  use "nvim-tree/nvim-web-devicons"
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
  use {'glepnir/dashboard-nvim', requires = {'nvim-tree/nvim-web-devicons'}}

  -- 代码跳转
  use { 'phaazon/hop.nvim', branch = 'v2'}

  -- 自定义命令管理
  use { "LinArcX/telescope-command-palette.nvim" }

  -- 滚动
  use 'karb94/neoscroll.nvim'

  -- git历史查看
  use "APZelos/blamer.nvim"

  -- outline插件
  use 'simrat39/symbols-outline.nvim'

  -- markdonw previewer
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  use "jvgrootveld/telescope-zoxide"

  -- nvim debugger
  use 'mg979/vim-visual-multi'
  use 'mfussenegger/nvim-dap'
  use "folke/neodev.nvim"
  use {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {}
    },
  }
  use { "rcarriga/nvim-dap-ui",
      requires = {"mfussenegger/nvim-dap"},
      event = "VeryLazy"
  }
  -- nvim trouble 
  use {
    "folke/trouble.nvim",
     dependencies = { "nvim-tree/nvim-web-devicons" },
  }

  if packer_bootstrap then
    require("packer").sync()
  end

end)
