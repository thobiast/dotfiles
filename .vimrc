syntax on                " Enable syntax highlighting

set visualbell           " No beeps

set hlsearch             " Highlight searches
set ignorecase           " Use case insensitive search
set ignorecase smartcase " Use case insensitive search, except when using capital letters
" set incsearch            " Start searching before pressing enter.

set wildmenu             " Visual autocomplete for command menu

set showmatch            " Highlight matching [{()}]

set nofoldenable         " Disable folding

" Default settings for all files, unless specified on FileType
set tabstop=4            " A hard TAB displays as 4 columns
set shiftwidth=4         " Spaces for each step of (auto)indent
set noexpandtab          " Do not convert tab to space
set autoindent           " Align the new line indent with the previous line

filetype indent on       " Load filetype-specific indent files
filetype on              " File type detection

" Shell defaults
au FileType sh setlocal autoindent expandtab tabstop=4 textwidth=98 softtabstop=4

" Dockerfile defaults
au FileType dockerfile setlocal autoindent expandtab tabstop=4 textwidth=78 softtabstop=4

" YAML defaults
au FileType yaml setlocal autoindent expandtab tabstop=2 softtabstop=2 shiftwidth=2

" Python defaults
au FileType python setlocal autoindent expandtab tabstop=4 textwidth=98 softtabstop=4
" enable all Python syntax highlighting features
let python_highlight_all = 1

" Ruby defaults
au FileType ruby setlocal autoindent expandtab tabstop=2 shiftwidth=2 softtabstop=2

" Git commit message limited to 72 columns
au FileType gitcommit setlocal textwidth=72

" Txt2tags
au BufNewFile,BufRead *.t2t setlocal ft=txt2tags

" Terraform
au BufNewFile,BufRead *.tf  setlocal ft=terraform expandtab tabstop=2 shiftwidth=2 softtabstop=2
au BufNewFile,BufRead *.hcl setlocal ft=terraform expandtab tabstop=2 shiftwidth=2 softtabstop=2

" Always show the status line
set laststatus=2
set statusline =
set statusline +=%F                " full path
set statusline +=%m                " modified flag
set statusline +=\ -\              " seperator
set statusline +=%y                " file type
set statusline +=[FORMAT=%{&ff}]   " file format
set statusline +=%=\ line:%l/%L\ col:%c\ \ \ %p%%\  " line: col e % of file

" map to run ctags
map <f12> :!ctags -R .<cr>
" maps to commment line and uncomment line
map cl  :s/^/#/g<CR>:let @/ = ""<CR>
map ucl :s/^#//g<CR>:let @/ = ""<CR>

" Highlights blank space or tab at end of line
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Add - to word match
set iskeyword+=-
"set iskeyword+=.

" ctags - present a list if there are multiple matches instead of jumping
" to first match
nnoremap <C-]> g<C-]>

" vim-gitgutter - disable by default
let g:gitgutter_enabled = 0
" vim-gitgutter - ctrl g - to show/hide
map <C-g> :GitGutterToggle<CR>

" vim-ale - disable by default
let g:ale_enabled = 0
" vim-ale -  increase delay linters run
let g:ale_lint_delay = 600
" vim-ale - ctrl l - to show/hide
map <C-l> :ALEToggle<CR>

" ctrl o - to open nerdtree
map <C-o> :NERDTreeToggle<CR>
" close vim if the only window left open is a nerdtree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
