" ----------------------------------------------
" fzf or leaderf
" ----------------------------------------------
function! s:dispatch(...) abort
  if !exists('g:loaded_fzf')
    call plug#load('fzf', 'fzf.vim')
  endif
  if a:0 == 2
    " FIXME better configurable
    let prefer_fzf = 1
    let cmd = prefer_fzf ? a:1 : a:2
    execute cmd
  elseif a:0 == 1
    execute a:1
  endif
endfunction

function! spacevim#wrap#fzf#File() abort
  call s:dispatch('Files', 'LeaderfFile')
endfunction

function! spacevim#wrap#fzf#Buffers() abort
  " Use custom Buffers
  call s:dispatch('call spacevim#plug#fzf_base#buffers()', 'LeaderfBuffer')
endfunction

function! spacevim#wrap#fzf#BLines() abort
  call s:dispatch('BLines', 'LeaderfLine')
endfunction

function! spacevim#wrap#fzf#BLinesAll() abort
  call s:dispatch('Lines', 'LeaderfLineAll')
endfunction

function! spacevim#wrap#fzf#Files() abort
  call s:dispatch('Files ~', 'LeaderfFile ~')
endfunction

" nnoremap <LocalLeader>fc :call spacevim#plug#fzf#FZFCmd()<CR>
function! spacevim#wrap#fzf#Rtp() abort
  call spacevim#plug#fzf#Rtp()
endfunction
