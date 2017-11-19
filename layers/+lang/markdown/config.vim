" vim-markdown {
  let g:vim_markdown_math = 1
  let g:vim_markdown_frontmatter = 1
  let g:vim_markdown_conceal = 0
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
" }
