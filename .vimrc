"---------------------------------------------------------------------
" base settings
"---------------------------------------------------------------------
colorscheme pablo
set title
set ruler

syntax on
filetype plugin indent on


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

set ignorecase
set smartcase

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

" rename command
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))


"---------------------------------------------------------------------
" Key mappings
"---------------------------------------------------------------------

" mapleader
let mapleader = ","

" for basics
nnoremap <Space>w :<C-u>write<Return>
nnoremap <Space>q :<C-u>quit<Return>
nnoremap <Space>Q :<C-u>quit!<Return>
nnoremap <Space>v :<C-u>tabnew ~/.vimrc<Cr>
nnoremap <Space>s :<C-u>source ~/.vimrc<Cr>
nnoremap <Space>zz :<C-u>tabnew ~/.zshrc<Cr>
nnoremap <Space>za :<C-u>tabnew ~/.zshalias<Cr>
nnoremap <Space>ze :<C-u>tabnew ~/.zshenv<Cr>
nnoremap <Space>] <C-w>]
nnoremap <Space>j <C-f>
nnoremap <Space>k <C-b>

" for command line
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" for perl
inoremap <C-d> $
inoremap <C-a> @
inoremap <C-p> %

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
inoremap <Leader>a <Esc>:Ref alc<Space>
nnoremap <Leader>a <Esc>:Ref alc<Space>

" add \n
nnoremap U :<C-u>call append(expand('.'), '')<Cr>j

" replace Y
nnoremap Y y$

" yank and paste clipboard
noremap <Space>y "+y<CR>
noremap <Space>p "+p<CR>

"repeat command
nnoremap c. q:k<Cr>

"no search offset
cnoremap <expr> /  getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ?  getcmdtype() == '?' ? '\?' : '?'

"replace word under cursor
nnoremap <expr> s* ':%substitute/\<' . expand('<cword>') . '\>/'

"tabnew with gf
nnoremap gf <C-w>gf


"---------------------------------------------------------------------
" Key mappings for vim windows
"---------------------------------------------------------------------
nnoremap ss <C-W>s
nnoremap sc <C-W>c
nnoremap so <C-W>o

nnoremap sj <C-W>j
nnoremap sk <C-W>k
nnoremap sh <C-W>h
nnoremap sl <C-W>l

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
autocmd FileType html,xml,xsl,erb source ~/.vim/plugin/closetag.vim 

autocmd FileType javascript :set dictionary=~/.vim/dic/js.dic
autocmd FileType scala :set dictionary=~/.vim/dic/scala.dic
autocmd BufNewFile,BufRead *.scala set filetype=scala

autocmd BufNewFile *.user.js 0r ~/.vim/skeleton/greasemonkey.js

autocmd FileType *
      \   if &l:omnifunc == ''
      \ |   setlocal omnifunc=syntaxcomplete#Complete
      \ | endif


"---------------------------------------------------------------------
" settings for tabs
"---------------------------------------------------------------------
map <C-h> :tabp<CR>
map <C-l> :tabn<CR>

hi TabLine term=reverse cterm=reverse ctermfg=white ctermbg=black
hi TabLineSel term=bold cterm=bold,underline ctermfg=5
hi TabLineFill term=reverse cterm=reverse ctermfg=white ctermbg=black 


"---------------------------------------------------------------------
" for surround.vim
"---------------------------------------------------------------------
nmap <Leader>q <Plug>Csurround w"
imap <Leader>q <Esc><Plug>Csurround w"<Right>wa
nmap <Leader>sq <Plug>Csurround w'
imap <Leader>sq <Esc><Plug>Csurround w'<Right>wa

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
    \ 'scheme' : $HOME.'/.gosh_completions',
    \ 'javascript' : $HOME.'/.vim/dic/js.dic',
    \ 'perl' : $HOME.'/.vim/perl-suport/wordlists/perl.list'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <expr><CR>  (pumvisible() ? "\<C-y>":'') . "\<C-f>\<CR>X\<BS>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> pumvisible() ? neocomplcache#close_popup()."\<C-h>" : "\<C-h>"
inoremap <expr><BS> pumvisible() ? neocomplcache#close_popup()."\<C-h>" : "\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1
"inoremap <expr><CR>  (pumvisible() ? "\<C-e>":'') . (&indentexpr != '' ? "\<C-f>\<CR>X\<BS>":"\<CR>")
"inoremap <expr><C-h> pumvisible() ? neocomplcache#cancel_popup()."\<C-h>" : "\<C-h>"
"inoremap <expr><BS> pumvisible() ? neocomplcache#cancel_popup()."\<C-h>" : "\<C-h>"


"---------------------------------------------------------------------
" vim-latex
"---------------------------------------------------------------------
set shellslash
set grepprg=grep\ -nH\ $*
let g:Tex_CompileRule_dvi = 'platex --interaction=nonstopmode $*'
let g:Tex_ViewRule_dvi = '/usr/bin/xdvi-ja'


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
" for fuzzyfinder
"---------------------------------------------------------------------
nnoremap <silent> <Space>ff :<C-u>tabnew<CR>:tabmove<CR>:FufFile!<CR>
nnoremap <silent> <Space>fb :<C-u>FufBuffer<Cr>
if !exists('g:FuzzyFinderOptions')
  let g:FuzzyFinderOptions = { 'Base':{}, 'Buffer':{}, 'File':{}, 'Dir':{}, 'MruFile':{}, 'MruCmd':{}, 'Bookmark':{}, 'Tag':{}, 'TaggedFile':{}}
  let g:FuzzyFinderOptions.Base.key_open = '<C-m>'
  let g:FuzzyFinderOptions.Base.key_open_split = '<Space>'
  let g:FuzzyFinderOptions.Base.key_open_vsplit = '<CR>'
endif


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
