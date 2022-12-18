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
vim.keymap.set('n', '<Leader>r', ':term python %<CR>i')
vim.keymap.set('n', '<C-t>', ':tabnew<CR>')
-- vim.keymap.set('n', '<C-w>', ':tabclose<CR>')
vim.keymap.set('n', '<Leader>d', ':NvimTreeToggle<CR>')

vim.keymap.set("n", "<Leader>ff", ":Telescope find_files<CR>")
vim.keymap.set("n", "<Leader>fh", ":Telescope oldfiles<CR>")
vim.keymap.set("n", "<Leader>fr", ":Telescope oldfiles<CR>")
vim.keymap.set("n", "<Leader>fg", ":Telescope live_grep<CR>")
vim.keymap.set("n", "<Leader>fm", ":lua vim.lsp.buf.format()<CR>")


vim.keymap.set("n", "zz", ":CellularAutomaton make_it_rain<CR>")



-- vim.keymap.set('n', 'gpd', ":lua require('goto-preview').goto_preview_definition()<CR>")
-- vim.keymap.set('n', 'gpt', ":lua require('goto-preview').goto_preview_implementation()<CR>")
-- vim.keymap.set('n', 'gP', ":lua require('goto-preview').close_all_win<CR>")
-- vim.keymap.set('n', 'gpr', ":lua require('goto-preview').goto_preview_references<CR>")
