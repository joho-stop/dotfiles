" GO AWAY
set all&

" Apparently this needs to be as early as possible
let mapleader=" "

" Use shell's background. This can be used to enable transparency
"au ColorScheme * hi Normal ctermbg=none guibg=none

call plug#begin('~/.config/nvim/plugged') " ------------------------ Plug begin

" General
Plug 'tpope/vim-sensible'
Plug 'xolox/vim-misc' " Support for other xolox plugins

" Pane/split navigation, integrated with tmux!
"   Unfortunately, it doesn't work right when nvim is called indirectly
"   (On the tmux side, the suggested way to detect vim is with a regex)
" Plug 'christoomey/vim-tmux-navigator'

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
Plug 'airblade/vim-gitgutter'

" Color & display
Plug 'morhetz/gruvbox'
Plug 'luochen1990/rainbow'
Plug 'nathanaelkane/vim-indent-guides'
" Plug 'Yggdroot/indentline' " Hmm.. which one's better?

" File system stuff
Plug 'tpope/vim-eunuch'

" File navigation
" Plug 'scrooloose/nerdtree'

" Tag navigation
Plug 'majutsushi/tagbar'

" Session management
Plug 'xolox/vim-session'

" Tag management
" Plug 'xolox/vim-easytags'

" Autocomplete
Plug 'Valloric/YouCompleteMe'

" Not actually plugins, but vim-related
Plug 'powerline/fonts' " Fonts
" Plug 'dan-t/rusty-tags' " Tags for rust

" Line numbers
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" Plug 'scrooloose/syntastic'
" Plug 'scrooloose/nerdcommenter'
" Plug 'ntpeters/vim-better-whitespace' " didn't work??
" Plug ' ... vim-fugitive'
" Plug 'chemzqm/vim-easygit'
" Plug 'terryma/vim-multiple-cursors'

call plug#end() " ---------------------------------------------------- Plug end

" I'm sure this won't cause issues ;)
inoremap <C-space> <Esc>

" gruvbox
set background=dark
let g:gruvbox_bold=0
let g:gruvbox_italic=0
let g:gruvbox_underline=0
" let g:gruvbox_undercurl=0
let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox

" " Black cursorline
" highlight CursorLine ctermbg=Black
" highlight CursorLineNR ctermbg=Black

set colorcolumn=80
" highlight ColorColumn ctermbg=Black

" Use powerline characters in Airline
let g:airline_powerline_fonts=1

" Rust source for YouCompleteMe
let g:ycm_rust_src_path='~/devel/rust-ycm/rustc-nightly/src'

" More natural splits
set splitbelow splitright

" Highlight current line in current window
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" GitGutter settings
let g:gitgutter_override_sign_column_highlight=0
let g:gitgutter_sign_column_always=1
highlight SignColumn ctermbg=none
highlight SignColumn guibg=none
highlight GitGutterAdd ctermbg=none
highlight GitGutterChange ctermbg=none
highlight GitGutterDelete ctermbg=none
highlight GitGutterChangeDelete ctermbg=none

" Turn off real-time update for gitgutter
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" This is a gitgutter recommendation, but apparently good in general? Need to
" look this up...
set updatetime=250

" Turn on rainbow parens
let g:rainbow_active=1

filetype plugin on

set showcmd

" Opening a new file hides the current one (instead of closing it)
" set hidden

" Tabs are width 4
set tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab

set backspace=eol,start,indent " I guess this is the same as the default...

set hlsearch

set incsearch

" Minimum visible lines above and below the cursor
set scrolloff=3

let g:airline#extensions#tabline#enabled=1
set showtabline=1

" ------------------------------------------------------------------ whitespace

highlight ExtraWhitespace ctermbg=red guibg=red
" JAM: This part isn't needed when using vim-better-whitespace
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

" ------------------------------------------------------------------ easymotion

let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1 " case insensitive-ish
" map <Leader> <Plug>(easymotion-prefix)
nmap s <Plug>(easymotion-overwin-f2)

" ---------------------------------------------------------- vim-tmux-navigator
" Use this for custom mappings
"let g:tmux_navigator_no_mappings = 1

" ------------------------------------------------------------------ Rust stuff

" Possibly obsolete?
au BufNewFile,BufRead *.rs set filetype=rust

" -------------------------------------------------------------- Terminal stuff

if exists(':tnoremap')
    " Navigation between panes with Alt+hjkl
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l
endif

" ------------------------------------------------------- Private configuration

" Include private configuration if it exists
function! SourceIfExists(p)
	if filereadable(a:p)
		execute('source ' . a:p)
	endif
endfunction

call SourceIfExists($HOME . "/dotfiles_private/init.vim")


