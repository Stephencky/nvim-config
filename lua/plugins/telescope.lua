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
  extensions = {
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i= {
          ["<C-;>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t " }),
        }
      }
    }
  },

})

telescope.load_extension("fzf")
telescope.load_extension("live_grep_args")
telescope.load_extension("projects")
