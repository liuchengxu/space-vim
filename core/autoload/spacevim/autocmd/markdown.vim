if g:spacevim.os.mac
  let s:path_to_chrome = 'open -a safari'
elseif g:spacevim.os.windows
  let s:path_to_chrome = 'C:\\Program Files (x86)\Google\Chrome\Application\chrome.exe'
else
  let s:path_to_chrome = 'google-chrome'
endif

function! spacevim#autocmd#markdown#Init()
  " previm {
    let g:previm_open_cmd = get(g:, 'previm_open_cmd', s:path_to_chrome)
  " }

  " vim-markdown {
    let g:vim_markdown_math = 1
    let g:vim_markdown_frontmatter = 1
    let g:vim_markdown_conceal = 0
  " }

  " vim-markdown-toc {
    let g:vmt_auto_update_on_save = 1
    let g:vmt_dont_insert_fence = 0
    let g:vim_markdown_toc_autofit = 1
    let g:vmt_fence_text = get(g:, 'g:vmt_fence_text', 'TOC')
    let g:vmt_fence_closing_text = get(g:, 'g:vmt_fence_closing_text', '/TOC')
  " }
endfunction
