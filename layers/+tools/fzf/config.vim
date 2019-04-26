nnoremap <silent><Leader>ff :<c-u>call spacevim#wrap#fzf#Files()<CR>
nnoremap <silent><Leader>bb :<c-u>call spacevim#wrap#fzf#Buffers()<CR>
nnoremap <silent><Leader>fl :<c-u>call spacevim#wrap#fzf#BLines()<CR>
nnoremap <silent><Leader>fL :<c-u>call spacevim#wrap#fzf#BLinesAll()<CR>

if g:spacevim.gui && !has('terminal')
  " LeaderF {
  let g:Lf_ReverseOrder = 1
  nnoremap <Leader>f? :LeaderfFile<CR>
  nnoremap <Leader>fr :LeaderfMru<CR>
  " }
else
  " fzf.vim {
  " Refer to https://github.com/liuchengxu/space-vim/issues/364
  let $LANG = 'en_US.UTF-8'

  if exists('*nvim_open_win')
    let $FZF_DEFAULT_OPTS = '--layout=reverse'
    let g:fzf_layout = { 'window': 'call spacevim#plug#fzf#FloatingWin()' }
  else
    " g:fzf_colors would reset the highlight even you have set the highlight
    " of floating window explicitly.
    "
    " Customize fzf colors to match your color scheme
    " Only suitable for space-vim-dark theme, other themes are not guaranteed.
    let g:fzf_colors = {
                \ 'fg':      ['fg', 'StatusLineNC'],
                \ 'bg':      ['bg', 'Normal'],
                \ 'hl':      ['fg', 'String'],
                \ 'fg+':     ['fg', 'Number', 'Normal'],
                \ 'bg+':     ['bg', 'StatusLine', 'Normal'],
                \ 'hl+':     ['fg', 'Exception'],
                \ 'info':    ['fg', 'Special'],
                \ 'prompt':  ['fg', 'Function'],
                \ 'pointer': ['fg', 'Error'],
                \ 'marker':  ['fg', 'Error'],
                \ 'spinner': ['fg', 'Statement'],
                \ 'header':  ['fg', 'Number'],
                \   }
  endif

  " fzf.vim doesn't enable preview feature by default.
  command! -bang -nargs=* Ag
              \ echo "\r" | call fzf#vim#ag(<q-args>, fzf#vim#with_preview(), <bang>0)

  command! -bang -nargs=? -complete=dir Files
    \ echo "\r\r" | call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

  command! -nargs=* Rag call spacevim#plug#fzf#AgInProject(<q-args>)

  command! -bang -nargs=* Rg call spacevim#plug#fzf#Rg(<q-args>, <bang>0)

  nmap <Leader>? <plug>(fzf-maps-n)
  xmap <Leader>? <plug>(fzf-maps-x)
  omap <Leader>? <plug>(fzf-maps-o)

  nnoremap <Leader>ag :Ag!<CR>
  vnoremap <Leader>ag :<c-u>call spacevim#plug#fzf#Vsearch()<CR>

  nnoremap <Leader>w? :Windows<CR>
  nnoremap <Leader>f? :Files<CR>

  nnoremap <silent> <Leader>sf :call spacevim#plug#fzf#Session()<CR>

  nnoremap <leader>rg :Rg!<cr>
  vnoremap <leader>rg :call spacevim#plug#fzf#RgVisual()<CR>

  " Mimic <C-R> in bash
  cnoremap <C-R> :History:<CR>

  nnoremap <LocalLeader>v :call spacevim#wrap#fzf#Open()<CR>
  nnoremap <LocalLeader>p :call spacevim#wrap#fzf#Rtp()<CR>
  nnoremap <LocalLeader>fc :call spacevim#plug#fzf#FZFCmd()<CR>
  nnoremap <LocalLeader>ff :call spacevim#plug#fzf#Func()<CR>

  " }
endif
