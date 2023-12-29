local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local utils = require "telescope.utils"


-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
  print("Failed to load telescope")
  return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  print("Failed to load telescope actions")
  return
end

-- live grep args extensions
local lgs_setup, lga_actions = pcall(require, "telescope-live-grep-args.actions")
if not lgs_setup then
  print("Failed to load live grep args")
  return
end

-- project manager
local pro_setup, projects = pcall(require, "project_nvim")
if not pro_setup then
  print("Failed to load project nvim")
  return
end
projects.setup({})

-- Useful for easily creating commands
local z_utils = require("telescope._extensions.zoxide.utils")

-- configure telescope
telescope.setup({
  -- configure custom mappings
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close, -- close quickly
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
      },
    },
  },
  pickers = {
    current_buffer_fuzzy_find = {
      theme = "dropdown",
      previewer=false,
      winblend=10,
    },
    find_files = {
      theme = "dropdown",
      previewer=false,
      winblend=10,
    },
    git_files = {
      theme = "dropdown",
      previewer=false,
      winblend=10,
    },
    commands = {
      theme = "dropdown",
      previewer=false,
      winblend=15,
    }
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case", -- this is default
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    },
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i= {
          ["<C-;>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t " }),
        }
      }
    },
    command_palette = {
      {
        "File",
        { "Write Current Buffer", ":w" },
        { "Write All Buffers", ":wa" },
        { "Quit", ":qa" },
        { "File Browser", ":lua require'telescope'.extensions.file_browser.file_browser()", 1 },
        { "Search for Word", ":lua require('telescope.builtin').live_grep()", 1 },
        { "Find Files", ":lua require('telescope.builtin').find_files()", 1 },
        { "Project Files", ":lua require'plugins.telescope'.project_files()", 1 },
      },
      {
        "Terminal",
        { "Vertical Right", ":vsp | terminal", 1 },
      },
      {
        "Notes",
        { "Browse Notes", "lua require'joel.telescope'.browse_notes()", 1 },
        { "Find Notes", "lua require'joel.telescope'.find_notes()", 1 },
        { "Search/Grep Notes", "lua require'joel.telescope'.grep_notes()", 1 },
      },
      {
        "Toggle",
        { "cursor line", ":set cursorline!" },
        { "cursor column", ":set cursorcolumn!" },
        { "spell checker", ":set spell!" },
        { "relative number", ":set relativenumber!" },
        { "search highlighting", ":set hlsearch!" },
      },
      {
        "Neovim",
        { "checkhealth", ":checkhealth" },
        { "commands", ":lua require('telescope.builtin').commands()" },
        { "command history", ":lua require('telescope.builtin').command_history()" },
        { "registers", ":lua require('telescope.builtin').registers()" },
        { "options", ":lua require('telescope.builtin').vim_options()" },
        { "keymaps", ":lua require('telescope.builtin').keymaps()" },
        { "buffers", ":Telescope buffers" },
        { "search history", ":lua require('telescope.builtin').search_history()" },
      }
  },
  zoxide = {
    prompt_title = "\\ Root Directory /",
    mappings = {
      default = {
          after_action = function(selection)
            print("Update to (" .. selection.z_score .. ") " .. selection.path)
          end
      },
      ["<C-o>"] = {
        before_action = function(selection) print("before C-o") end,
        action = function(selection)
          vim.cmd.edit(selection.path)
        end
      },
      -- Opens the selected entry in a new split
      ["<C-q>"] = { action = z_utils.create_basic_command("split") },
    },
  }
}
})

telescope.load_extension("fzf")
telescope.load_extension("live_grep_args")
telescope.load_extension("projects")
telescope.load_extension("file_browser")
telescope.load_extension("command_palette")
telescope.load_extension("ui-select")
telescope.load_extension('zoxide')

-- my telescopic customizations
local M = {}

-- requires repo extension
-- function M.repo_list()
--   local opts = {}
--   opts.prompt_title = " Repos"
--   require("telescope").extensions.repo.list(opts)
-- end

-- grep_string pre-filtered from grep_prompt
local function grep_filtered(opts)
  opts = opts or {}
  require("telescope.builtin").grep_string {
    path_display = { "smart" },
    search = opts.filter_word or "",
  }
end

-- open vim.ui.input dressing prompt for initial filter
function M.grep_prompt()
  vim.ui.input({ prompt = "Rg " }, function(input)
    grep_filtered { filter_word = input }
  end)
end

-- search Neovim related todos
function M.search_todos()
  require("telescope.builtin").grep_string {
    prompt_title = " Search TODOUAs",
    prompt_prefix = " ",
    results_title = "Neovim TODOUAs",
    path_display = { "smart" },
    search = "TODOUA",
  }
end

-- grep Neovim source using cword
function M.grep_nvim_src()
  require("telescope.builtin").grep_string {
    results_title = "Neovim Source Code",
    path_display = { "smart" },
    search_dirs = {
      "~/vim-dev/sources/neovim/runtime/lua/vim/",
      "~/vim-dev/sources/neovim/src/nvim/",
    },
  }
end

function M.project_files()
  local _, ret, stderr = utils.get_os_command_output {
    "git",
    "rev-parse",
    "--is-inside-work-tree",
  }

  local gopts = {}
  local fopts = {}

  gopts.prompt_title = " Find"
  gopts.prompt_prefix = "  "
  gopts.results_title = " Repo Files"

  fopts.hidden = true
  fopts.file_ignore_patterns = {
    ".vim/",
    ".local/",
    ".cache/",
    "Downloads/",
    ".git/",
    "Dropbox/.*",
    "Library/.*",
    ".rustup/.*",
    "Movies/",
    ".cargo/registry/",
  }

  if ret == 0 then
    require("telescope.builtin").git_files(gopts)
  else
    fopts.results_title = "CWD: " .. vim.fn.getcwd()
    require("telescope.builtin").find_files(fopts)
  end
end

function M.find_configs()
  require("telescope.builtin").find_files {
    prompt_title = " NVim & Term Config Find",
    results_title = "Config Files Results",
    path_display = { "smart" },
    search_dirs = {
      "~/.oh-my-zsh/custom",
      "~/.config/nvim",
      "~/.config/alacritty",
    },
    -- cwd = "~/.config/nvim/",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  }
end

function M.nvim_config()
  require("telescope").extensions.file_browser.file_browser {
    prompt_title = " NVim Config Browse",
    cwd = "~/.config/nvim/",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  }
end

function M.file_explorer()
  require("telescope").extensions.file_browser.file_browser {
    prompt_title = " File Browser",
    path_display = { "smart" },
    cwd = "~",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  }
end

return M

