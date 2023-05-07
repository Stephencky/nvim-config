local setup, hop = pcall(require, "hop")
if not setup then
  print("Failed to load hop")
  return
end

hop.setup({
  keys = 'etovxqpdygfblzhckisuran',
})
