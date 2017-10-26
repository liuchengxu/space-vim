scriptencoding utf-8

" Put the :hi command after any :colorscheme command,
" or the colorscheme can overwrite your highlighting.
silent! color space-vim-dark

augroup spacevimBasic
  autocmd!
  autocmd BufReadPre *
        \ if getfsize(expand("%")) > 10000000
        \|  syntax off
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

  autocmd BufEnter * call MyLastWindow()
  function! MyLastWindow()
    " if the window is quickfix/locationlist
    let l:blacklist = ['quickfix', 'locationlist']
    if index(l:blacklist, &buftype) >= 0
      " if this window is last on screen quit without warning
      if winbufnr(2) == -1
        quit!
      endif
    endif
  endfunction
  " http://stackoverflow.com/questions/5933568/disable-blinking-at-the-first-last-line-of-the-file
  autocmd GUIEnter * set t_vb=

  if g:spacevim_gui
    let g:screen_size_restore_pos = get(g:, 'screen_size_restore_pos', 1)
    let g:screen_size_by_vim_instance = get(g:, 'screen_size_by_vim_instance', 1)
    autocmd VimEnter * if g:screen_size_restore_pos == 1 | call spacevim#gui#ScreenRestore() | endif
    autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call spacevim#gui#ScreenSave() | endif
  endif

  if !spacevim#LayerLoaded('chinese')
    silent! set $LANG = 'en_US'
    silent! let langmenu=en_US
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    if g:WINDOWS
      set guifont=Consolas:h13
    endif
  endif
augroup END

" Show trailing white space
hi ExtraWhitespace guifg=#FF2626 gui=underline ctermfg=124 cterm=underline
match ExtraWhitespace /\s\+$/

" Refer to http://vim.wikia.com/wiki/Show_tab_number_in_your_tab_line
if g:spacevim_gui
  set guioptions-=e
endif
function! MyTabLine()
  let l:s = ''
  let l:t = tabpagenr()
  let l:i = 1
  while l:i <= tabpagenr('$')
    let l:buflist = tabpagebuflist(l:i)
    let l:winnr = tabpagewinnr(l:i)
    let l:s .= '%' . l:i . 'T'
    let l:s .= (l:i == l:t ? '%1*' : '%2*')
    let l:s .= ' '
    " Remove the complicated information
    " let l:s .= 'T-' . l:i . ':'
    " let l:s .= l:winnr . '/' . tabpagewinnr(l:i,'$') .'W'
    let l:s .= l:i
    let l:s .= ' %*'
    let l:s .= (l:i == l:t ? '%#TabLineSel#' : '%#TabLine#')
    let l:bufnr = l:buflist[l:winnr - 1]
    let l:file = bufname(l:bufnr)
    let l:buftype = getbufvar(l:bufnr, 'buftype')
    if l:buftype ==# 'nofile'
      if l:file =~# '\/.'
        let l:file = substitute(l:file, '.*\/\ze.', '', '')
      endif
    else
      let l:file = fnamemodify(l:file, ':p:t')
    endif
    if l:file ==# ''
      let l:file = '[No Name]'
    endif
    let l:s .= ' '.l:file.' '
    let l:i = l:i + 1
  endwhile
  let l:s .= '%T%#TabLineFill#%='
  let l:s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
  return l:s
endfunction
silent! set showtabline=1
silent! set tabline=%!MyTabLine()
