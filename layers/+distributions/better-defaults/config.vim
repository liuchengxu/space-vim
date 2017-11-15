scriptencoding utf-8

" Smarter cursorline {
augroup spacevimCursorline
  autocmd!
  autocmd InsertLeave,WinEnter * set cursorline
  autocmd InsertEnter,WinLeave * set nocursorline
augroup END
" }

" From tpope
if g:spacevim_gui
  command! Bigger  :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')
  command! Smaller :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)-1', '')
  noremap + :Bigger<CR>
  noremap - :Smaller<CR>
endif

" https://github.com/vim/vim/pull/2198
" incsearch.vim {
if has('patch-8.0.1238')
  map n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)
  map N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)
else
  if !g:spacevim_nvim
    " incsearch.vim has bug with GUI vim
    if !g:spacevim_gui
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

" vim-startify {
let s:version = g:spacevim_nvim ? 'nvim '.spacevim#util#GetNvimVersion() : 'vim '.v:version
let g:startify_custom_header = [
            \'                                             _',
            \'         ___ _ __   __ _  ___ ___     __   _(_)_ __ ___',
            \'        / __| -_ \ / _- |/ __/ _ \____\ \ / / | -_ - _ \',
            \'        \__ \ |_) | (_| | (_|  __/_____\ V /| | | | | | |',
            \'        |___/ .__/ \__._|\___\___|      \_/ |_|_| |_| |_|',
            \'            |_|',
            \'                  [ space-vim ' . g:spacevim_version . ' ＠' . s:version . ' ]',
            \]

let g:startify_list_order = [
            \ ['   Recent Files:'],
            \ 'files',
            \ ['   Project:'],
            \ 'dir',
            \ ['   Sessions:'],
            \ 'sessions',
            \ ['   Bookmarks:'],
            \ 'bookmarks',
            \ ['   Commands:'],
            \ 'commands',
            \ ]

let g:startify_change_to_vcs_root = 1
" }

" vim-choosewin {
let g:choosewin_overlay_enable = 1
" }

execute 'source' fnamemodify(expand('<sfile>'), ':h') . '/keybindings.vim'
