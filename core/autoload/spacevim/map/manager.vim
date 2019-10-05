let g:spacevim#map#manager#quick_open = [
        \ '~/.spacevim',
        \ '~/.space-vim/init.vim',
        \ '~/.bashrc',
        \ '~/.zshrc',
        \ '~/.tmux.conf',
        \ ]

function! spacevim#map#manager#Buffers() abort
  if get(g:, 'spacevim_enable_clap', v:false)
    Clap buffers
    return
  endif

  call spacevim#wrap#fzf#Buffers()
endfunction

function! spacevim#map#manager#Files() abort
  if get(g:, 'spacevim_enable_clap', v:false)
    Clap buffers
    return
  endif
  call spacevim#wrap#fzf#Files()
endfunction

function! spacevim#map#manager#BufTags() abort
  " vim-clap
  if get(g:, 'spacevim_enable_clap', v:false)
    Clap tags
    return
  endif

  " fzf
  if exists(':BTags')
    if !exists('g:loaded_fzf')
      call plug#load('fzf', 'fzf.vim')
    endif
    BTags

  " leaderf
  elseif exists(':LeaderfBufTag')
    LeaderfBufTag

  else
    echom "Not avaliable"
  endif
endfunction

function! spacevim#map#manager#BLines() abort
  if get(g:, 'spacevim_enable_clap', v:false)
    Clap blines
    return
  endif
  call spacevim#wrap#fzf#BLines()
endfunction

function! spacevim#map#manager#BLinesAll() abort
  call spacevim#wrap#fzf#BLinesAll()
endfunction

function! spacevim#map#manager#BufCword() abort
  " fzf
  call spacevim#plug#fzf#SearchBcword()
endfunction

function! spacevim#map#manager#RgCword() abort
  if get(g:, 'spacevim_enable_clap', v:false)
    Clap grep <cword>
    return
  endif
  " fzf
  call spacevim#plug#fzf#RgCursorWord()
endfunction

function! spacevim#map#manager#Rg() abort
  " fzf
  Rg
endfunction

function! spacevim#map#manager#CommandHistory() abort
  if get(g:, 'spacevim_enable_clap', v:false)
    Clap hist:
    return
  endif
  History:
endfunction

function! spacevim#map#manager#QuickOpen() abort
  if get(g:, 'spacevim_enable_clap', v:false)
    if !exists('g:clap_provider_quick_open')
      let g:clap_provider_quick_open = {
            \ 'source': g:spacevim#map#manager#quick_open,
            \ 'sink': 'e',
            \ }
    endif
    Clap quick_open
    return
  endif
  " ----------------------------------------------
  " fzf or unite
  " ----------------------------------------------
  if exists(':Unite')
    Unite -silent menu:v
  else
    call spacevim#plug#fzf#Open()
  endif
endfunction
