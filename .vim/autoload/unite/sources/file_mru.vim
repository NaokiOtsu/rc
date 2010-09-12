"=============================================================================
" FILE: file_mru.vim
" AUTHOR:  Shougo Matsushita <Shougo.Matsu@gmail.com>
" Last Modified: 10 Sep 2010
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
"=============================================================================

" Variables  "{{{
" The version of MRU file format.
let s:VERSION = '0.2.0'

" [ { 'path' : full_path, 'time' : localtime()}, ... ]
let s:mru_files = []

let s:mru_file_mtime = 0  " the last modified time of the mru file.

call unite#set_default('g:unite_source_file_mru_time_format', '(%x %H:%M:%S)')
call unite#set_default('g:unite_source_file_mru_file',  g:unite_temporary_directory . '/.file_mru')
call unite#set_default('g:unite_source_file_mru_limit', 100)
call unite#set_default('g:unite_source_file_mru_ignore_pattern', '')
"}}}

function! unite#sources#file_mru#define()"{{{
  return s:source
endfunction"}}}
function! unite#sources#file_mru#_append()"{{{
  " Append the current buffer to the mru list.
  let l:path = substitute(expand('%:p'), '\\', '/', 'g')
  if !s:is_exists_path(path) || &l:buftype =~ 'help'
  \   || (g:unite_source_file_mru_ignore_pattern != ''
  \      && l:path =~# g:unite_source_file_mru_ignore_pattern)
    return
  endif

  call s:load()
  call insert(filter(s:mru_files, 'v:val[0] !=# path'),
  \           [path, localtime()])
  if 0 < g:unite_source_file_mru_limit
    unlet s:mru_files[g:unite_source_file_mru_limit]
  endif
  call s:save()
endfunction"}}}
function! unite#sources#file_mru#_sweep()  "{{{
  call filter(s:mru_files, 's:is_exists_path(v:val[0])')
  call s:save()
endfunction"}}}

let s:source = {
      \ 'name' : 'file_mru',
      \ 'max_candidates': 30,
      \}

function! s:source.gather_candidates(args)"{{{
  call s:load()
  return sort(map(copy(s:mru_files), '{
        \ "abbr" : strftime(g:unite_source_file_mru_time_format, v:val[1]) .
        \          fnamemodify(v:val[0], ":~:."),
        \ "word" : v:val[0],
        \ "source" : "file_mru",
        \ "unite_file_mru_time" : v:val[1],
        \ "kind" : (isdirectory(v:val[0]) ? "directory" : "file"),
        \   }'), 's:compare')
endfunction"}}}

" Misc
function! s:compare(candidate_a, candidate_b)"{{{
  return a:candidate_b['unite_file_mru_time'] - a:candidate_a['unite_file_mru_time']
endfunction"}}}
function! s:save()  "{{{
  call writefile([s:VERSION] + map(copy(s:mru_files), 'join(v:val, "\t")'),
  \              g:unite_source_file_mru_file)
  let s:mru_file_mtime = getftime(g:unite_source_file_mru_file)
endfunction"}}}
function! s:load()  "{{{
  if filereadable(g:unite_source_file_mru_file)
  \  && s:mru_file_mtime != getftime(g:unite_source_file_mru_file)
    let [ver; s:mru_files] = readfile(g:unite_source_file_mru_file)
    if ver !=# s:VERSION
      echohl WarningMsg
      echomsg 'Sorry, the version of MRU file is old.  Clears the MRU list.'
      echohl None
      let s:mru_files = []
      return
    endif
    let s:mru_files =
    \   filter(map(s:mru_files[0 : g:unite_source_file_mru_limit - 1],
    \              'split(v:val, "\t")'), 's:is_exists_path(v:val[0])')
    let s:mru_file_mtime = getftime(g:unite_source_file_mru_file)
  endif
endfunction"}}}
function! s:is_exists_path(path)  "{{{
  return isdirectory(a:path) || filereadable(a:path)
endfunction"}}}


" vim: foldmethod=marker
