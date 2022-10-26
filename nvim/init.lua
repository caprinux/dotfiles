vim.cmd [[packadd packer.nvim]]
require('packer').startup{ function(use)
	use { 'wbthomason/packer.nvim' } -- Extension Manager
	use { 'lewis6991/impatient.nvim' } -- Speed things up
	use { 'folke/tokyonight.nvim' } -- Theme
	use { 'lukas-reineke/indent-blankline.nvim', event = 'BufRead' } -- Indent
	use { 'norcalli/nvim-colorizer.lua' } -- Color code
	use { 'nvim-treesitter/nvim-treesitter' } -- Syntax Highlighting
	use { 'windwp/nvim-autopairs' }
	use { 'ms-jpq/coq_nvim' } -- Auto-complete
	use { 'ms-jpq/coq.artifacts',
	after = 'coq_nvim'}
	use { "williamboman/mason.nvim" } -- LSP Manager
	use { "williamboman/mason-lspconfig.nvim"}
	use { 'preservim/nerdtree', cmd = 'NERDTree' }
	use { 'airblade/vim-gitgutter' }
	use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
	use { 'windwp/nvim-ts-autotag' }
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}
	use { 'dstein64/vim-startuptime' }
	use { 'ggandor/lightspeed.nvim',
	requires = {'tpope/vim-repeat'}}
	use { 'nvim-lualine/lualine.nvim',
	requires = { 'kyazdani42/nvim-web-devicons', opt = true }}
end
}

vim.opt.termguicolors = true

require('impatient')
require('Comment').setup()
require('nvim-ts-autotag').setup()
require('colorizer').setup()
require('nvim-autopairs').setup()
require('nvim-treesitter.configs').setup {
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	}
}

vim.opt.rnu = true
vim.opt.number = true
vim.opt.signcolumn = "yes:2"

vim.cmd([[
colorscheme tokyonight

highlight clear SignColumn
highlight statusline ctermfg=black ctermbg=white
highlight Normal guibg=NONE guifg=NONE
highlight Whitespace guifg=#2f3739
highlight LineNr guifg=#424d4e
highlight clear CursorLine
highlight CursorLineNR cterm=bold term=bold gui=bold

set tabstop=4
set listchars=tab:›\ ,eol:¬,trail:•
set list
set shiftwidth=4
set cursorline
set updatetime=100

let g:coq_settings = { 'auto_start': 'shut-up' }

let g:gitgutter_sign_added = ' +'
let g:gitgutter_sign_removed = ' -'
highlight GitGutterAdd    guifg=#07e400 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

match Whitespace /\s/
match Whitespace /\t/
match whitespace /\n/

" keymaps
map <C-s> :w!<cr>
map <C-x> :wq!<cr>
map <C-q> :q!<cr>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>s :noh<Enter>
nnoremap <silent> <C-l> :nohl<CR><C-l>
noremap <leader>f :FZF<Enter>
noremap <leader>p :GitGutterToggle<Enter>
noremap <leader>l :ALEToggle<Enter>
noremap <leader>t :tabnew<Enter>
noremap <leader>w :tabclose<Enter>
noremap <leader>d :NERDTree<Enter>
]])

require('coq')
require "evil_lualine"
require "lsp"

