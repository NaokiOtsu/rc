"=============================================================================
" FILE: unite.vim
" AUTHOR:  Shougo Matsushita <Shougo.Matsu@gmail.com>
" Last Modified: 15 Sep 2010
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
" Version: 0.5, for Vim 7.0
"=============================================================================

if exists('g:loaded_unite')
  finish
endif

" Global options definition."{{{
if !exists('g:unite_update_time')
  let g:unite_update_time = 200
endif
if !exists('g:unite_enable_start_insert')
  let g:unite_enable_start_insert = 0
endif
if !exists('g:unite_enable_ignore_case')
  let g:unite_enable_ignore_case = &ignorecase
endif
if !exists('g:unite_enable_smart_case')
  let g:unite_enable_smart_case = &infercase
endif
if !exists('g:unite_split_rule')
  let g:unite_split_rule = 'topleft'
endif
if !exists('g:unite_enable_split_vertically')
  let g:unite_enable_split_vertically = 0
endif
if !exists('g:unite_substitute_patterns')
  let g:unite_substitute_patterns = {}
endif
if !exists('g:unite_temporary_directory')
  let g:unite_temporary_directory = expand('~/.unite')
endif
if !isdirectory(fnamemodify(g:unite_temporary_directory, ':p'))
  call mkdir(fnamemodify(g:unite_temporary_directory, ':p'), 'p')
endif
"}}}

" Wrapper command.
command! -nargs=+ -complete=customlist,unite#complete_source Unite call s:call_unite_empty(<q-args>)
function! s:call_unite_empty(args)
  call unite#start(split(a:args))
endfunction

command! -nargs=+ -complete=customlist,unite#complete_source UniteWithCurrentDir call s:call_unite_current_dir(<q-args>)
function! s:call_unite_current_dir(args)
  let l:path = &filetype ==# 'vimfiler' ? b:vimfiler.current_dir : substitute(fnamemodify(getcwd(), ':p'), '\\', '/', 'g')
  call unite#start(split(a:args), { 'input' : l:path.(l:path =~ '[\\/]$' ? '' : '/') })
endfunction

command! -nargs=+ -complete=customlist,unite#complete_source UniteWithBufferDir call s:call_unite_buffer_dir(<q-args>)
function! s:call_unite_buffer_dir(args)
  let l:path = &filetype ==# 'vimfiler' ? b:vimfiler.current_dir : substitute(fnamemodify(bufname('%'), ':p:h'), '\\', '/', 'g')
  call unite#start(split(a:args), { 'input' : l:path.(l:path =~ '[\\/]$' ? '' : '/') })
endfunction

let g:loaded_unite = 1

" __END__
" vim: foldmethod=marker
