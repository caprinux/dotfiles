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
		style = 'night',
		-- style = 'moon',
		on_highlights = function(hl, c)
			hl.SpecialKey = { fg = "#2f3739" }
			hl.NonText = { fg = "#2f3739" }
		end,
	})
	vim.cmd.colorscheme "tokyonight"
end

M.catppuccin = function()
	require("catppuccin").setup({
		flavour = "mocha", -- Can be one of: latte, frappe, macchiato, mocha
		background = { light = "latte", dark = "mocha" },
		dim_inactive = {
			enabled = false,
			-- Dim inactive splits/windows/buffers.
			-- NOT recommended if you use old palette (a.k.a., mocha).
			shade = "dark",
			percentage = 0.15,
		},
		transparent_background = false,
		term_colors = true,
		compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
		styles = {
			comments = { "italic" },
			properties = { "italic" },
			functions = { "italic", "bold" },
			keywords = { "italic" },
			operators = { "bold" },
			conditionals = { "bold" },
			loops = { "bold" },
			booleans = { "bold", "italic" },
			numbers = {},
			types = {},
			strings = {},
			variables = {},
		},
		integrations = {
			treesitter = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
				},
			},
			bufferline = true,
			lsp_trouble = false,
			lsp_saga = false,
			gitgutter = false,
			gitsigns = true,
			telescope = true,
			nvimtree = true,
			which_key = false,
			treesitter_context = true,
			indent_blankline = { enabled = true, colored_indent_levels = false },
			dashboard = true,
			neogit = false,
			vim_sneak = false,
			fern = false,
			barbar = false,
			markdown = true,
			lightspeed = false,
			ts_rainbow = true,
			mason = true,
			neotest = false,
			noice = false,
			hop = false,
			illuminate = false,
			cmp = false,
			dap = { enabled = false, enable_ui = true },
			notify = false,
			symbols_outline = false,
			coc_nvim = false,
			leap = true,
			neotree = { enabled = false, show_root = true, transparent_panel = false },
			telekasten = false,
			mini = false,
			aerial = false,
			vimwiki = true,
			beacon = false,
			navic = { enabled = false },
			overseer = false,
			fidget = false,
		},
		color_overrides = {
			mocha = {
				rosewater = "#F5E0DC",
				flamingo = "#F2CDCD",
				mauve = "#DDB6F2",
				pink = "#F5C2E7",
				red = "#F28FAD",
				maroon = "#E8A2AF",
				peach = "#F8BD96",
				yellow = "#FAE3B0",
				green = "#ABE9B3",
				blue = "#96CDFB",
				sky = "#89DCEB",
				teal = "#B5E8E0",
				lavender = "#C9CBFF",

				text = "#D9E0EE",
				subtext1 = "#BAC2DE",
				subtext0 = "#A6ADC8",
				overlay2 = "#C3BAC6",
				overlay1 = "#988BA2",
				overlay0 = "#6E6C7E",
				surface2 = "#6E6C7E",
				surface1 = "#575268",
				surface0 = "#302D41",

				base = "#1E1E2E",
				mantle = "#1A1826",
				crust = "#161320",
			},
		},
		highlight_overrides = {
			mocha = function(cp)
				return {
					-- For base configs.
					CursorLineNr = { fg = cp.green },
					Search = { bg = cp.surface1, fg = cp.pink, style = { "bold" } },
					IncSearch = { bg = cp.pink, fg = cp.surface1 },
					LeapBackdrop = { fg = cp.surface2 },

					-- For native lsp configs.
					DiagnosticVirtualTextError = { bg = cp.none },
					DiagnosticVirtualTextWarn = { bg = cp.none },
					DiagnosticVirtualTextInfo = { bg = cp.none },
					DiagnosticVirtualTextHint = { fg = cp.rosewater, bg = cp.none },

					DiagnosticHint = { fg = cp.rosewater },
					LspDiagnosticsDefaultHint = { fg = cp.rosewater },
					LspDiagnosticsHint = { fg = cp.rosewater },
					LspDiagnosticsVirtualTextHint = { fg = cp.rosewater },
					LspDiagnosticsUnderlineHint = { sp = cp.rosewater },

					-- For fidget.
					FidgetTask = { bg = cp.none, fg = cp.surface2 },
					FidgetTitle = { fg = cp.blue, style = { "bold" } },

					-- For treesitter.
					["@field"] = { fg = cp.rosewater },
					["@property"] = { fg = cp.yellow },

					["@include"] = { fg = cp.teal },
					["@operator"] = { fg = cp.sky },
					["@keyword.operator"] = { fg = cp.sky },
					["@punctuation.special"] = { fg = cp.maroon },

					-- ["@float"] = { fg = cp.peach },
					-- ["@number"] = { fg = cp.peach },
					-- ["@boolean"] = { fg = cp.peach },

					["@constructor"] = { fg = cp.lavender },
					-- ["@constant"] = { fg = cp.peach },
					-- ["@conditional"] = { fg = cp.mauve },
					-- ["@repeat"] = { fg = cp.mauve },
					["@exception"] = { fg = cp.peach },

					["@constant.builtin"] = { fg = cp.lavender },
					-- ["@function.builtin"] = { fg = cp.peach, style = { "italic" } },
					-- ["@type.builtin"] = { fg = cp.yellow, style = { "italic" } },
					["@variable.builtin"] = { fg = cp.red, style = { "italic" } },

					-- ["@function"] = { fg = cp.blue },
					["@function.macro"] = { fg = cp.red, style = {} },
					["@parameter"] = { fg = cp.rosewater },
					["@keyword.function"] = { fg = cp.maroon },
					["@keyword"] = { fg = cp.red },
					["@keyword.return"] = { fg = cp.pink, style = {} },

					-- ["@text.note"] = { fg = cp.base, bg = cp.blue },
					-- ["@text.warning"] = { fg = cp.base, bg = cp.yellow },
					-- ["@text.danger"] = { fg = cp.base, bg = cp.red },
					-- ["@constant.macro"] = { fg = cp.mauve },

					-- ["@label"] = { fg = cp.blue },
					["@method"] = { style = { "italic" } },
					["@namespace"] = { fg = cp.rosewater, style = {} },

					["@punctuation.delimiter"] = { fg = cp.teal },
					["@punctuation.bracket"] = { fg = cp.overlay2 },
					-- ["@string"] = { fg = cp.green },
					-- ["@string.regex"] = { fg = cp.peach },
					-- ["@type"] = { fg = cp.yellow },
					["@variable"] = { fg = cp.text },
					["@tag.attribute"] = { fg = cp.mauve, style = { "italic" } },
					["@tag"] = { fg = cp.peach },
					["@tag.delimiter"] = { fg = cp.maroon },
					["@text"] = { fg = cp.text },

					-- ["@text.uri"] = { fg = cp.rosewater, style = { "italic", "underline" } },
					-- ["@text.literal"] = { fg = cp.teal, style = { "italic" } },
					-- ["@text.reference"] = { fg = cp.lavender, style = { "bold" } },
					-- ["@text.title"] = { fg = cp.blue, style = { "bold" } },
					-- ["@text.emphasis"] = { fg = cp.maroon, style = { "italic" } },
					-- ["@text.strong"] = { fg = cp.maroon, style = { "bold" } },
					-- ["@string.escape"] = { fg = cp.pink },

					-- ["@property.toml"] = { fg = cp.blue },
					-- ["@field.yaml"] = { fg = cp.blue },

					-- ["@label.json"] = { fg = cp.blue },

					["@function.builtin.bash"] = { fg = cp.red, style = { "italic" } },
					["@parameter.bash"] = { fg = cp.yellow, style = { "italic" } },

					["@field.lua"] = { fg = cp.lavender },
					["@constructor.lua"] = { fg = cp.flamingo },

					["@constant.java"] = { fg = cp.teal },

					["@property.typescript"] = { fg = cp.lavender, style = { "italic" } },
					-- ["@constructor.typescript"] = { fg = cp.lavender },

					-- ["@constructor.tsx"] = { fg = cp.lavender },
					-- ["@tag.attribute.tsx"] = { fg = cp.mauve },

					["@type.css"] = { fg = cp.lavender },
					["@property.css"] = { fg = cp.yellow, style = { "italic" } },

					["@property.cpp"] = { fg = cp.text },

					-- ["@symbol"] = { fg = cp.flamingo },
				}
			end,
		},
	})
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
			disable = { "python" },
		},
		rainbow = {
			enable = true,
			extended_mode = true,
			max_file_lines = nil,
		}
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
	require('lualine').setup {
		options = {
			theme = "catppuccin"
		}
	}
	-- require("plugins.evil_lualine")
end

M.bufline = function()
	vim.opt.mousemev = true
	require("bufferline").setup({
		highlights = require("catppuccin.groups.integrations.bufferline").get(),
		options = {
			mode = "tabs",
			hover = {
				enabled = true,
				delay = 200,
				reveal = {'close'}
			},
			-- offsets = {
			-- 	filetype = "NvimTree",
			-- 	text = "File Explorer",
			-- 	highlight = "Directory",
			-- 	separator = true,
			-- },
			always_show_bufferline = false,
		},
	})
end

return M

