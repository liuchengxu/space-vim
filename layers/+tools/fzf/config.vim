if g:spacevim.gui && !has('terminal')
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

  nmap <Leader>? <plug>(fzf-maps-n)
  xmap <Leader>? <plug>(fzf-maps-x)
  omap <Leader>? <plug>(fzf-maps-o)

  nnoremap <Leader>ag :Ag!<CR>
  vnoremap <Leader>ag :<c-u>call spacevim#plug#fzf#Vsearch()<CR>
  nnoremap <Leader>bb :Buffers<CR>

  nnoremap <Leader>b? :Buffers<CR>
  nnoremap <Leader>w? :Windows<CR>
  nnoremap <Leader>f? :Files<CR>

  nnoremap <Leader>ff :Files ~<CR>
  nnoremap <silent> <Leader>sf :call spacevim#plug#fzf#Session()<CR>
  nnoremap <leader>rg :Rg!<cr>
  " }
endif
