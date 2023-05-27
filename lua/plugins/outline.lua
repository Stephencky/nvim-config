local setup, outline = pcall(require, "symbols-outline")
if not setup then
  print("Failed to load symbols-outline")
  return
end

outline.setup()
