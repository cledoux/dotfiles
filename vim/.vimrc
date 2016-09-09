" Modeline and Notes {{{ 
" vim: set foldmarker={{{,}}} foldmethod=marker foldlevel=0 spell: 
"
"   Author: Charles LeDoux
"
"   This is my personal .vimrc.  Use at your own risk. 
"
"   The only things that should go in this file are global configurations
"   and plugin options. Plugin options need to be set here so they'll take
"   effect. Anything else, such as file type specific configurations,
"   belongs in its own plugin.
"
"   This file is in the public domain.
"
"   Suggestions and bugs can be emailed to charles@charlesledoux.com 
" }}}

" Load vim-plug {{{
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!mkdir -p ~/.vim/autoload'
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif
" }}}

set nocompatible
set modeline
filetype plugin indent on

" Plugins {{{

call plug#begin('~/.vim/plugged')

" Colorschemes
Plug 'altercation/vim-colors-solarized'

" Better statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Seamless switching between tmux and vim splits
Plug 'christoomey/vim-tmux-navigator'

" Filetype for tmux plugin
Plug 'tmux-plugins/vim-tmux'

" Get the focus-events to work correctly in tmux
Plug 'tmux-plugins/vim-tmux-focus-events'

" Put git info in statusline
Plug 'airblade/vim-gitgutter'

" File exploration in VIM!
Plug 'scrooloose/nerdtree' | Plug 'jistr/vim-nerdtree-tabs', {'on': 'NERDTreeToggle'}

" Syntax checking
Plug 'scrooloose/syntastic'

" Use zeal from vim.
Plug 'KabbAmine/zeavim.vim'

" Turn on tag (ctags) support
Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'

" Auto close delimeters (),[],{{{}}}, etc
Plug 'jiangmiao/auto-pairs'

" Completion
" Plug 'Valloric/YouCompleteMe', {'for': 'python', 'do': './install.py'}
" Testing out neocomplete.
" Plug 'Shougo/neocomplete.vim'
" Make sure rope is disabled in python-mode.
Plug 'davidhalter/jedi-vim'

" Utilisnips engine.
" vim-snippets provides the actual snippets.
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Surround is one of the most useful vim plugins ever.
Plug 'tpope/vim-surround'

" Comment toggling
Plug 'tomtom/tcomment_vim'

" Turn vim into a super-duper python editor.
Plug 'klen/python-mode'

" Latex editing goodness
" Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'lervag/vimtex'
" Enable if folding becomes slow.
" https://github.com/Konfekt/FastFold

" Pandoc syntax and plugin
" Don't use this and the markdown plugin
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Dockerfile syntax
Plug 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}

" Logstash
Plug 'robbles/logstash.vim'

" Prose Linter.
Plug 'amperser/proselint' , {'rtp': '/plugins/vim/syntastic_proselint'}

" My customizations
" Using full git url so can push changes directly.
" Otherwise vim-plug uses an https url
Plug 'git@github.com:cledoux/vim-togglecopy.git'
Plug 'git@bitbucket.org:cledoux/cledoux-vim-plugin.git'

" File finding
" There's a binding I have that is conflicting with this plugin
" Plug 'kien/ctrlp.vim'

" Create the emacs 'kill-ring'
" Supposedly works under vim, throws clipboard errors on nvim.
" Plug 'vim-scripts/YankRing.vim'
" Only works under nvim
" Plug 'bfred/nvim-miniyank'

" Vim Sessions
" I'm currently using tmux-ressurrect to save all state.
" Plug 'tpope/vim-obsession'

" Highlight and strip trailing whitespace
Plug 'ntpeters/vim-better-whitespace'

" Brief Vim-Plug help {{{
" # Commands
"
"| Command                             | Description                                                        |
"| ----------------------------------- | ------------------------------------------------------------------ |
"| `PlugInstall [name ...] [#threads]` | Install plugins                                                    |
"| `PlugUpdate [name ...] [#threads]`  | Install or update plugins                                          |
"| `PlugClean[!]`                      | Remove unused directories (bang version will clean without prompt) |
"| `PlugUpgrade`                       | Upgrade vim-plug itself                                            |
"| `PlugStatus`                        | Check the status of plugins                                        |
"| `PlugDiff`                          | See the updated changes from the previous PlugUpdate               |
"| `PlugSnapshot [output path]`        | Generate script for restoring the current snapshot of the plugins  |
"
"# `Plug` options
"
"| Option         | Description                                      |
"| -------------- | ------------------------------------------------ |
"| `branch`/`tag` | Branch or tag of the repository to use           |
"| `rtp`          | Subdirectory that contains Vim plugin            |
"| `dir`          | Custom directory for the plugin                  |
"| `do`           | Post-update hook (string or funcref)             |
"| `on`           | On-demand loading: Commands or `<Plug>`-mappings |
"| `for`          | On-demand loading: File types                    |
"| `frozen`       | Do not update unless explicitly specified        |
"
"# Global options
"
"| Flag                | Default                           | Description                                            |
"| ------------------- | --------------------------------- | ------------------------------------------------------ |
"| `g:plug_threads`    | 16                                | Default number of threads to use                       |
"| `g:plug_timeout`    | 60                                | Time limit of each task in seconds (*Ruby & Python*)   |
"| `g:plug_retries`    | 2                                 | Number of retries in case of timeout (*Ruby & Python*) |
"| `g:plug_shallow`    | 1                                 | Use shallow clone                                      |
"| `g:plug_window`     | `vertical topleft new`            | Command to open plug window                            |
"| `g:plug_url_format` | `https://git::@github.com/%s.git` | `printf` format to build repo URL                      |
"
"# Keybindings
"
"- `D` - `PlugDiff`
"- `S` - `PlugStatus`
"- `R` - Retry failed update or installation tasks
"- `U` - Update plugins in the selected range
"- `q` - Close the window
"- `:PlugStatus`
"    - `L` - Load plugin
"- `:PlugDiff`
"    - `X` - Revert the update
" }}}

call plug#end()
" }}}

" VIM Settings {{{

" Encoding, Language, Mouse {{{
" Set UTF-8 encoding
set encoding=utf-8
" Set spell check language to English
set spelllang=en_us
" Turn mouse support on.
set mouse=a
" Helps when in tmux
set ttymouse=xterm2

" }}}

" Display Settings {{{
"
" Set number of colors before setting color scheme
" Solarized required setting to 16.
" Alternative is 256
set t_Co=16
let g:solarized_termcolors=16
colorscheme solarized
set background=dark

" Turn on line numbers
set number
" Put name of file in title
set title 
" Turn on syntax highlighting
" Turn off with syntax off
syntax enable
" Visual, not audio bell
set visualbell
" Display position in file
set ruler
" Context lines around cursor
set scrolloff=3

" }}}

" Search Behavior {{{
" Without upper case in search, ignore case.  Otherwise, case sensitive.
set ignorecase
set smartcase
" Incremental and highlight search
set incsearch
set hlsearch
" }}}

" Indentation and Wrapping {{{
" Copy indentation from previous line
" Will not interfere with file type based
" indentation.  Do not use smartindent or 
" cindent as these can interfere with
" file type based indentation
set autoindent 
" Set tab character width
set tabstop=4 
set softtabstop=4
" Indent width for autoindent
set shiftwidth=4 
" Expand tabs to spaces.
set expandtab 
" Softwrap on lines when needed
set wrap
" Default textwidth
" Setting short so that half-screening doesn't mess up flow.
set textwidth=72
" Break lines based on breakat value
set linebreak
" }}}

" Alt-key fix {{{
" http://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim
if ! has('gui_running')
    let c='a'
    while c <= 'z'
      exec "set <A-".c.">=\e".c
      exec "imap \e".c." <A-".c.">"
      let c = nr2char(1+char2nr(c))
    endw

    set timeout ttimeoutlen=50
endif

" }}}

" Completion {{{
set completeopt="menu,preview"
set wildmenu
" }}}

" Misc {{{
" Ignore warnings on compiling
set errorformat^=%-G%f:%l:\ warning:%m
" Use central location for meta files
set directory=~/.backup//,/tmp//,.
" Vertical splits go right
set splitright
" Use system clipboard
" I've found this more annoying than anything because of my habit
" of putting something into the clipboard that I want to paste and
" then deleting text in vim, overwriting the clipboard
" set clipboard=unnamedplus
" Put only a single space after periods
set nojoinspaces
" }}}

" }}}

" Key Mappings {{{
" Set the leader key
let mapleader="\<Space>"
" Map fd to exit to normal mode
" This is chosen to match spacemacs
inoremap fd <ESC>
" Toggle folds
map , za
" Remove current highlighting of search words
map <leader>n :noh<CR>
" File save and quit shortcuts.
map <leader>w :w<CR>
map <leader>q :q<CR>
map <leader>x :x<CR>
" Format paragraph
map <leader>g gwip
" Set J to set the previously jump mark
nnoremap J m`J
" Set <leader>J to not move the curson
nnoremap <leader>j m`J``
" Set <C-Y> to join lines without moving the cursor
"nmap <C-Y> J``
" Add a space to the end of each line in the paragraph.
" Used to fix paragraphs that have been tainted by the
" evil that is emacs.
map <silent> <leader>s {j<S-V>}kJ
" Map Ctrl + Vim navigation keys to windows navigation
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
" Swap the functionality of nav-key and g+nav-key
" This sets nav-key to work on screen lines and
" g+nav-key to work on logical lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k
" Copy to and from system with <leader>{y,p}
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
" Turn on full backspace support
set backspace=indent,eol,start
" }}}

" Plugin Options {{{

" Latex {{{
" Most of the configuration should be done in the ftplugin config file:
" bundle/vim-configuration/ftplugin/tex.vim
"
" Configuration below works better at the global level.

" Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Turn off quotes autopairs for tex files. Let custom quotes functions take
" over.
au Filetype tex let b:AutoPairs={'(':')', '[':']', '{':'}'} 

" }}}

" Tag List Plugin {{{
map <silent> <leader>l :TlistToggle<CR>
let Tlist_Use_Right_Window=1
let Tlist_Sort_Type="name"
" }}}

" Vim-Pandoc {{{
" Formatting options:
"   s: Use soft wraps
"   h: Use hard wraps
"   a: autoformat
let g:pandoc#formatting#mode = "ha"
" Turn on full keyword search in bibtex
let g:pandoc#biblio#use_bibtool = 1
" Turn off the wysiwyg editor
let g:pandoc#syntax#conceal#use = 0
"}}}

" Utilisnips {{{
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
"}}}

" Airline {{{
" Always show status line
set laststatus=2
" Enable Powerline fonts
let g:airline_powerline_fonts = 1
" Show PASTE if in paste mode
let g:airline_detect_paste=1
" Show airline for tabs too
let g:airline#extensions#tabline#enabled = 1
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1
" Manually set the color theme because I hate that damn yellow.
let g:airline_theme='solarized'
"let g:airline_theme='molokai'
" Required after having changed the colorscheme
hi clear SignColumn
" }}}

" {{{ NERDTree 
" Open/close NERDTree Tabs with \t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
" To have NERDTree always open on startup
"let g:nerdtree_tabs_open_on_console_startup = 0
" }}}

" {{{ Syntastic
" ----- scrooloose/syntastic settings -----
" Fancy!
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
" Config for latex
augroup mySyntastic
 au!
 au FileType tex let b:syntastic_mode = "passive"
augroup END
" Use python3 checker
let g:syntastic_python_python_exec = "python3"
" Select checkers
let g:syntastic_python_checkers = ['python', 'pylama']
" Turn off line too long warnings
let g:syntastic_python_pylama_args='--ignore=E501'
" Recommended defaults for beginners
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Turn on prose lint for tex and markdown files.
let g:syntastic_tex_checkers = ['chktex', 'lacheck', 'proselint']
"let g:syntastic_markdown_checkers = ['mdl', 'proselint']

let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }}}

" {{{ Tags (ctags) support
" ----- xolox/vim-easytags settings -----
" Where to look for tags files
"set tags=$HOME/.vimtags/tags
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_by_filetype='~/.vimtags'
let g:easytags_resolve_links = 1

" ----- majutsushi/tagbar settings -----
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)
" }}}

" Vim-Tmux-Navigation {{{
let g:tmux_navigator_no_mappings = 1

" Perform the mappings we actually want
nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
nnoremap <silent> <M-\> :TmuxNavigatePrevious<cr>
" }}}

" Jedi-vim {{{
" Don't automatically popup anything.
let g:jedi#popup_on_dot = 0
" }}}

" Python Mode {{{
" disable syntax checker and let syntastic handle it instead.
let g:pymode_lint = 0
let g:pymode_lint_write = 0
" Turn off rope functionality
let g:pymode_rope = 0
" Let YouCompleteMe handle completions
let g:pymode_rope_completion = 0

" }}}

" }}}

" Archived Plugin Options {{{

" YouCompleteMe {{{
" Do not load YCM for these filetypes.
let g:ycm_filetype_blacklist = {
    \ 'tex'   : 1,
    \ 'latex' : 1,
    \ 'text'  : 1
\}
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
nnoremap <leader>jd :YcmCompleter GoTo<CR>
" }}}

" {{{ DelimitMate
" let delimitMate_expand_cr = 1
" augroup mydelimitMate
"  au!
"  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
"  au FileType tex let b:delimitMate_quotes = ""
"  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
"  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
" augroup END
" }}}


" Neocomplete {{{
" if exists(':NeoCompleteEnable')
"     " Recommended configuration from github readme.
"     "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
"     " Disable AutoComplPop.
"     let g:acp_enableAtStartup = 0
"     " Use neocomplete.
"     let g:neocomplete#enable_at_startup = 1
"     " Use smartcase.
"     let g:neocomplete#enable_smart_case = 1
"     " No autocomplete
"     let g:neocomplete#disable_auto_complete = 1
"     " Set minimum syntax keyword length.
"     let g:neocomplete#sources#syntax#min_keyword_length = 3
"     let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"
"     " Define dictionary.
"     let g:neocomplete#sources#dictionary#dictionaries = {
"         \ 'default' : '',
"         \ 'vimshell' : $HOME.'/.vimshell_hist',
"         \ 'scheme' : $HOME.'/.gosh_completions'
"             \ }
"
"     " Define keyword.
"     if !exists('g:neocomplete#keyword_patterns')
"         let g:neocomplete#keyword_patterns = {}
"     endif
"     let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"
"     " Plugin key-mappings.
"     inoremap <expr><C-g>     neocomplete#undo_completion()
"     inoremap <expr><C-l>     neocomplete#complete_common_string()
"
"     " Recommended key-mappings.
"     " <CR>: close popup and save indent.
"     inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"     function! s:my_cr_function()
"       return neocomplete#close_popup() . "\<CR>"
"       " For no inserting <CR> key.
"       "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
"     endfunction
"     " <TAB>: completion.
"     inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"     " <C-h>, <BS>: close popup and delete backword char.
"     inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"     inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"     inoremap <expr><C-y>  neocomplete#close_popup()
"     inoremap <expr><C-e>  neocomplete#cancel_popup()
"     " Close popup by <Space>.
"     "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
"
"     " For cursor moving in insert mode(Not recommended)
"     "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"     "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"     "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"     "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
"     " Or set this.
"     "let g:neocomplete#enable_cursor_hold_i = 1
"     " Or set this.
"     "let g:neocomplete#enable_insert_char_pre = 1
"
"     " AutoComplPop like behavior.
"     "let g:neocomplete#enable_auto_select = 1
"
"     " Shell like behavior(not recommended).
"     "set completeopt+=longest
"     "let g:neocomplete#enable_auto_select = 1
"     "let g:neocomplete#disable_auto_complete = 1
"     "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
"
"     " Enable omni completion.
"     autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"     autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"     autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"     autocmd FileType python setlocal omnifunc=jedi#completions
"     autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"
"     " Jedi options
"     let g:jedi#completions_enabled = 0
"     let g:jedi#auto_vim_configuration = 0
"
"
"     " Enable heavy omni completion.
"     if !exists('g:neocomplete#sources#omni#input_patterns')
"       let g:neocomplete#sources#omni#input_patterns = {}
"     endif
"     let g:neocomplete#sources#omni#input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'')'
"     "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"     "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"     "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"
"     " For perlomni.vim setting.
"     " https://github.com/c9s/perlomni.vim
"     let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" endif
" }}}


" Vimtex {{{
" Configure YouCompleteMe to work with vimtex
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
    \ 're!\\[A-Za-z]*(ref|cite)[A-Za-z]*([^]]*])?{([^}]*, ?)*'
    \ ]

" Configure neoeomplete to work with vimtex
if !exists('g:neocomplete#sources#omni#input_patterns')
let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex =
    \ '\v\\\a*(ref|cite)\a*([^]]*\])?\{([^}]*,)*[^}]*'

" Gets citation completion working with \input 
let g:vimtex_complete_recursize_bib = 1

" Turn folding on by default
let g:vimtex_fold_enabled = 1

" }}}

" }}}

