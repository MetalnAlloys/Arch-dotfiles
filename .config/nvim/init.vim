scriptencoding utf-8

runtime! archlinux.vim
colorscheme miramare

"----------------------"
"       SETTINGS       "
"----------------------"
set number relativenumber
set textwidth=79
set tabstop=8
set shiftwidth=4
set expandtab                       	    	
set softtabstop=4
set cursorline
set mouse=a
set splitbelow
set foldmethod=indent
set foldlevel=99
set modeline
set timeout timeoutlen=1000
set noswapfile nobackup nowritebackup
set noshowmode
set termguicolors
set ignorecase smartcase
set wildmode=full


let g:markdown_fenced_languages = ['cpp', 'c', 'json', 'rs', 'rs']
let g:livepreview_previewer = 'zathura'
let g:livepreview_use_biber = 1
let g:livepreview_engine = 'xelatex'
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
let asmsyntax = 'nasm'
let g:c_syntax_for_h=1
"let g:rustfmt_autosave = 1

""----- TAGS -----"
"let g:vista_default_executive = 'ctags'
"let g:vista_executive_for = {
    "\ 'c': 'nvim_lsp',
    "\ 'rust': 'nvim_lsp',
    "\ }

"----------------------"
"       DEOPLETE       "
"----------------------"

set runtimepath+=~/.config/nvim/plugged/deoplete.nvim/
call deoplete#custom#option({
            \ 'check_stderr': v:false,
            \ 'max_list': 100,
            \ })

let g:deoplete#enable_at_startup = 1



"'''----------------------"
"      LIGHTLINE       "
"----------------------"

let g:lightline = {
            \ 'colorscheme': 'miramare',
            \ 'component': {
            \   'readonly': '%{&readonly?"":""}',
            \ },
            \ 'separator':    { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' },
            \ }



"----------------------"
"       AUTORUN        "
"----------------------"
"au Filetype lua setl omnifunc=v:lua.vim.lsp.omnifunc

autocmd Filetype ipynb nmap <silent><Leader>b :VimpyterInsertPythonBlock<CR>
autocmd Filetype ipynb nmap <silent><Leader>j :VimpyterStartJupyter<CR>

augroup trigger
    autocmd!

    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && NERDTree.isTabTree()) | q | endif


augroup end

augroup custom
    autocmd!

    autocmd FileType c setlocal cindent
    autocmd FileType markdown setlocal conceallevel=2
    autocmd FileType tex setlocal textwidth=100

    "autocmd BufEnter * lua require'completion'.on_attach()

augroup end




"----------------------"
"       KEYMAPS        "
"----------------------"

let mapleader = ','
tnoremap <Esc> <C-\><C-n>

map <C-b> :NERDTreeToggle<CR>

map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

nnoremap <space> za

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

map <C-e> :!chmod u+x %<CR>
nmap <F8> :TagbarToggle<CR>
vnoremap <C-c> "+y
vnoremap <C-v> "+p
nnoremap <silent> <leader>F :FZF ~<cr>


"set dictionary+=/usr/share/dict/words
"set complete+=k

"--gitgutter--
nmap gx <plug>(GitGutterNextHunk)
nmap gy <plug>(GitGutterPrevHunk)
let g:gitgutter_realtime=0
let g:gitgutter_sign_column_always=0
let g:gitgutter_map_keys=0

imap <C-a> <ESC><C-a>

"---init.vim--------------"
cnoreabbrev vr :e $HOME/init.vim
cnoreabbrev vrr :source $HOME/init.vim


"----------------------"
"       PLUGINS        "
"----------------------"

"----------------------| Completion |-------------"
call plug#begin()

Plug 'neovim/nvim-lspconfig'
Plug 'Shougo/deoplete.nvim'
Plug 'https://github.com/Shougo/deoplete-lsp'

Plug 'wsdjeg/vim-lua'
Plug 'haorenW1025/diagnostic-nvim'
"Plug 'nvim-lua/completion-nvim'
"--------------| Colors |--------------------"
Plug 'hardcoreplayers/oceanic-material'
Plug 'Nequo/vim-allomancer'
Plug 'arcticicestudio/nord-vim'
Plug 'relastle/bluewery.vim'
Plug 'gilgigilgil/anderson.vim'
Plug 'ntk148v/vim-horizon'
Plug 'doums/darcula'
Plug 'franbach/miramare'
Plug 'https://github.com/cocopon/iceberg.vim'
Plug 'embark-theme/vim', { 'as': 'embark' }
"Plug 'nvim-treesitter/nvim-treesitter'
"----------------| Syntax | ---------------------"

Plug 'sheerun/vim-polyglot'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'nlknguyen/c-syntax.vim',              {'for': 'c'}
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml',                    {'for': 'toml'}
"Plug 'JuliaEditorSupport/julia-vim'

"----------------| Editing |--------------------"
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'https://github.com/itchyny/lightline.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'ryanoasis/vim-devicons'
Plug 'universal-ctags/ctags'
Plug 'airblade/vim-gitgutter'
Plug 'sbdchd/neoformat'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
"Plug 'liuchengxu/vista.vim'
Plug 'preservim/nerdcommenter'
Plug 'https://github.com/preservim/tagbar'
Plug 'szymonmaszke/vimpyter'

call plug#end()

" ----------------------------|LSP Conf| -----------------------------"


lua require'nvim_lsp'.vimls.setup{ on_attach=require'diagnostic'.on_attach }
lua require'nvim_lsp'.bashls.setup{ on_attach=require'diagnostic'.on_attach }
lua require'nvim_lsp'.clangd.setup{on_attach=require'diagnostic'.on_attach}
lua require'nvim_lsp'.rust_analyzer.setup{ on_attach=require'diagnostic'.on_attach}
lua require'nvim_lsp'.pyls.setup{ on_attach=require'diagnostic'.on_attach}
lua require'nvim_lsp'.texlab.setup{ on_attach=require'diagnostic'.on_attach}

"lua << EOF
"local on_attach_vim = function(client)
"  require'completion'.on_attach(client)
"  require'diagnostic'.on_attach(client)
"end
"require'nvim_lsp'.clangd.setup{on_attach=on_attach_vim}
"require'nvim_lsp'.rust_analyzer.setup{on_attach=on_attach_vim}
"EOF

"---------------- |Keymaps| ------------------------------"

function! s:check_back_space() abort
    let col = col('.') - 0
    return !col || getline('.')[col - 0] =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ completion#trigger_completion()

set completeopt=menuone,noinsert,noselect

set shortmess+=c
nnoremap <silent> gp :PrevDiagnostic<CR>
nnoremap <silent> gn :NextDiagnostic<CR>




"----- |diagnostic-nvim| -------------------"
"
sign define LspDiagnosticsErrorSign text=
sign define LspDiagnosticsWarningSign text=
sign define LspDiagnosticsInformationSign text=
sign define LspDiagnosticsHintSign text=

  let g:diagnostic_insert_delay = 1
  let g:diagnostic_enable_virtual_text = 1
  let g:diagnostic_virtual_text_prefix = ''
  let g:diagnostic_trimmed_virtual_text = '0'
  let g:diagnostic_enable_underline = 0


" ------------------Tree-sitter---------"

"lua <<EOF
"require'nvim-treesitter.configs'.setup {
  "highlight = {
    "enable = true,              -- false will disable the whole extension
  "},
"}
"EOF
