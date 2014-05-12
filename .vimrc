"---------------------------------------------------------------------
" base settings
"---------------------------------------------------------------------

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'vim-scripts/Align'
NeoBundle 'vim-scripts/The-NERD-Commenter'
NeoBundle 'othree/eregex.vim'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'othree/html5.vim'
NeoBundle 'hail2u/vim-css-syntax'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'wookiehangover/jshint.vim'
NeoBundle 'jnwhiteh/vim-golang'
NeoBundle 'airblade/vim-gitgutter'

NeoBundleCheck


syntax on
filetype plugin indent on

set nocompatible
set number
set hidden
set title
set ruler

set autoread

set splitbelow
set splitright

set autoindent
set smartindent

set hlsearch
set nowrapscan
set showmatch
set showmode

set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

set whichwrap=b,s,h,l,<,>,[,]
set backspace=indent,eol,start
set browsedir=buffer

set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set showcmd

set wildmode=list,full

set virtualedit=all

set modeline

set clipboard=unnamed,autoselect

if exists('&ambiwidth')
  set ambiwidth=double
endif

highlight Pmenu ctermbg=4
highlight SpellBad ctermbg=blue

highlight clear SignColumn

"swp files
set directory-=.

"backup files
set backup
set backupdir=/tmp

"show special character
set list
set lcs=tab:>-,trail:_,extends:>,precedes:<,nbsp:x

" remove autocomment
autocmd FileType * set formatoptions-=ro

" for perl files
autocmd BufNewFile,BufRead *.perl set filetype=perl
autocmd BufNewFile,BufRead *.psgi set filetype=perl
autocmd BufNewFile,BufRead *.t set filetype=perl

"---------------------------------------------------------------------
" Key mappings
"---------------------------------------------------------------------

" mapleader
let mapleader = ","

" for basics
nnoremap <Space>w :<C-u>write<CR>
nnoremap <Space>q :<C-u>quit<CR>
nnoremap <Space>a :<C-u>wqall<CR>

nnoremap <Space>v :<C-u>tabnew ~/.vimrc<CR>
nnoremap <Space>s :<C-u>source ~/.vimrc<CR>

nnoremap <Space>zz :<C-u>tabnew ~/.zshrc<CR>
nnoremap <Space>ze :<C-u>tabnew ~/.zshenv<CR>
nnoremap <Space>za :<C-u>tabnew ~/.zshalias<CR>

nnoremap <Space>zlz :<C-u>tabnew ~/.zshrc.local<CR>
nnoremap <Space>zle :<C-u>tabnew ~/.zshenv.local<CR>
nnoremap <Space>zla :<C-u>tabnew ~/.zshalias.local<CR>

nnoremap <Space>e :e ++enc=utf-8<CR> :set encoding=utf-8<CR> :w<CR>

nnoremap <Space>] <C-w>]


" for command line
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" for perl
inoremap <C-d> $
inoremap <C-a> @
inoremap <C-p> <C-x><C-o>

" for others
vnoremap < <gv
vnoremap > >gv


" expand path
cmap <C-x> <C-r>=expand('%:p:h')<CR>/
" expand file (not ext)
cmap <C-z> <C-r>=expand('%:p:r')<CR>

" ascii
nnoremap <Leader>a <Esc>:ascii<CR>

" add \n
nnoremap U :<C-u>call append(expand('.'), '')<Cr>j

" replace Y
nnoremap Y y$

"yank and paste clipboard
if !has('gui')
  nnoremap <silent> <Space>y :.w !pbcopy<CR><CR>
  vnoremap <silent> <Space>y :w !pbcopy<CR><CR>
  nnoremap <silent> <Space>p :r !pbpaste<CR>
  vnoremap <silent> <Space>p :r !pbpaste<CR>
else
  " GVim(Mac & Win)
  noremap <Space>y "+y<CR>
  noremap <Space>p "+p<CR>
endif

"repeat command
nnoremap c. q:k<Cr>

"no search offset
cnoremap <expr> /  getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ?  getcmdtype() == '?' ? '\?' : '?'

"substitute word under cursor
nnoremap <expr> s* ':%substitute/\<' . expand('<cword>') . '\>/'

"replace word under cursor with yanked string
nnoremap <silent> ciy ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
nnoremap <silent> cy   ce<C-r>0<ESC>:let@/=@1<CR>:noh<CR>

"tabnew with gf
nnoremap gf <C-w>gf

"for Align
let g:Align_xstrlen=3
vnoremap aa :<BS><BS><BS><BS><BS>'<,'>Align
vnoremap ae :<BS><BS><BS><BS><BS>'<,'>Align=<CR>
vnoremap ac :<BS><BS><BS><BS><BS>'<,'>Align:<CR>
vnoremap af :<BS><BS><BS><BS><BS>'<,'>Align=><CR>
vnoremap aq :<BS><BS><BS><BS><BS>'<,'>Align?<CR>


"---------------------------------------------------------------------
" templates
"---------------------------------------------------------------------
augroup templatelaod
    autocmd!
    autocmd BufNewFile *.html 0r ~/.vim/skeleton/skel.html
    autocmd BufNewFile *.page 0r ~/.vim/skeleton/skel.page
    autocmd BufNewFile *.pl 0r ~/.vim/skeleton/skel.pl
    autocmd BufNewFile *.t 0r ~/.vim/skeleton/skel.t
augroup END

"---------------------------------------------------------------------
" Key mappings for vim windows
"---------------------------------------------------------------------
nnoremap sj <C-W>j
nnoremap sk <C-W>k
nnoremap sh <C-W>h
nnoremap sl <C-W>l
nnoremap so <C-W>o
nnoremap ss <C-W>s
nnoremap sc <C-W>c
nnoremap so <C-W>o

nnoremap + <C-W>+
nnoremap - <C-W>-

nnoremap ) <C-W>>
nnoremap ( <C-W><LT>

function! s:big()
  wincmd _ | wincmd |
endfunction
nnoremap <silent> s<CR> :<C-u>call <SID>big()<CR>
nnoremap s0 1<C-W>_
nnoremap s. <C-W>=


"---------------------------------------------------------------------
" settings for filetypes
"---------------------------------------------------------------------
autocmd BufNewFile,BufRead *.scala set filetype=scala
autocmd BufNewFile,BufRead *.tt set filetype=html
autocmd BufNewFile,BufRead *.mt set filetype=html
autocmd BufNewFile,BufRead *.tx set filetype=html
autocmd BufNewFile,BufRead *.page set filetype=markdown
autocmd BufNewFile,BufRead *.m set filetype=objc


"---------------------------------------------------------------------
" settings for tabs
"---------------------------------------------------------------------
map <C-h> :tabp<CR>
map <C-l> :tabn<CR>

set showtabline=2
set tabline=%!MakeTabLine()

function! MakeTabLine()
    let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
    let tabpages = join(titles) . ' ' . '%#TabLineFill#%T'
    let info = fnamemodify(getcwd(), ":~") . ' '
    return tabpages . '%=' . info
endfunction

function! s:tabpage_label(n)
    let bufnrs = tabpagebuflist(a:n)

    let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

    let no = len(bufnrs)
    if no is 1
        let no = ''
    endif

    let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '+' : ''
    let sp = (no . mod) ==# '' ? '' : ' '

    let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]
    let fname = pathshorten(bufname(curbufnr))

    let label = ' ' . no . mod . sp . fname

    return '%' . a:n . 'T' . hi . label
endfunction


hi TabLine term=reverse cterm=reverse ctermfg=white ctermbg=black
hi TabLineSel term=bold cterm=bold,underline ctermfg=6
hi TabLineFill term=reverse cterm=reverse ctermfg=white ctermbg=black 


"---------------------------------------------------------------------
" for quickhl
"---------------------------------------------------------------------

let b:surround_123 = "+{ \r }"

nmap <Space>m <Plug>(quickhl-toggle)
xmap <Space>m <Plug>(quickhl-toggle)
nmap <Space>M <Plug>(quickhl-reset)
xmap <Space>M <Plug>(quickhl-reset)


"---------------------------------------------------------------------
" for surround.vim
"---------------------------------------------------------------------
nmap <Leader>q <Plug>Csurround w'
imap <Leader>q <Esc><Plug>Csurround w"<Right>wa
nmap <Leader>Q <Plug>Csurround w"
imap <Leader>Q <Esc><Plug>Csurround w'<Right>wa

nmap <Leader>t <Plug>Yssurround t
imap <Leader>t <Esc><Plug>Yssurround t
nmap <Leader>wt <Plug>Csurround wt
imap <Leader>wt <Esc><Plug>Csurround wt


"---------------------------------------------------------------------
" for neocomplcache.vim
"---------------------------------------------------------------------

" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

let g:neocomplcache_ctags_arguments_list = {
  \ 'perl' : '-R -h ".pm"'
  \ }

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'perl' : $HOME . '/.vim/dict/perl.dict',
    \ 'javascript' : $HOME . '/.vim/dict/javascript.dict',
    \ 'html' : $HOME . '/.vim/dict/javascript.dict',
    \ 'scala' : $HOME . '/.vim/dict/scala.dict'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" for snippets
imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-k>"
smap <C-k> <Plug>(neocomplcache_snippets_expand)
let g:neocomplcache_snippets_dir = "~/.vim/snippets"

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> pumvisible() ? neocomplcache#close_popup()."\<C-h>" : "\<C-h>"
inoremap <expr><BS> pumvisible() ? neocomplcache#close_popup()."\<C-h>" : "\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1
inoremap <expr><C-h> pumvisible() ? neocomplcache#cancel_popup()."\<C-h>" : "\<C-h>"
inoremap <expr><BS> pumvisible() ? neocomplcache#cancel_popup()."\<C-h>" : "\<C-h>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
	let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete


"---------------------------------------------------------------------
" Save fold settings.
"---------------------------------------------------------------------
autocmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile' | mkview | endif
autocmd BufRead * if expand('%') != '' && &buftype !~ 'nofile' | silent loadview | endif
" Don't save options.
set viewoptions-=options


"---------------------------------------------------------------------
" for unite.vim
"---------------------------------------------------------------------
nnoremap <silent> <Space>uu :Unite file file/new<CR>
nnoremap <silent> <Space>ur :Unite -buffer-name=files file_rec file/new<CR>
nnoremap <silent> <Space>uf :Unite -buffer-name=file file_mru file/new<CR>

nnoremap <silent> <Space>uc :UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> <Space>ut :Unite tag<CR>
nnoremap <silent> <Space>uy :Unite register<CR>
nnoremap <silent> <Space>ua :UniteBookmarkAdd<CR>
nnoremap <silent> <Space>ub :Unite bookmark<CR>
nnoremap <silent> <Space>uo :Unite outline<CR>
nnoremap <silent> <Space>up :Unite -start-insert ref/perldoc<CR>
nnoremap <silent> <Space>um :Unite -start-insert ref/man<CR>
nnoremap <silent> <Space>ui :Unite -buffer-name=files file_include<CR>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  nnoremap <silent><buffer> <C-o> :call unite#mappings#do_action('tabopen')<CR>
  nnoremap <silent><buffer> <C-v> :call unite#mappings#do_action('vsplit')<CR>
  inoremap <silent><buffer> <C-o> <Esc>:call unite#mappings#do_action('tabopen')<CR>

  call unite#set_substitute_pattern('file', '[^~.]\zs/', '*/*', 20)
  call unite#set_substitute_pattern('file', '/\ze[^*]', '/*', 10)

  call unite#set_substitute_pattern('file', '^@@', '\=fnamemodify(expand("#"), ":p:h")."/*"', 2)
  call unite#set_substitute_pattern('file', '^@', '\=getcwd()."/*"', 1)
  call unite#set_substitute_pattern('file', '^\\', '~/*')

  call unite#set_substitute_pattern('file', '\*\*\+', '*', -1)

  call unite#set_substitute_pattern('file', '\\\@<! ', '\\ ', -20)
  call unite#set_substitute_pattern('file', '\\ \@!', '/', -30)
  let g:unite_enable_ignore_case = 1
  let g:unite_enable_smart_case = 1
endfunction"}}}


if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
