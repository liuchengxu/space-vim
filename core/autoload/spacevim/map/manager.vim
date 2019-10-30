let s:clap_enabled = get(g:, 'spacevim_enable_clap', 0)

let g:spacevim#map#manager#quick_open = [
        \ '~/.spacevim',
        \ '~/.space-vim/init.vim',
        \ '~/.bashrc',
        \ '~/.zshrc',
        \ '~/.tmux.conf',
        \ ]

function! spacevim#map#manager#Buffers() abort
  if s:clap_enabled && exists(':Clap')
    Clap buffers
  else
    call spacevim#wrap#fzf#Buffers()
  endif
endfunction

function! spacevim#map#manager#Files() abort
  if s:clap_enabled && exists(':Clap')
    Clap buffers
  else
    call spacevim#wrap#fzf#Files()
  endif
endfunction

function! spacevim#map#manager#BufTags() abort
  " vim-clap
  if s:clap_enabled && exists(':Clap')
    Clap tags

  " fzf
  elseif exists(':BTags')
    if !exists('g:loaded_fzf')
      call plug#load('fzf', 'fzf.vim')
    endif
    BTags

  " leaderf
  elseif exists(':LeaderfBufTag')
    LeaderfBufTag

  else
    call spacevim#util#err('No avaliable tool for opening buffer tags')
  endif
endfunction

function! spacevim#map#manager#BLines() abort
  if s:clap_enabled && exists(':Clap')
    Clap blines
  else
    call spacevim#wrap#fzf#BLines()
  endif
endfunction

function! spacevim#map#manager#BLinesAll() abort
  if s:clap_enabled && exists(':Clap')
    Clap lines
  else
    call spacevim#wrap#fzf#BLinesAll()
  endif
endfunction

function! spacevim#map#manager#BufCword() abort
  " fzf
  call spacevim#plug#fzf#SearchBcword()
endfunction

function! spacevim#map#manager#RgCword() abort
  if s:clap_enabled && exists(':Clap')
    Clap grep ++query=<cword>
  else
    " fzf
    call spacevim#plug#fzf#RgCursorWord()
  endif
endfunction

function! spacevim#map#manager#Rg() abort
  if s:clap_enabled && exists(':Clap')
    Clap grep
  else
    " fzf
    Rg
  endif
endfunction

function! spacevim#map#manager#CommandHistory() abort
  if s:clap_enabled && exists(':Clap')
    Clap hist:
  else
    History:
  endif
endfunction

function! spacevim#map#manager#SearchRecently() abort
  if s:clap_enabled && exists(':Clap')
    Clap history
  else
    History
  endif
endfunction

function! spacevim#map#manager#QuickOpen() abort
  if s:clap_enabled && exists(':Clap')
    if !exists('g:clap_provider_quick_open')
      let g:clap_provider_quick_open = {
            \ 'source': g:spacevim#map#manager#quick_open,
            \ 'sink': 'e',
            \ }
    endif
    Clap quick_open
  elseif exists(':FZF')
    call spacevim#plug#fzf#Open()
  elseif exists(':Unite')
    Unite -silent menu:v
  else
    call spacevim#util#err('No avaliable tool for quick open')
  endif
endfunction

function! spacevim#map#manager#FindFiles() abort
  if s:clap_enabled && exists(':Clap')
    Clap files
  else
    call spacevim#plug#fzf#FindFileInProject()
  endif
endfunction
