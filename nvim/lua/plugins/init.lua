-- initialize lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})

		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

configs = require("plugins.configs")

require("lazy").setup({

	-- ui
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.evilline").lualine()
		end,
	},
	{
		"folke/tokyonight.nvim",
		config = function()
			vim.cmd [[colorscheme tokyonight-night]]
		end,
		priority = 100,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		version = "2.20.8",
		lazy = true,
		event = "BufRead",
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
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		-- event = "BufReadPre",
		ft = { "gitcommit", "diff" },
		init = function()
			vim.api.nvim_create_autocmd("BufRead", {
				group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
				callback = function()
					vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
					if vim.v.shell_error == 0 then
						vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
						vim.schedule(function()
							require("lazy").load { plugins = { "gitsigns.nvim" } }
						end)
					end
				end,
				
			})
		end,
		config = function()
			require('gitsigns').setup()
		end,
	},

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			vim.treesitter.language.register('python', 'sage')
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
	{
		"smjonas/inc-rename.nvim",
		lazy = true,
		cmd = "IncRename",
		opts = {},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.diagnostic.enable(false) -- disable linting
			local path = vim.fn.stdpath("data").."/mason/bin"
			vim.env.PATH = path .. ":" .. vim.env.PATH -- hacky way to add mason to linux path
			configs.lsp()
		end,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		lazy = true,
		cmd = "Mason",
		opts = {},

	},
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		opts = {
			-- cfg options
			bind = true,
		},
	},

	-- completion
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "InsertEnter",

		dependencies = {
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
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
		opts = {
			disable_filetype = {"TelescopePrompt", "vim"},
			enable_check_bracket_line = true,
		},
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

		opts = function()
			return require "plugins.nvimtree"
		end,
		config = function(_, opts)
			require("nvim-tree").setup(opts)
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
		opts = {},
		-- config = function()
		-- 	require('Comment').setup()
		-- end
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		event = "CursorMoved",
		-- config = function()
		-- 	require("todo-comments").setup()
		-- end
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
	{
		"ggandor/flit.nvim",
		lazy = true,
		keys = {"f", "F", "t", "T"},
		config = function()
			require('flit').setup()
		end,
	},
	{
		"mbbill/undotree",
		lazy = true,
		cmd = "UndotreeToggle",
	},
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		lazy = true,
		keys = {"<leader>ff", "<leader>fg", "<leader>fb", "<leader>fr"},
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
			vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
			-- vim.keymap.set('n', '<leader>gr', builtin.buffers, { desc = 'Telescope buffers' })
			vim.keymap.set('n', '<leader>fr', ':Telescope lsp_references<CR>')
		end
	}
})
