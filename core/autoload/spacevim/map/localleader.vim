let s:localleader_map = {}

let s:localleader_map['v'] = ['spacevim#plug#fzf#Open()', 'open-files']
let s:localleader_map['p'] = ['spacevim#plug#fzf#Rtp()', 'runtimepath']
let s:localleader_map['f'] = {
      \ 'name': '+fzf',
      \ 'c': ['spacevim#plug#fzf#FZFCmd()', 'fzf-cmd'],
      \ 'f': ['spacevim#plug#fzf#Func()', 'fzf-related-function'],
      \ }

let g:spacevim#map#localleader#desc = get(g:, 'g:spacevim#map#localleader#desc', s:localleader_map)
