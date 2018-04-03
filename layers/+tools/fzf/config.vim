if g:spacevim_gui && !has('terminal')
  " LeaderF {
  nnoremap <Leader>ff :LeaderfFile ~<CR>
  nnoremap <Leader>f? :LeaderfFile<CR>
  nnoremap <Leader>fr :LeaderfMru<CR>
  nnoremap <Leader>fl :LeaderfLine<CR>
  nnoremap <Leader>fL :LeaderfLineAll<CR>
  " }
else
  " fzf.vim {
  let $LANG = 'en_US'
  " Customize fzf colors to match your color scheme
  let g:fzf_colors = g:spacevim#plug#fzf#colors
  nmap <Leader>? <plug>(fzf-maps-n)
  xmap <Leader>? <plug>(fzf-maps-x)
  omap <Leader>? <plug>(fzf-maps-o)

  nnoremap <Leader>ag :Ag<CR>
  nnoremap <Leader>bb :Buffers<CR>

  nnoremap <Leader>b? :Buffers<CR>
  nnoremap <Leader>w? :Windows<CR>
  nnoremap <Leader>f? :Files<CR>

  nnoremap <Leader>ff :Files ~<CR>

      " fzf
  "fzf work with mhinz/vim-startify on sessions
  function! s:sessions()
    call fzf#run({
    \ 'source':  'ls -1 ~/.vim/session',
    \ 'sink':    'SLoad',
    \ 'options': '+m --prompt="Sessions> "',
    \ 'down':    '40%'
    \})
  endfunction
  command! Sessions call s:sessions()
  nnoremap <silent> <leader>sf :Sessions<cr>

  let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

  " autocmd VimEnter * command! -bang -nargs=* Ag
              " \ call fzf#vim#ag(<q-args>,
              " \                 <bang>0 ? fzf#vim#with_preview('up:80%')
              " \                         : fzf#vim#with_preview('right:80%:hidden', '?'),
              " \                 <bang>0)
  
   "fzf surpport preview ,it depends on ripgrep or ag
  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:70%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)

  nnoremap <leader>rg :Rg!<cr>
  " Likewise, Files command with preview window
  command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)



  " }
endif

