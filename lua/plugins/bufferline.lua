local setup, bufferline = pcall(require, "bufferline")

if not setup then
  print("Bufferline is not properly install")
  return
end

bufferline.setup({
  options = {
    offsets = {
      {
        filetype = "NvimTree",
        text = function()
          return vim.fn.getcwd()
        end,
        highlight = "Directory",
        text_align = "left",
        seperator = true
      }
    },
    numbers = "ordinal",
    tab_size = 5,
    name_formatter = function(buf)  -- buf contains:
        return buf.name
          -- name                | str        | the basename of the active file
          -- path                | str        | the full path of the active file
          -- bufnr (buffer only) | int        | the number of the active buffer
          -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
          -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
    end,
  },
})
