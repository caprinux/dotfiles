local lsp = require "lspconfig"
local coq = require "coq"

lsp.sumneko_lua.setup(coq.lsp_ensure_capabilities({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }
			}
		}
	},
}))
lsp.clangd.setup(coq.lsp_ensure_capabilities())
lsp.pylsp.setup({
	settings = {
		pylsp = {
			plugins = {
				flake8 = {
					enabled = true,
					ignore = {'F405','F403'},
				},
				pyflakes = {
					enabled = false,
				}
			}
		}
	}
})
-- lsp.pyright.setup(coq.lsp_ensure_capabilities())
lsp.bashls.setup(coq.lsp_ensure_capabilities())
lsp.jdtls.setup(coq.lsp_ensure_capabilities())

