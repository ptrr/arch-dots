let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" This vimrc automatically installs everything it needs.
" To install, or reinstall, remove ~/.vim directory and open Vim.

set nocompatible
" set re=1
syntax on
filetype off

let needsToInstallBundles=0
if !isdirectory(expand("~/.vim/bundle/vundle"))
  echo "\nInstalling Vim dependencies... Please be patient!\n"
  silent !mkdir -p ~/.vim/tmp
  silent !mkdir -p ~/.vim/swap
  silent !mkdir -p ~/.vim/undo
  silent !mkdir -p ~/.vim/bundle
  silent !mkfifo ~/.vim/commands-fifo
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
  let needsToInstallBundles=1
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Do these first, because other plugins depend on them
Bundle 'gmarik/vundle'

Bundle 'scrooloose/nerdtree'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'elixir-lang/vim-elixir'
Bundle 'gkz/vim-ls'
Bundle 'kassio/neoterm'
Bundle 'mileszs/ack.vim'
Bundle 'slim-template/vim-slim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/tir_black'
Bundle 'vim-airline/vim-airline'
Bundle 'morhetz/gruvbox'
Bundle 'reedes/vim-colors-pencil'
Bundle 'frankier/neovim-colors-solarized-truecolor-only'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'ptrr/pastel-cleanser'
Bundle 'w0ng/vim-hybrid'
Bundle 'nanotech/jellybeans.vim'
Bundle 'rust-lang/rust.vim'
Bundle 'racer-rust/vim-racer'
Bundle 'valloric/YouCompleteMe'
Bundle 'posva/vim-vue'

if needsToInstallBundles == 1
  echo "\nInstalling Bundles, please ignore key map error messages\n"
  :BundleInstall!
  echo "\nInstalled.\n"
endif

filetype plugin indent on

" ==========================
" SETTINGS
" ==========================
colorscheme jellybeans
set background=dark
highlight Normal ctermbg=none
highlight NonText ctermbg=none

if has('gui_running')
  set guifont=PragmataPro\ for\ Powerline:h11
  set guioptions-=r
endif

set vb t_vb=               " Turn off beep
set lazyredraw             " Don't redraw during macro execution
set synmaxcol=2048         " Stop syntax highlighting for long lines
set number
set nowrap                 " No wrapping by default
set scrolloff=4            " Keep a few lines above and below current line
set equalalways            " create equally sized splits
set splitbelow splitright  " split placement
set wildmode=longest,list  " Makes completion in command mode like bash
set history=1000           " Keep a lot of stuff in history
set nobackup               " Make backups
set backupdir=~/.vim/tmp/  " Keep backups in a central location
set directory=~/.vim/swap/ " Keep swap files in a central location
set undofile               " Keep undo history even after closing Vim
set undodir=~/.vim/undo    " Where to store undo history
set timeoutlen=500         " Don't wait so long for ambiguous leader keys
set noesckeys              " Get rid of the delay when hitting esc!
set gdefault               " assume the /g flag on :s substitutions to replace all matches in a line
set colorcolumn=80
set linespace=5

" Indenting always 2 spaces, sorry Python
set cindent
set expandtab
set shiftwidth=2
set smartindent
set softtabstop=2
set tabstop=2

" Search
set smartcase
set hlsearch
set wildignore+=**/tmp

" neovim terminal configuration
tnoremap <Esc> <C-\><C-n>

" neoterm configuration
let g:neoterm_position = 'vertical'

command! Ttrb :T env PARTIAL=false TRUNCATE=true COUNTRIES=nl bundle exec rails runner t.rb; and time env PARTIAL=true TRUNCATE=false COUNTRIES=de bundle exec rails runner t.rb
nnoremap <silent> ,th :Ttrb<cr>

" Show “invisible” characters
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

let ruby_no_expensive = 1 " Differentiate between do..end and class..end is slow
let ruby_operators = 1    " Highlight Ruby operators

let g:netrw_list_hide  = "\.git,\.DS_Store"
let g:netrw_banner     = 0
let g:netrw_localrmdir='rm -r'

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Colorthings
let g:airline_theme = 'jellybeans'
let g:airline_powerline_fonts = 1
let g:pencil_higher_contrast_ui = 1

let g:solarized_termcolors=256

set formatprg=par\ -w80\ -q

" ==========================
" AUTOCOMMANDS
" ==========================

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Format xml files
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

au BufNewFile,BufRead *.rs set filetype=rust
au BufNewFile,BufRead *.slim set filetype=slim
au BufNewFile,BufRead *.coffee set filetype=coffeescript

" ==========================
" GENERAL KEY MAPPINGS
" ==========================

" Rename :W to :w
command! W :w

" Use OSX pbpaste/pbcopy for F1/F2, for use in terminal
nmap <F1> :set paste<cr>:r !pbpaste<cr>:set nopaste<cr>
imap <F1> <Esc>:set paste<cr>:r !pbpaste<cr>:set nopaste<cr>
nmap <F2> :.w !pbcopy<cr><cr>
vmap <F2> :w !pbcopy<cr><cr>

" in insert mode, jj goes to normal mode
" if you ever need to type jj for real, type it slowly, like on old school mobile phones
inoremap jj <ESC>

" Directly switch between open splitted windows
nnoremap <C-J> <C-W>j
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
nnoremap <C-K> <C-W>k

" LOL such dedication
map <UP> ""
map <DOWN> ""
map <LEFT> ""
map <RIGHT> ""

" pressing j or k in a long wrapped will put cursor down/up one visual line
nnoremap j gj
nnoremap k gk

" Shift+K becomes similar to Shift+J
nnoremap <S-k> kJ

" Remap return to clear search highlight
nnoremap <cr> :nohlsearch<cr>

" In normal mode, space will start command mode.
nnoremap <space> :

" Buffer Explorer opens with Ctrl+B
nnoremap <C-B> :BufExplorer<cr>

" %% will become the directory of the current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Hooks up smart tab autocomplete behavior mentioned above
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" A common typo is ":E" when actually meaning ":e" and not ":Explore" or
" ":Errors".
cnoreabbrev E e
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev WQ wq
cnoreabbrev Wq wq

" ==========================
" LEADER KEYS
" ==========================

let mapleader = ","

" Map ,e and ,v to open files in the same directory as the current file
map <leader>e :edit %%
map <leader>v :view %%
map <leader>m :vsplit %%
map <leader>n :split %%

let g:pencil_gutter_color = 1      " 0=mono (def), 1=color
let g:racer_cmd = "/Users/peterderuijter/.cargo/bin/racer"
let g:ycm_python_binary_path = 'python'

map <leader>l :set list!<CR>
map <leader>w :set wrap!<CR>
map <leader>n :NERDTreeToggle<CR>
map <leader>m :TagbarToggle<CR>

let g:rspec_command_launcher = "iterm"
let g:rspec_command = 'call Send_to_Tmux("zeus rspec {spec}\n")'

" Fugitive (Git)
map <Leader><Leader>c :Gcommit<cr>
map <Leader><Leader>b :GBlame<cr>
map <Leader><Leader>s :Gstatus<cr>
map <Leader><Leader>w :Gwrite<cr>
map <Leader><Leader>p :Git push<cr>
map <Leader><Leader>f :Git fetch<cr>
map <Leader><Leader>u :Git up<cr>

" Open notes file
map <Leader>q :split ~/Dropbox/notes.md<cr>

" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>s :call StripWhitespace()<CR>

" ==========================
" FUNCTIONS
" ==========================

" Smart tab autocomplete behavior
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction

nnoremap <C-p> :Unite file_rec/async<cr>
nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding = 'utf-8'
endif

map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
map <Leader>cc :colorscheme = (:colorscheme == "gruvbox"? "papercolor" : "gruvbox" )<CR>
