scriptencoding utf-8

" Put the :hi command after any :colorscheme command,
" or the colorscheme can overwrite your highlighting.
silent! color space-vim-dark

augroup spacevimBasic
  autocmd!
  " https://vi.stackexchange.com/questions/298/disable-syntax-highlighting-depending-on-file-size-and-type#comment291_299
  " `syntax off` works in the `BufReadPre` context but not in the `Filetype` context;
  " while `setlocal syntax=OFF` does not work in the `BufReadPre` context but works in the `Filetype` context.
  autocmd FileType xml,json,text
        \ if getfsize(expand("%")) > 10000000
        \|  setlocal syntax=off
        \|endif

  " Restore cursor position when opening file
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$")
        \|  execute "normal! g`\""
        \|endif

  autocmd BufReadPost *
        \ if line('$') > 1000
        \|  silent! set norelativenumber
        \|endif

  " http://vim.wikia.com/wiki/Speed_up_Syntax_Highlighting
  autocmd BufEnter * :syntax sync maxlines=200

  " Open quickfix window automatically when something is feeded
  autocmd QuickFixCmdPost *
        \ if !len(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"')) && len(getqflist())
        \| copen 8
        \|endif

  " Close vim if the last edit buffer is closed, i.e., close NERDTree,
  " undotree, quickfix etc automatically.
  " autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif
  " Bug here. See #269.
  " =====================================
  autocmd BufEnter * call MyLastWindow()
  function! MyLastWindow()
    " if the window is quickfix/locationlist
    let l:bt_blacklist = ['quickfix', 'locationlist']
    let l:ft_blocklist = ['quickmenu']
    " if this window is last on screen quit without warning
    if winnr('$') == 1 && (index(l:bt_blacklist, &buftype) >= 0 || index(l:ft_blocklist, &filetype) >= 0)
      quit!
    endif
    " Sometimes when the last window is nerdtree with another buffer exists,
    " vim will close automatically. See #283
    " To reproduce:
    " 1. vim foo.txt
    " 2. NERDTreeFind
    " 3. :bd
    " that's due to winnr('$) = 1, so diable it for now until a better
    " solution is found.
    " if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q! | endif
  endfunction

  " http://vim.wikia.com/wiki/Always_start_on_first_line_of_git_commit_message
  autocmd BufEnter * if &filetype == "gitcommit" | call setpos('.', [0, 1, 1, 0]) | endif

  " http://stackoverflow.com/questions/5933568/disable-blinking-at-the-first-last-line-of-the-file
  autocmd GUIEnter * set t_vb=

  if g:spacevim.gui
    let g:screen_size_restore_pos = get(g:, 'screen_size_restore_pos', 1)
    let g:screen_size_by_vim_instance = get(g:, 'screen_size_by_vim_instance', 1)
    autocmd VimEnter * if g:screen_size_restore_pos == 1 | call spacevim#vim#gui#ScreenRestore() | endif
    autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call spacevim#vim#gui#ScreenSave() | endif
  endif

  if !spacevim#load('chinese')
    silent! set $LANG = 'en_US'
    silent! let langmenu=en_US
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    if g:spacevim.os.windows
      set guifont=Consolas:h13
    endif
  endif
augroup END

" Show trailing white space
hi ExtraWhitespace guifg=#FF2626 gui=underline ctermfg=124 cterm=underline
match ExtraWhitespace /\s\+$/

" Refer to http://vim.wikia.com/wiki/Show_tab_number_in_your_tab_line
if g:spacevim.gui
  set guioptions-=e
endif
silent! set showtabline=1
silent! set tabline=%!spacevim#vim#tab#TabLine()
