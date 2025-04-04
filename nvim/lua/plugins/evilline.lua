local M = {}

function M.lualine()
	-- Eviline config for lualine
	-- Author: shadmansaleh
	-- Credit: glepnir
	local lualine = require('lualine')

	-- Color table for highlights
	-- stylua: ignore
	local colors = {}
	if (vim.o.background == 'dark') then
		colors = {
			bg = nil,
			fg = "#c0caf5",
			yellow = "#e0af68",
			cyan = "#7dcfff",
			darkblue = "#3d59a1",
			green = "#9ece6a",
			orange = "#ff9e64",
			violet = "#9d7cd8",
			magenta = "#bb9af7",
			blue = "#2ac3de",
			red = "#f7768e",
		}
	elseif (vim.o.background == 'light') then
		colors = {
			bg = "#e1e2e7",
			fg = "#3760bf",
			yellow = "#8c6c3e",
			cyan = "#007197",
			darkblue = "#2e7de9",
			green = "#587539",
			orange = "#ea894f",
			violet = "#7847bd",
			magenta = "#9854f1",
			blue = "#2ac3de",
			red = "#f52a65",
		}
	end

	local conditions = {
		buffer_not_empty = function()
			return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
		end,
		hide_in_width = function()
			return vim.fn.winwidth(0) > 80
		end,
		check_git_workspace = function()
			local filepath = vim.fn.expand('%:p:h')
			local gitdir = vim.fn.finddir('.git', filepath .. ';')
			return gitdir and #gitdir > 0 and #gitdir < #filepath
		end,
	}

	-- Config
	local config = {
		options = {
			globalstatus = true,
			-- Disable sections and component separators
			component_separators = '',
			section_separators = '',
			theme = {
				-- We are going to use lualine_c an lualine_x as left and
				-- right section. Both are highlighted by c theme .  So we
				-- are just setting default looks o statusline
				normal = { c = { fg = colors.fg, bg = colors.bg } },
				inactive = { c = { fg = colors.fg, bg = colors.bg } },
			},
		},
		sections = {
			-- these are to remove the defaults
			lualine_a = {},
			lualine_b = {},
			lualine_y = {},
			lualine_z = {},
			-- These will be filled later
			lualine_c = {},
			lualine_x = {},
		},
		inactive_sections = {
			-- these are to remove the defaults
			lualine_a = {},
			lualine_b = {},
			lualine_y = {},
			lualine_z = {},
			lualine_c = {},
			lualine_x = {},
		},
	}

	-- Inserts a component in lualine_c at left section
	local function ins_left(component)
		table.insert(config.sections.lualine_c, component)
	end

	-- Inserts a component in lualine_x at right section
	local function ins_right(component)
		table.insert(config.sections.lualine_x, component)
	end

	ins_left {
		'filename',
		cond = conditions.buffer_not_empty,
		color = { fg = colors.magenta, gui = 'bold' },
	}

	ins_left {
		-- filesize component
		'filesize',
		cond = conditions.buffer_not_empty,
		color = { gui = 'bold' }
	}

	ins_left {
		'location',
		color = { fg = colors.yellow }
	}

	ins_left {
		'progress',
		color = { fg = colors.yellow, gui = 'bold' }
	}

	-- ins_left {
	-- 	'diagnostics',
	-- 	sources = { 'nvim_diagnostic' },
	-- 	symbols = { error = ' ', warn = ' ', info = ' ' },
	-- 	diagnostics_color = {
	-- 		color_error = { fg = colors.red },
	-- 		color_warn = { fg = colors.yellow },
	-- 		color_info = { fg = colors.cyan },
	-- 	},
	-- }

	-- Insert mid section. You can make any number of sections in neovim :)
	-- for lualine it's any number greater then 2
	ins_left {
		function()
			return "%="
		end,
	}

	-- ins_left {
	-- 	require("noice").api.status.mode.get,
	-- 	cond = require("noice").api.status.mode.has,
	-- 	color = { fg = colors.orange },
	-- }

	ins_left {
		-- mode component
		function()
			return vim.fn.mode()
		end,
		color = function()
			-- auto change color according to neovims mode
			local mode_color = {
				n = colors.red,
				i = colors.green,
				v = colors.blue,
				[''] = colors.blue,
				V = colors.blue,
				c = colors.magenta,
				no = colors.red,
				s = colors.orange,
				S = colors.orange,
				ic = colors.yellow,
				R = colors.violet,
				Rv = colors.violet,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				['r?'] = colors.cyan,
				['!'] = colors.red,
				t = colors.red,
			}
			return { fg = mode_color[vim.fn.mode()] }
		end,
		padding = { right = 1 },
	}

	-- Add components to right sections
	ins_left {
		'branch',
		icon = '',
		color = { fg = colors.violet, gui = 'bold' },
	}

	ins_left {
		'diff',
		-- Is it me or the symbol for modified us really weird
		symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
		diff_color = {
			added = { fg = colors.green },
			modified = { fg = colors.orange },
			removed = { fg = colors.red },
		},
		cond = conditions.hide_in_width,
	}

	ins_right {
		-- Lsp server name .
		function()
			local msg = 'No Active Lsp'
			local buf_ft = vim.api.nvim_get_option_value("filetype", {})
			local clients = vim.lsp.get_clients()
			if next(clients) == nil then
				return msg
			end
			for _, client in ipairs(clients) do
				local filetypes = client.config.filetypes
				if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
					return client.name
				end
			end
			return msg
		end,
		icon = ' LSP:',
		color = { fg = colors.fg, gui = 'bold' },
	}

	-- Now don't forget to initialize lualine
	lualine.setup(config)
end


return M
