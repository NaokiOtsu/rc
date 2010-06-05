"---------------------------------------------------------------------
" 基本設定
"---------------------------------------------------------------------
colorscheme pablo
set title
set ruler

syntax on
filetype on
filetype plugin on
filetype indent on


"オートインデント
set autoindent

"swp files
set directory-=.

"行番号を表示する
set number

"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch

"モードを表示
set showmode

"タブ文字の大きさ
set tabstop=2
set shiftwidth=2
set expandtab

"行末・タブ文字等の表示
set list
set lcs=tab:>.,eol:$,trail:_,extends:\

"全角スペース表示
highlight JpSpace cterm=underline ctermfg=Green guifg=Green
au BufRead,BufNew * match JpSpace /　/

"バックスペースでindentを無視 & 改行を越えてバックスペースを許可
set backspace=indent,eol

"共有のクリップボードを使用する
set clipboard=unnamed

"ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
set browsedir=buffer 

"Vi互換をオフ
set nocompatible

"変更中のファイルでも、保存しないで他のファイルを表示
set hidden

"検索時に大文字を含んでいたら大/小を区別
set ignorecase
set smartcase

"新しい行を作ったときに高度な自動インデントを行う
set smartindent

"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab

"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

"検索をファイルの先頭へループしない
set nowrapscan

"検索のハイライト
set hlsearch

"ステータスラインを常に表示
set laststatus=2

"ステータスラインに文字コードと改行文字を表示
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"ステータスラインに入力中コマンドを表示
set showcmd

"コマンドライン補完
set wildmode=list,full

" 四角とか丸があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

" 矩形選択補助
set virtualedit+=block

" 改行時のオートコメント解除
autocmd FileType * set formatoptions-=ro

" rename command
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

" mapleader
let g:mapleader = ","


"---------------------------------------------------------------------
" Key mappings
"---------------------------------------------------------------------
" expand path
cmap <C-x> <C-r>=expand('%:p:h')<CR>/
" expand file (not ext)
cmap <C-z> <C-r>=expand('%:p:r')<CR>

" emacs-like command line
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" for alc
inoremap <Leader>a <Esc>:Ref alc<Space>
nnoremap <Leader>a <Esc>:Ref alc<Space>

"改行挿入
nnoremap U :<C-u>call append(expand('.'), '')<Cr>j

"Yの修正
nnoremap Y y$

"クリップボードのyank, paste
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

"caps with C-a
imap <C-a> <C-O><Plug>CapsLockToggle


"---------------------------------------------------------------------
" Key mappings for Perl
"---------------------------------------------------------------------
inoremap <C-d> $
inoremap <C-p> %


"---------------------------------------------------------------------
" Key mappings for windows
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

" ウィンドウの横幅を大きくする/小さくする
nnoremap ) <C-W>> 
nnoremap ( <C-W><LT>

" ウィンドウの大きさを最大化する
function! s:big()
  wincmd _ | wincmd |
endfunction
nnoremap <silent> s<CR> :<C-u>call <SID>big()<CR> " 最大化
nnoremap s0 1<C-W>_ " 最小化
nnoremap s. <C-W>=  " 全部同じ大きさにする


"---------------------------------------------------------------------
" ファイル毎の設定
"---------------------------------------------------------------------
autocmd FileType html,xml,xsl,erb source ~/.vim/plugin/closetag.vim 

"ファイル種別毎の辞書ファイル
autocmd FileType javascript :set dictionary=~/.vim/dic/js.dic
autocmd FileType scala :set dictionary=~/.vim/dic/scala.dic

"スケルトンファイル
autocmd BufNewFile *.user.js 0r ~/.vim/skeleton/greasemonkey.js

"シンタックスハイライトを補完に利用
autocmd FileType *
      \   if &l:omnifunc == ''
      \ |   setlocal omnifunc=syntaxcomplete#Complete
      \ | endif


"---------------------------------------------------------------------
" tab回りの設定
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

" Don't use autocomplpop.
let g:AutoComplPop_NotEnableAtStartup = 1
" Use neocomplcache.
let g:NeoComplCache_EnableAtStartup = 1
" Use smartcase.
let g:NeoComplCache_SmartCase = 1
" Use previous keyword completion.
let g:NeoComplCache_PreviousKeywordCompletion = 1
" Use preview window.
let g:NeoComplCache_EnableInfo = 1
" Use camel case completion.
let g:NeoComplCache_EnableCamelCaseCompletion = 1
" Use underbar completion.
let g:NeoComplCache_EnableUnderbarCompletion = 1
" Set minimum syntax keyword length.
let g:NeoComplCache_MinSyntaxLength = 3
" Set skip input time.
let g:NeoComplCache_SkipInputTime = '0.1'

" Define dictionary.
let g:NeoComplCache_DictionaryFileTypeLists = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

" Define keyword.
if !exists('g:NeoComplCache_KeywordPatterns')
    let g:NeoComplCache_KeywordPatterns = {}
endif
let g:NeoComplCache_KeywordPatterns['default'] = '\v\h\w*'

" Plugin key-mappings.
nmap <silent><C-e>     <Plug>(neocomplcache_keyword_caching)
imap <expr><silent><C-e>     pumvisible() ? "\<C-e>" : "\<Plug>(neocomplcache_keyword_caching)"

" <TAB> completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" C-jでオムニ補完
inoremap <expr> <C-j> &filetype == 'vim' ? "\<C-x>\<C-v>\<C-p>" : "\<C-x>\<C-o>\<C-p>"
" C-kを押すと行末まで削除
inoremap <C-k> <C-o>D
" C-nでneocomplcache補完
inoremap <expr><C-n> pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"
" C-pでkeyword補完
inoremap <expr><C-p> pumvisible() ? "\<C-p>" : "\<C-p>\<C-n>"
" 途中でEnterしたとき、ポップアップを消して改行し、
" 改行を連続して入力してもインデント部を保持する
inoremap <expr><CR> pumvisible() ? "\<C-y>\<CR>X\<BS>" : "\<CR>X\<BS>"


"---------------------------------------------------------------------
" for git-vim.vim
"---------------------------------------------------------------------
let g:git_no_map_default = 1
let g:git_command_edit = 'rightbelow vnew'
nnoremap <Space>gd :<C-u>GitDiff --cached<Enter>
nnoremap <Space>gD :<C-u>GitDiff<Enter>
nnoremap <Space>gs :<C-u>GitStatus<Enter>
nnoremap <Space>gl :<C-u>GitLog<Enter>
nnoremap <Space>gL :<C-u>GitLog -u \| head -10000<Enter>
nnoremap <Space>ga :<C-u>GitAdd<Enter>
nnoremap <Space>gA :<C-u>GitAdd <cfile><Enter>
nnoremap <Space>gc :<C-u>GitCommit<Enter>
nnoremap <Space>gC :<C-u>GitCommit --amend<Enter>
nnoremap <Space>gp :<C-u>Git push


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
" 文字コードの自動認識
"---------------------------------------------------------------------

if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
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
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
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
