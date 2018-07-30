if exists('b:did_spacevim_md_ftplugin') || !spacevim#load('markdown')
  finish
endif
let b:did_spacevim_md_ftplugin = 1

setlocal wrap

nnoremap <buffer> <LocalLeader>1 m`yypVr=``
nnoremap <buffer> <LocalLeader>2 m`yypVr-``
nnoremap <buffer> <LocalLeader>3 m`^i### <esc>``4l
nnoremap <buffer> <LocalLeader>4 m`^i#### <esc>``5l
nnoremap <buffer> <LocalLeader>5 m`^i##### <esc>``6l

" Markdown preview in browser
nnoremap <buffer> <LocalLeader>cp :MarkdownPreview<cr>
" Generate markdown TOC
nnoremap <buffer> <LocalLeader>ct :silent GenTocGFM<cr>
" Show toc sidebar
nnoremap <buffer> <LocalLeader>cs :Toc<cr>

" Markdown headings
if spacevim#load('text-align')
  " Makrdown table align
  nnoremap <buffer> <LocalLeader>ta :Tabularize /<Bar><CR>
endif

let b:ale_linters = ['mdl']

autocmd CursorHold * silent! UpdateToc

let g:tagbar_type_markdown = {
      \ 'ctagstype' : 'markdown',
      \ 'kinds' : [
        \ 'h:H1',
        \ 'i:H2',
        \ 'k:H3'
        \ ]
      \ }

if g:spacevim.timer
  call timer_start(1300, 'spacevim#defer#markdown')
endif

if exists('*emoji#complete')
  setlocal completefunc=emoji#complete
endif
