augroup spacevimMarkdown
  " Markdown headings
  autocmd FileType markdown nnoremap <LocalLeader>1 m`yypVr=``
  autocmd FileType markdown nnoremap <LocalLeader>2 m`yypVr-``
  autocmd FileType markdown nnoremap <LocalLeader>3 m`^i### <esc>``4l
  autocmd FileType markdown nnoremap <LocalLeader>4 m`^i#### <esc>``5l
  autocmd FileType markdown nnoremap <LocalLeader>5 m`^i##### <esc>``6l

  autocmd FileType markdown setlocal
              \   wrap

  if spacevim#LayerLoaded('text-align')
    " Makrdown table align
    autocmd FileType markdown nnoremap <LocalLeader>ta :Tabularize /<Bar><CR>
  endif
augroup END

" vim-markdown {
  let g:vim_markdown_math=1
  let g:vim_markdown_frontmatter=1
" }

" vim-markdown-toc {
  let g:vmt_auto_update_on_save = 1
  let g:vmt_dont_insert_fence = 0
  let g:vim_markdown_toc_autofit = 1
" }

" markdown-preview.vim {
  if g:MAC
    let g:mkdp_path_to_chrome = 'open -a safari'
  elseif g:WINDOWS
    let g:mkdp_path_to_chrome = 'C:\\Program Files (x86)\Google\Chrome\Application\chrome.exe'
  else
    let g:mkdp_path_to_chrome = 'google-chrome'
  endif

  " Markdown preview in browser
  autocmd spacevimMarkdown FileType markdown nnoremap <LocalLeader>cp :MarkdownPreview<cr>
  " Generate markdown TOC
  autocmd spacevimMarkdown FileType markdown nnoremap <LocalLeader>ct :silent GenTocGFM<cr>
  " Show toc sidebar
  autocmd spacevimMarkdown FileType markdown nnoremap <LocalLeader>cs :Toc<cr>

" }
