scriptencoding utf-8

if g:spacevim.speed_up_via_timer
  call timer_start(500, 'spacevim#defer#defaults')
endif

" Smarter cursorline {
augroup spacevimCursorline
  autocmd!
  autocmd InsertLeave,WinEnter * if &ft !=# 'clap_input' | set cursorline | endif
  autocmd InsertEnter,WinLeave * set nocursorline
augroup END
" }

" https://github.com/vim/vim/pull/2198
" incsearch.vim {
if has('patch-8.0.1238')
  map n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)
  map N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)
else
  if !g:spacevim.nvim
    " incsearch.vim has bug with GUI vim
    if !g:spacevim.gui
      map /  <Plug>(incsearch-forward)
      map ?  <Plug>(incsearch-backward)
      map g/ <Plug>(incsearch-stay)

      map z/ <Plug>(incsearch-fuzzyspell-/)
      map z? <Plug>(incsearch-fuzzyspell-?)
      map zg/ <Plug>(incsearch-fuzzyspell-stay)
    endif
  endif
endif
" }

" vim-choosewin {
let g:choosewin_overlay_enable = 1
" }

" vim-startify {
if get(g:, 'spacevim_enable_startify', 1)
  function! s:LoadStartifyIfNoArgs() abort
    if !argc() && v:progname =~# 'vim$' && !dein#is_sourced('vim-startify')
      call dein#source('vim-startify')
    endif
  endfunction

  augroup spacevimStart
    autocmd!
    autocmd VimEnter * call s:LoadStartifyIfNoArgs()
  augroup END
endif
" }

execute 'source' fnamemodify(expand('<sfile>'), ':h') . '/keybindings.vim'
