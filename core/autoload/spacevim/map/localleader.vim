let g:spacevim#map#localleader#desc = get(g:, 'g:spacevim#map#localleader#desc', {})

let g:spacevim#map#localleader#desc['v'] = ['spacevim#plug#fzf#Open()', 'open-files']
let g:spacevim#map#localleader#desc['p'] = ['spacevim#plug#fzf#Rtp()', 'runtimepath']
let g:spacevim#map#localleader#desc['f'] = {
      \ 'name': '+fzf',
      \ 'c': ['spacevim#plug#fzf#FZFCmd()', 'fzf-cmd'],
      \ 'f': ['spacevim#plug#fzf#Func()', 'fzf-related-function'],
      \ }


