local M = {}

M.ts = function()
	local _, ts = pcall(require, 'nvim-treesitter.configs')
	ts.setup({
		ensure_installed = { "c", "lua", "python" },
		highlight = {
			enable = true,
			use_languagetree = true,
			additional_vim_regex_highlighting = true,
		},
		indent = {
			enable = true,
			-- disable = { "python" },
		},
		rainbow = {
			enable = true,
			extended_mode = true,
			max_file_lines = nil,
		}
	})
end

M.cmp = function()
	local cmp = require("cmp")
	cmp.setup({

		sources = {
			{
				name = "tmux",
				option = {
					all_panes = true,
				},
			},
			{ name = "path" },
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "calc" },
		},

		mapping = cmp.mapping.preset.insert({
			['<C-q>'] = cmp.mapping.select_prev_item(),
			['<C-w>'] = cmp.mapping.select_next_item(),
			['<C-e>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm({ select = true }),
			['<Tab>'] = cmp.mapping.select_next_item(),
		}),
		sorting = {
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				require "cmp-under-comparator".under,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
	})
end

M.lsp = function()
	require'lspconfig'.lua_ls.setup {
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = 'LuaJIT',
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = {'vim'},
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	}

end

return M
