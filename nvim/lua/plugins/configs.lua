local M = {}

M.indent = function()
	require("indent_blankline").setup({
		filetype_exclude = { "dashboard" }
	})
end

M.packer_init = {
	ensure_dependencies = true,
	auto_clean = true,
	compile_on_sync = true,
}

M.tokyonight = function()
	local _, tn = pcall(require, 'tokyonight')
	tn.setup({
		transparent = true,
		style = 'moon',
		on_highlights = function(hl, c)
			hl.SpecialKey = { fg = "#2f3739" }
			hl.NonText = { fg = "#2f3739" }
		end,
	})
	vim.cmd "colorscheme tokyonight"
end

M.colorizer = function()
	local _, col = pcall(require, 'colorizer')
	col.setup()
	vim.defer_fn(function()
		col.attach_to_buffer(0)
	end, 0)
end

M.treesitter = function()
	local _, ts = pcall(require, 'nvim-treesitter.configs')
	ts.setup({
		ensure_installed = { "c", "lua", "python" },
		highlight = {
			enable = true,
			use_languagetree = true,
		},
		indent = {
			enable = true,
		},
	})
end

M.nvim_tree = function ()
	vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
	require("nvim-tree").setup({
		disable_netrw = true,
		hijack_netrw = true,
	})
end

M.telescope = function()
	local tls = require('telescope.builtin')
	vim.keymap.set('n', '<Leader>ff', tls.find_files, {})
	vim.keymap.set('n', '<Leader>fh', tls.oldfiles, {})
	vim.keymap.set('n', '<Leader>fg', tls.live_grep, {})
end

M.gitsigns = function()
	vim.api.nvim_set_hl(0, 'DiffAdd', { fg = "#00FF00", bold = true })
	vim.api.nvim_set_hl(0, 'DiffDelete', { fg = "#FF3131", bold = true })
	vim.api.nvim_set_hl(0, 'DiffChange', { fg = "#00FFFF", bold = true })
	require("gitsigns").setup({
		signs = {
			add = { hl = "DiffAdd", text = "+", numhl = "GitSignsAddNr" },
			change = { hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr" },
			delete = { hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr" },
			topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
			changedelete = { hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr" },
		},
	})
end

M.autopairs = function()
	require('nvim-autopairs').setup({
		disable_filetype = { "TelescopePrompt" , "vim" },
		enable_check_bracket_line = true,
	})

end


M.lualine = function()
	require("plugins.evil_lualine")
end

M.bufline = function()
	vim.opt.mousemev = true
	require("bufferline").setup({
		options = {
			mode = "tabs",
			hover = {
				enabled = true,
				delay = 200,
				reveal = {'close'}
			},
			offsets = {
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				separator = true,
			},
			always_show_bufferline = false,
		},
	})
end

return M

