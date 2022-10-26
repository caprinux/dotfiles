
require("mason").setup()
require("mason-lspconfig").setup()
local lsp = require "lspconfig"
local coq = require "coq" -- add this

lsp.sumneko_lua.setup(coq.lsp_ensure_capabilities({ -- after
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim', '' }
            }
        }
    }
}))
lsp.clangd.setup(coq.lsp_ensure_capabilities()) -- after
lsp.pyright.setup(coq.lsp_ensure_capabilities())
