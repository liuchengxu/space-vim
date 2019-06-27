scriptencoding utf-8

function! s:OnBufReadPost() abort
  if !get(g:, 'spacevim_disable_restore_cursor_position_on_open', 0)
    " Restore cursor position when opening file
    if line("'\"") > 1 && line("'\"") <= line("$")
      execute "normal! g`\""
    endif
  endif

  " Disable relative number when having too many lines.
  if line('$') > 1000
    silent! setlocal norelativenumber
  endif
endfunction

function! s:OnBufEnter() abort
  " http://vim.wikia.com/wiki/Speed_up_Syntax_Highlighting
  syntax sync maxlines=200

  " Close vim if the last edit buffer is closed, i.e., close NERDTree,
  " undotree, quickfix etc automatically.
  " autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif
  " Bug here. See #269.
  " =====================================
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

  " http://vim.wikia.com/wiki/Always_start_on_first_line_of_git_commit_message
  if &filetype == "gitcommit"
    call setpos('.', [0, 1, 1, 0])
  endif
endfunction

function! s:OnQuickFixCmdPost() abort
  " Open quickfix window automatically when something is feeded
  if !len(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"')) && len(getqflist())
    copen 8
  endif
endfunction

function! s:TurnOffSyntaxIfTooLarge() abort
  if getfsize(expand("%")) > 10000000
    setlocal syntax=off
  endif
endfunction

" Put the :hi command after any :colorscheme command,
" or the colorscheme can overwrite your highlighting.
try
  color space_vim_theme
catch
  silent! color space-vim-dark
endtry

" Show trailing white space
hi ExtraWhitespace guifg=#FF2626 gui=underline ctermfg=124 cterm=underline
match ExtraWhitespace /\s\+$/

silent! set showtabline=1 tabline=%!spacevim#vim#tab#TabLine()

if !spacevim#load('chinese')
  silent! set langmenu=en_US
  let $LANG = 'en_US'
  runtime $VIMRUNTIME/delmenu.vim $VIMRUNTIME/menu.vim
endif

augroup spacevimBasic
  autocmd!

  " https://vi.stackexchange.com/questions/298/disable-syntax-highlighting-depending-on-file-size-and-type#comment291_299
  " `syntax off` works in the `BufReadPre` context but not in the `Filetype` context;
  " while `setlocal syntax=OFF` does not work in the `BufReadPre` context but works in the `Filetype` context.
  autocmd FileType xml,json,text call s:TurnOffSyntaxIfTooLarge()

  autocmd BufReadPost     * call s:OnBufReadPost()
  autocmd BufEnter        * call s:OnBufEnter()
  autocmd QuickFixCmdPost * call s:OnQuickFixCmdPost()

  autocmd GUIEnter        * call spacevim#autocmd#GUIEnter()
augroup END
