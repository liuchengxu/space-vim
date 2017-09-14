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
if spacevim#LayerLoaded('text-align')
  " Makrdown table align
  nnoremap <buffer> <LocalLeader>ta :Tabularize /<Bar><CR>
endif
