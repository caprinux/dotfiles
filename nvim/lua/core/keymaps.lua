vim.keymap.set('n', '<C-s>', ':w!<CR>')
vim.keymap.set('n', '<C-x>', ':wq!<CR>')
vim.keymap.set('n', '<C-q>', ':q!<CR>')

vim.keymap.set('n', '<Leader>1', '1gt')
vim.keymap.set('n', '<Leader>2', '2gt')
vim.keymap.set('n', '<Leader>3', '3gt')
vim.keymap.set('n', '<Leader>4', '4gt')
vim.keymap.set('n', '<Leader>5', '5gt')
vim.keymap.set('n', '<Leader>6', '6gt')
vim.keymap.set('n', '<Leader>7', '7gt')
vim.keymap.set('n', '<Leader>8', '8gt')
vim.keymap.set('n', '<Leader>9', '9gt')

vim.keymap.set('n', '<C-l>', ':nohl<CR>')
vim.keymap.set('n', '<C-t>', ':tabnew<CR>')
vim.keymap.set('n', '<Leader>d', ':NvimTreeToggle<CR>')

vim.keymap.set("n", "<Leader>y", "\"*y")
vim.keymap.set("v", "<Leader>y", "\"*y")

-- run python files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
	vim.keymap.set('n', '<Leader>r', ':term python %<CR>i')
  end,
})
