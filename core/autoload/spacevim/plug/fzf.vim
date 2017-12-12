let g:spacevim#plug#fzf#colors = {
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

let g:fzf_layout = { 'down': '~40%'  }

function! spacevim#plug#fzf#Open()
  let l:open = [
        \ '~/.spacevim',
        \ '~/.space-vim/init.vim',
        \ '~/.bashrc',
        \ '~/.zshrc',
        \ '~/.tmux.conf'
        \ ]
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

function! spacevim#plug#fzf#Oldfiles()
  redir => old
  silent oldfiles
  redir END
  let list = split(old, "\n")
  call fzf#run({
        \ 'source': list,
        \ 'sink': 'e',
        \ 'options': '+m --prompt="Oldfiles> "',
        \ 'window': '20new'
        \ })
endfunction
