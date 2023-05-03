local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"


-- if not vim.loop.fs_stat(lazypath) then
-- 	vim.fn.system({
-- 		"git",
-- 		"clone",
-- 		"--filter=blob:none",
-- 		"https://github.com/folke/lazy.nvim.git",
-- 		"--branch=stable", -- latest stable release
-- 		lazypath,
-- 	})
-- end
vim.opt.rtp:prepend(lazypath)

configs = require("plugins.configs")

require("lazy").setup({

	-- ui
	{
		"folke/tokyonight.nvim",
		config = function()
			vim.cmd [[colorscheme tokyonight-night]]
		end,
		priority = 100,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		event = "VimEnter",
		config = function()
			vim.defer_fn(function()
				vim.cmd [[hi IndentBlanklineChar guifg=#292929]]
				require("indent_blankline").setup()
			end, 0)

		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		lazy = true,
		event = "CursorMoved",
		config = function()
			require('colorizer').setup()
			require('colorizer').attach_to_buffer(0)
		end,
	},

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			configs.ts()
		end,
		event = { "UIEnter" },
		lazy = true,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = true,
		event = { "WinScrolled" },
		config = function()
			require("treesitter-context").setup({
				enable = true,
			})
		end,
	},

	-- lsp
	-- {
	-- 	"neovim/nvim-lspconfig",
	-- -- 	lazy = true,
	-- 	dependencies = {
	-- 		{"williamboman/mason-lspconfig.nvim"}
	-- 	},
	-- 	config = function()
	-- 		configs.lsp()
	-- 	end,
	-- },

	-- {
	-- 	"williamboman/mason.nvim",
	-- 	build = ":MasonUpdate",
	-- 	lazy = true,
	-- 	cmd = "Mason",
	-- 	config = function()
	-- 		require("mason").setup()
	-- 	end,
	--
	-- },

	-- completion
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "InsertEnter",

		dependencies = {
			{ "lukas-reineke/cmp-under-comparator" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "andersevenrud/cmp-tmux" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-buffer" },
		},
		config = function()
			configs.cmp()
		end,
	},
	{
		"windwp/nvim-autopairs",
		lazy = true,
		event = "InsertEnter",
		config = function()
			require('nvim-autopairs').setup({
				disable_filetype = {"TelescopePrompt", "vim"},
				enable_check_bracket_line = true,
			})
		end,

	},

	-- git
	{
		'kdheepak/lazygit.nvim',
		lazy = true,
		init = function()
			vim.keymap.set("n", "<Leader>gg", ":LazyGit<CR>")
		end,
		cmd = "LazyGit"
	},
	{
		"kyazdani42/nvim-tree.lua",
		lazy = true,
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		init = function()
			vim.keymap.set('n', '<Leader>d', ':NvimTreeToggle<CR>')
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
		config = function()
			require("nvim-tree").setup()
		end,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" }
		},
	},


	-- utils
	{
		"numToStr/Comment.nvim",
		lazy = true,
		keys = { "gc", "gcc" },
		event = { "ModeChanged" },
		config = function()
			require('Comment').setup()
		end
	},
	{
		"ggandor/leap.nvim",
		lazy = true,
		keys = {"s", "S"},
		dependencies = {
			{ "tpope/vim-repeat" },
		},
		config = function()
			require('leap').add_default_mappings()
		end,
	},
})

