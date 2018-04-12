let g:spacevim#plug#youcompleteme#disgnostics = spacevim#load('syntax-checking') ? 0 : 1

" https://github.com/Valloric/YouCompleteMe/issues/2875#issuecomment-358193287
" automatically trigger semantic completion after typing 2 character in files
let g:spacevim#plug#youcompleteme#triggers = {
      \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
      \ 'cs,lua,javascript,rust': ['re!\w{2}'],
      \ }
let g:spacevim#plug#youcompleteme#blacklist = {
              \ 'tagbar' : 1,
              \ 'nerdtree' : 1,
              \ 'markdown' : 1,
              \ 'unite' : 1,
              \ 'text' : 1,
              \ 'csv' : 1,
              \}

function! spacevim#plug#youcompleteme#build(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status ==# 'installed' || a:info.force
    !./install.py --clang-completer
  endif
endfunction

" Load YCM for specific filetypes
" https://github.com/Valloric/YouCompleteMe#intro
function! s:load_ycm()
  let l:supported = [
        \ 'c', 'cpp',
        \ 'python',
        \ 'javascript', 'javascript.jsx',
        \ 'go',
        \ 'rust',
        \ 'ruby', 'vim', 'sh',
        \ ]
  let l:cur_ft = &filetype
  if index(l:supported, l:cur_ft) > -1
    call plug#load('YouCompleteMe')
  endif
endfunction

function! spacevim#plug#youcompleteme#invoke(timer) abort
  if !exists('g:loaded_youcompleteme')
    call plug#load('YouCompleteMe')
  endif
endfunction

function! spacevim#plug#youcompleteme#load() abort
  if !exists('g:loaded_youcompleteme')
    call s:load_ycm()
  endif
endfunction
