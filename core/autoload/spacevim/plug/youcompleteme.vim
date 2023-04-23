function! spacevim#plug#youcompleteme#build() abort
  let args = ['install.py', '--clang-completer']

  call system('go version')
  if !v:shell_error
    call add(args, '--go-completer')
  endif

  call system('rustc --version')
  if !v:shell_error
    call add(args, '--rust-completer')
  endif

  " Prefer python3
  call insert(args, executable('python3') ? '!python3' : '!python')
  call spacevim#vim#plug#post_update('YouCompleteMe', join(args, ' '))
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
    call dein#source('YouCompleteMe')
  endif
endfunction

" Load for supported types when loading via timer
function! spacevim#plug#youcompleteme#invoke(timer) abort
  if !exists('g:loaded_youcompleteme')
    call dein#source('YouCompleteMe')
  endif
endfunction

" Deprecated, use on_event option, load for all types when events are triggered
function! spacevim#plug#youcompleteme#load() abort
  if !exists('g:loaded_youcompleteme')
    call s:load_ycm()
  endif
endfunction
