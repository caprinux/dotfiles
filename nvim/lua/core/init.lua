vim.opt.termguicolors = true

vim.opt.rnu = true
vim.opt.nu = true

vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

vim.opt.signcolumn = 'yes:2'

vim.opt.listchars = { trail = '•', eol = '¬', tab = '  '}
vim.opt.list = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.undofile = true

require "core.keymaps"

vim.g.python3_host_prog = "/usr/bin/python3"
