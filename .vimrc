"---------------------------------------------------------------------
" base settings
"---------------------------------------------------------------------
colorscheme pablo
set title
set ruler

syntax on
filetype plugin indent on

call pathogen#runtime_append_all_bundles()

set nocompatible
set number
set hidden

set autoread

set splitbelow
set splitright

set autoindent
set smartindent

set hlsearch
set nowrapscan
set showmatch
set showmode

set tabstop=2
set shiftwidth=2
set expandtab
set smarttab

set whichwrap=b,s,h,l,<,>,[,]
set backspace=indent,eol,start
set clipboard=unnamed
set browsedir=buffer

set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set showcmd

set wildmode=list,full

set virtualedit+=block
set clipboard+=autoselect,unnamed

set modeline

if exists('&ambiwidth')
  set ambiwidth=double
endif

"swp files
set directory-=.

"show special character
set list
set lcs=tab:>-,trail:_,extends:>,precedes:<
scriptencoding utf-8
highlight JpSpace cterm=underline ctermfg=Green guifg=Green
au BufRead,BufNew * match JpSpace /　/

" remove autocomment
autocmd FileType * set formatoptions-=ro

" for psgi
autocmd BufNewFile,BufRead *.psgi set filetype=perl

"---------------------------------------------------------------------
" Key mappings
"---------------------------------------------------------------------

" mapleader
let mapleader = ","

" for scratch
nnoremap <Leader>s :Scratch<CR>

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
nnoremap co zo
nnoremap cc zc

vnoremap < <gv
vnoremap > >gv


" expand path
cmap <C-x> <C-r>=expand('%:p:h')<CR>/
" expand file (not ext)
cmap <C-z> <C-r>=expand('%:p:r')<CR>

" for alc
nnoremap <Leader>a <Esc>:Ref alc<Space>

" for perldoc
nnoremap <Leader>p <Esc>:Perldoc<Space>

" add \n
nnoremap U :<C-u>call append(expand('.'), '')<Cr>j

" replace Y
nnoremap Y y$

"yank and paste clipboard
"if has('mac') && !has('gui')
  "nnoremap <silent> <Space>y :.w !pbcopy<CR><CR>
  "vnoremap <silent> <Space>y :w !pbcopy<CR><CR>
  "nnoremap <silent> <Space>p :r !pbpaste<CR>
  "vnoremap <silent> <Space>p :r !pbpaste<CR>
"else
  " GVim(Mac & Win)
  noremap <Space>y "+y<CR>
  noremap <Space>p "+p<CR>
"endif

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


"---------------------------------------------------------------------
" settings for tabs
"---------------------------------------------------------------------
map <C-h> :tabp<CR>
map <C-l> :tabn<CR>

set showtabline=2

hi TabLine term=reverse cterm=reverse ctermfg=white ctermbg=black
hi TabLineSel term=bold cterm=bold,underline ctermfg=6
hi TabLineFill term=reverse cterm=reverse ctermfg=white ctermbg=black 


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

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
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
" home directory with \
"---------------------------------------------------------------------
function! HomedirOrBackslash()
  if getcmdtype() == ':' && (getcmdline() =~# '^e ' || getcmdline() =~? '^r\?!' || getcmdline() =~? '^cd ' || getcmdline() =~? '^tabnew ' || getcmdline() =~? '^source ')
    return '~/'
  else
    return '\'
  endif
endfunction
cnoremap <expr> <Bslash> HomedirOrBackslash()


"---------------------------------------------------------------------
" Save fold settings.
"---------------------------------------------------------------------
autocmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile' | mkview | endif
autocmd BufRead * if expand('%') != '' && &buftype !~ 'nofile' | silent loadview | endif
" Don't save options.
set viewoptions-=options


"---------------------------------------------------------------------
" for ack.vim
"---------------------------------------------------------------------
nnoremap <Space>c :Ack<Space>


"---------------------------------------------------------------------
" for unite.vim
"---------------------------------------------------------------------
nnoremap <silent> <Space>uu :Unite -buffer-name=files file<CR>
nnoremap <silent> <Space>uf :Unite -buffer-name=file file_mru<CR>
nnoremap <silent> <Space>ur :Unite file_rec<CR>
nnoremap <silent> <Space>uc :UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <Space>ut :Unite tab<CR>
nnoremap <silent> <Space>uy :Unite register<CR>
nnoremap <silent> <Space>ua :UniteBookmarkAdd<CR>
nnoremap <silent> <Space>ub :Unite bookmark<CR>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  nnoremap <silent><buffer> <C-o> :call unite#mappings#do_action('tabopen')<CR>
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


"---------------------------------------------------------------------
" detect char code
"---------------------------------------------------------------------
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
	let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  unlet s:enc_euc
  unlet s:enc_jis
endif
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif


let readfile = "~/.vimrc.local"
if filereadable(readfile)
  source ~/.vimrc.local
endif
