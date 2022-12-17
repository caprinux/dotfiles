-- load packer
local present, packer = pcall(require, "packer")

if present then
	vim.cmd "packadd packer.nvim"

	configs = require("plugins.configs")
	lazy = require("core.lazy_load")
	local init_options = configs.packer_init

	packer.init(init_options)
	use = packer.use
	packer.reset()

	-- load on startup

	use "lewis6991/impatient.nvim"

	use "nvim-lua/plenary.nvim"

	-- ui

	use "wbthomason/packer.nvim"

	use { "lukas-reineke/indent-blankline.nvim",
		setup = function()
			lazy.on_file_open "indent-blankline.nvim"
		end,
		config = function()
			configs.indent()
		end,
	}

	use { "norcalli/nvim-colorizer.lua",
		setup = function()
			lazy.on_file_open "nvim-colorizer.lua"
		end,
		config = function()
			configs.colorizer()
		end,
	}

	-- use { "folke/tokyonight.nvim",
	-- 	after = "nvim-colorizer.lua",
	-- 	config = function()
	-- 		configs.tokyonight()
	-- 	end,
	-- }

	-- use { "nyoom-engineering/oxocarbon.nvim",
	-- 	after = "nvim-colorizer.lua",
	-- 	config = function()
	-- 		vim.opt.background = "dark" -- set this to dark or light
	-- 		vim.cmd.colorscheme "oxocarbon"
	-- 	end,
	-- }

	use { "catppuccin/nvim",
		as = "catppuccin",
		after = "nvim-colorizer.lua",
		config = function()
			configs.catppuccin()
			vim.cmd.colorscheme "catppuccin"
		end,
	}

	use { "nvim-lualine/lualine.nvim",
		after = "catppuccin",
		-- after = "tokyonight.nvim",
		-- after = "oxocarbon.nvim",
		config = function()
			configs.lualine()
		end,
	}

	use { "nvim-tree/nvim-web-devicons",
		after = "lualine.nvim",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	}

	use {"akinsho/bufferline.nvim",
		event = "TabNew",
		tag = "v3.*",
		config = function()
			configs.bufline()
		end,
	}

	use { "nvim-treesitter/nvim-treesitter",
		setup = function()
			lazy.on_file_open "nvim-treesitter"
		end,
		cmd = lazy.treesitter_cmds,
		run = ":TSUpdate",
		config = function()
			configs.treesitter()
		end,
	}

	use { "p00f/nvim-ts-rainbow",
		after = "nvim-treesitter",
	}

	use { 'nvim-treesitter/nvim-treesitter-context',
		after = "nvim-treesitter",
	}

	use { "goolord/alpha-nvim",
		config = function()
			require("alpha").setup(require("plugins.startify").config)
		end,
	}

	-- lsp

	use { "neovim/nvim-lspconfig",
		opt = true,
		setup = function()
			lazy.on_file_open "nvim-lspconfig"
		end,
		config = function()
			require("plugins.lsp")
		end,
	}

	use { "williamboman/mason.nvim",
		after = "nvim-lspconfig",
		config = function()
			require("mason").setup()
		end,
	}

	use { "williamboman/mason-lspconfig.nvim",
		cmd = lazy.masonlsp_cmds,
		config = function()
			require("mason-lspconfig").setup()
		end,
	}


	-- completion, snippets

	use { "ms-jpq/coq_nvim",
		event = "InsertEnter",
		branch = "coq",
		setup = function()
			vim.g.coq_settings = { auto_start = 'shut-up' }
		end,
		config = function()
			require("coq")
		end,
	}

	use { "ms-jpq/coq.artifacts",
		branch = "artifacts",
	}

	-- misc

	use { "numToStr/Comment.nvim",
		module = "Comment",
		keys = { "gc", "gb" },
		config = function()
			require("Comment").setup()
		end,
	}

	use { "kyazdani42/nvim-tree.lua",
		tag = "nightly",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		config = function()
			configs.nvim_tree()
		end,
	}

	use { "nvim-telescope/telescope.nvim",
		cmd = "Telescope",
	}

	use { "lewis6991/gitsigns.nvim",
		ft = "gitcommit",
		setup = function()
			lazy.gitsigns()
		end,
		config = function()
			configs.gitsigns()
		end,
	}

	use { "windwp/nvim-autopairs",
		after = "coq_nvim",
		config = function()
			configs.autopairs()
		end,
	}


	use { 'dstein64/vim-startuptime',
		cmd = 'StartupTime',
		config = [[vim.g.startuptime_tries = 10]]
	}

	use { 'ggandor/leap.nvim',
		keys = {"s", "S"},
		config = function()
			require('leap').add_default_mappings()
			-- vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = 'grey' })
		end,
	}

	use { 'chentoast/marks.nvim',
		keys = { "mx", "m," },
		config = function()
			require("marks").setup()
		end,

	}

	use { 'eandrju/cellular-automaton.nvim' }

end
