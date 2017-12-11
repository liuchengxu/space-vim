let g:fzf_layout = { 'down': '~40%'  }

function! spacevim#plug#fzf#Open()
  let l:open = [ '~/.spacevim', '~/.space-vim/init.vim' ]
  call fzf#run({
        \ 'source': l:open,
        \ 'sink': 'e',
        \ 'options': '+m --prompt="Open> "',
        \ 'window': '10new'
        \ })
endfunction

function! spacevim#plug#fzf#Rtp()
  call fzf#run({
        \ 'source': split(&runtimepath, ','),
        \ 'options': '+m --prompt="Rtp> "',
        \ 'window': '20new'
        \ })
endfunction
