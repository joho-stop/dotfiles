" Reset all options
set all&

" Apparently this needs to be as early as possible
let mapleader = "\<space>"

" Use shell's background. This can be used to enable transparency
"au ColorScheme * hi Normal ctermbg=none guibg=none

" Couldn't get this to work, I think tmux or neovim still needs an update?
" Look into it again sometime...
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1

call plug#begin('~/.config/nvim/plugged') " ------------------------ Plug begin

" General
Plug 'tpope/vim-sensible'
Plug 'xolox/vim-misc' " Support for other xolox plugins
Plug 'kana/vim-operator-user' " Required by vim-clang-format

" Edit
Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-abolish'
" Plug 'svermeulen/vim-easyclip'

" Motion
Plug 'easymotion/vim-easymotion'

" Languages
Plug 'rust-lang/rust.vim'
Plug 'justinmk/vim-syntax-extra' " Better C syntax highlighting

" Status
Plug 'vim-airline/vim-airline'

" Git
Plug 'airblade/vim-gitgutter' " Status
Plug 'tpope/vim-fugitive' " Commands
" Plug 'chemzqm/vim-easygit'

" Color & display
Plug 'morhetz/gruvbox'
Plug 'luochen1990/rainbow'

" Unix/file system stuff
Plug 'tpope/vim-eunuch'

" Session management
Plug 'xolox/vim-session'

" Tags
Plug 'majutsushi/tagbar' " navigation

" Autocomplete
Plug 'Valloric/YouCompleteMe'

" Line numbers
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" Formatting
Plug 'rhysd/vim-clang-format'

" Not actually plugins, but vim-related
Plug 'powerline/fonts' " Fonts

call plug#end() " ---------------------------------------------------- Plug end

" Apparently C-space needs to be mapped differently depending on mode??
xnoremap <Nul> <Esc>
inoremap <C-space> <Esc>
" cnoremap <Nul> <Esc>
" onoremap <Nul> <Esc>

set splitbelow splitright " More natural splits
set scrolloff=3 " Minimum visible lines above and below the cursor
set showcmd " Show pending command
set hlsearch incsearch " Search settings

" This is a gitgutter recommendation, but apparently good in general? Need to
" look this up...
set updatetime=250

filetype plugin on

" Opening a new file hides the current one (instead of closing it)
" set hidden

" Track visited tags
set tagstack

set backspace=eol,start,indent " I guess this is the same as the default...

" ---------------------------------------------------------------------- rulers

" Highlight current line in current window
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

set colorcolumn=80 " Ruler

" --------------------------------------------------------------- formatoptions

set textwidth=79

" j Remove comment leader when joining lines
" q Allow formatting of comments with 'gq'.
" l Long lines are not broken in insert mode
" 1 Don't break a line after a one-letter word
" 2 When formatting text, use the indent of the SECOND line of a paragraph
set formatoptions-=tcroqwan2vblmMB1j
set formatoptions=jql12

" ------------------------------------------------------------------------ tabs

" Tabs display as 4 spaces
set tabstop=4

" Tabs are expanded to spaces
set expandtab

" Each tab inserts 4 spaces
set shiftwidth=4

" Backspace deletes to multiples of 4 spaces
set softtabstop=4 

" ---------------------------------------------------------------------- tagbar

nnoremap <F8> :TagbarToggle<CR>

" ------------------------------------------------------------------ whitespace

highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL

" ---------------------------------------------------------------- line numbers

set relativenumber number
let g:NumberToggleTrigger=""

" ---------------------------------------------------------- session management

let g:session_directory = "~/.config/nvim/sessions"

" If you only want to save the current tab page:
" set sessionoptions-=tabpages

" Don't save help, hidden/unloaded buffers, options
set sessionoptions-=help
set sessionoptions-=buffers
set sessionoptions-=options

let g:session_autosave_periodic = 1

" Disable autoload, but enable autosave when we are in a session
let g:session_autoload = 'no'
let g:session_autosave = 'yes'

" --------------------------------------------------------- luochen1990/rainbow

let g:rainbow_active=1

" --------------------------------------------------------------------- airline

let g:airline#extensions#tabline#enabled=1
set showtabline=1

" Use powerline characters in Airline
let g:airline_powerline_fonts=1

" --------------------------------------------------------------------- gruvbox

set background=dark
let g:gruvbox_bold=0
let g:gruvbox_italic=0
let g:gruvbox_underline=0
" let g:gruvbox_undercurl=0
let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox

" ------------------------------------------------------------------- gitgutter

let g:gitgutter_override_sign_column_highlight=0
let g:gitgutter_sign_column_always=1
highlight SignColumn ctermbg=none
highlight SignColumn guibg=none
highlight GitGutterAdd ctermbg=none
highlight GitGutterChange ctermbg=none
highlight GitGutterDelete ctermbg=none
highlight GitGutterChangeDelete ctermbg=none

" Turn off real-time update for gitgutter (slow)
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" ------------------------------------------------------------------ easymotion

let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1 " case insensitive-ish
nmap s <Plug>(easymotion-overwin-f2)

" ---------------------------------------------------------- vim-tmux-navigator
" Use this for custom mappings
"let g:tmux_navigator_no_mappings = 1

" --------------------------------------------------------------- YouCompleteMe

let g:ycm_global_ycm_extra_conf = $HOME . "/dotfiles/global_ycm_extra_conf.py"
let g:ycm_server_python_interpreter = "/usr/bin/python3"

" d = declaration/definition
nnoremap <leader>zd :YcmCompleter GoTo<CR>

" e = error
nnoremap <leader>ze :YcmShowDetailedDiagnostic<CR>

" F5 = refresh
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

" ------------------------------------------------------------------------ rust

" TODO: make this smarter (don't set it if not available?)
" Rust source for YouCompleteMe
"let g:ycm_rust_src_path='~/devel/rust-ycm/rustc-nightly/src'

" ---------------------------------------------------------------------- cscope

if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=1
    set cst
    set nocsverb
    " add any database in current directory
endif

""list of reference
"nnoremap <unique> <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
""definition
"nnoremap <unique> <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
""call
"nnoremap <unique> <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"nnoremap <unique> <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"nnoremap <unique> <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"nnoremap <unique> <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"nnoremap <unique> <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nnoremap <unique> <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" ------------------------------------------------------------ vim-clang-format

let g:clang_format#detect_style_file=1

autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" ------------------------------------------------------------- pane navigation

if exists(':tnoremap')
    " Navigation between panes with Alt+hjkl
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
endif

" I had this behind the 'exists' check above, but that doesn't seem right...
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" ------------------------------------------------------- private configuration

" Include private configuration if it exists
function! SourceIfExists(p)
	if filereadable(a:p)
		execute('source ' . a:p)
	endif
endfunction

call SourceIfExists($HOME . "/dotfiles_private/init.vim")
