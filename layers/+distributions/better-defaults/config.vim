scriptencoding utf-8

" incsearch.vim {
  if !g:spacevim_nvim
    " incsearch.vim has bug with GUI vim
    if !g:spacevim_gui_running
      map /  <Plug>(incsearch-forward)
      map ?  <Plug>(incsearch-backward)
      map g/ <Plug>(incsearch-stay)

      map z/ <Plug>(incsearch-fuzzyspell-/)
      map z? <Plug>(incsearch-fuzzyspell-?)
      map zg/ <Plug>(incsearch-fuzzyspell-stay)
    endif
  endif
" }

" vim-startify {
  let g:startify_custom_header = [
              \'                                             _',
              \'         ___ _ __   __ _  ___ ___     __   _(_)_ __ ___',
              \'        / __| -_ \ / _- |/ __/ _ \____\ \ / / | -_ - _ \',
              \'        \__ \ |_) | (_| | (_|  __/_____\ V /| | | | | | |',
              \'        |___/ .__/ \__._|\___\___|      \_/ |_|_| |_| |_|',
              \'            |_|',
              \'                  [ space-vim ' . g:spacevim_version . ' ＠' . v:version . ' ]',
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

execute 'source' fnamemodify(expand('<sfile>'), ':h') . '/keybindings.vim'
