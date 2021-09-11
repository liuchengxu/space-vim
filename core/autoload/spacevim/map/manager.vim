let s:clap_enabled = get(g:, 'spacevim_enable_clap', 0)

let g:spacevim#map#manager#quick_open = [
        \ '~/.spacevim',
        \ g:spacevim.base.'/init.vim',
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
    Clap grep2 ++query=<cword>
  else
    " fzf
    call spacevim#plug#fzf#RgCursorWord()
  endif
endfunction

function! spacevim#map#manager#Rg() abort
  if s:clap_enabled && exists(':Clap')
    Clap grep2
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
    Clap recent_files
  else
    History
  endif
endfunction

function! s:TryAddFile(base, items) abort
  let base = a:base
  let items = type(a:items) == v:t_list ? a:items : [a:items]
  for item in items
    if filereadable(expand(item))
      return add(base, item)
    endif
  endfor
  return base
endfunction

function! s:QuickOpenSource() abort
  let quick_open = copy(g:spacevim#map#manager#quick_open)
  if g:spacevim.os.linux
    let quick_open = s:TryAddFile(quick_open, ['~/.alacritty.yml', '~/.config/alacritty/alacritty.yml'])
    let quick_open = s:TryAddFile(quick_open, '~/.config/kitty/kitty.conf')
  endif
  return quick_open
endfunction

function! spacevim#map#manager#QuickOpen() abort
  if s:clap_enabled && exists(':Clap')
    if !exists('g:clap_provider_quick_open')
      let g:clap_provider_quick_open = {
            \ 'source': function('s:QuickOpenSource'),
            \ 'sink': 'e',
            \ 'on_move_async': { -> clap#client#call_preview_file(v:null) }
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
