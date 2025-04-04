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
			{ name = "luasnip" },
			{ name = "path" },
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "calc" },
		},

		snippet = {
			expand = function(args)
				require'luasnip'.lsp_expand(args.body)
			end
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


	vim.api.nvim_set_keymap("n", "GD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "Gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

	local capabilities = require('cmp_nvim_lsp').default_capabilities()

	require'lspconfig'.lua_ls.setup {
		capabilities = capabilities,
	}

	require'lspconfig'.clangd.setup {
		capabilities = capabilities,
	}

end

return M
