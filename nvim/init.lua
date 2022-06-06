vim.cmd [[packadd packer.nvim]]
require('packer').startup{ function()
	use { 'wbthomason/packer.nvim' }
	use { 'lewis6991/impatient.nvim' }
	use { 'folke/tokyonight.nvim' }
	use { 'lukas-reineke/indent-blankline.nvim', event = 'BufRead' }
	use { 'norcalli/nvim-colorizer.lua' }
	use { 'nvim-treesitter/nvim-treesitter' }
	use { 'dense-analysis/ale',
		ft = {'sh', 'c', 'python', 'lua'},
		event = 'VimEnter'
	}
	use { 'windwp/nvim-autopairs' }
	use { 'ms-jpq/coq_nvim' }
	use { 'ms-jpq/coq.artifacts',
		after = 'coq_nvim'}
	use { 'preservim/nerdtree', cmd = 'NERDTree' }	
	use { 'airblade/vim-gitgutter' }
	use { 'windwp/nvim-ts-autotag' }
	use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
	}
	end }

require('impatient')
require('Comment').setup()
require('nvim-ts-autotag').setup()

vim.opt.rnu = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes:2"

require('colorizer').setup()
require('nvim-autopairs').setup()
require'nvim-treesitter.configs'.setup {
highlight = {
enable = true,
additional_vim_regex_highlighting = false,
}}

vim.cmd([[
let b:ale_linters = ['luacheck', 'vint', 'cquery', 'clang', 'flake8', 'shellcheck', 'bashate', 'cargo']
let b:ale_fixers = ['autopep8', 'yapf']
let b:ale_warn_about_trailing_whitespace = 0
let g:ale_python_flake8_options = '--ignore=E226,E501,F403,F405,E201,E123'
highlight ALEErrorSign guifg=Red
highlight ALEWarningSign guifg=Orange
let g:ale_sign_warning = ' ⚠'
let g:ale_sign_error = '>>'

colorscheme tokyonight
highlight clear SignColumn
highlight statusline ctermfg=black ctermbg=white
highlight Normal guibg=NONE guifg=NONE
set tabstop=4
set listchars=tab:›\ ,eol:¬,trail:•
set list
set shiftwidth=4
let g:coq_settings = { 'auto_start': 'shut-up' }
hi Whitespace guifg=#2f3739
hi LineNr guifg=#424d4e
set cursorline
hi clear CursorLine
hi CursorLineNR cterm=bold term=bold gui=bold
set updatetime=100

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? ' OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

set statusline=%f\ %h%w%m%r\ 
set statusline+=%{GitStatus()}
set statusline+=%=%{LinterStatus()}\ \ \ %(%l,%c%V\ %=\ %P%)

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
noremap <leader>f za
nnoremap <silent> <C-l> :nohl<CR><C-l>
noremap <leader>f :FZF<Enter>
noremap <leader>p :GitGutterToggle<Enter>
noremap <leader>l :ALEToggle<Enter>
noremap <leader>t :tabnew<Enter>
noremap <leader>w :tabclose<Enter>
noremap <leader>d :NERDTree<Enter>
]])
require('coq')
