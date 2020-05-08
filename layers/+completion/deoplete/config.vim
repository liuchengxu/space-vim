scriptencoding utf-8

if g:spacevim.nvim || g:spacevim.vim8

  inoremap <expr> <Tab> spacevim#vim#complete#Tab()
  inoremap <expr> <S-Tab> spacevim#vim#complete#STab()
  inoremap <expr> <CR> spacevim#vim#complete#CR()

  set completeopt-=preview  "close show_docstring

  let g:deoplete#enable_at_startup = 1
  " Set minimum syntax keyword length.
  let g:min_pattern_length = 2

  " buffer improve
  let g:require_same_filetype = 'False'

  " delay
  call deoplete#custom#option('auto_complete_delay', 0)
  " auto_refresh
  let g:auto_refresh_delay = 0
  let refresh_always = v:true

  " Plugin key-mappings.
  inoremap <expr><C-g> deoplete#undo_completion()
  inoremap <expr><C-l> deoplete#refresh()

  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"

  " register omni
  call deoplete#custom#source('omni', 'functions', {
        \ 'html': 'htmlcomplete#CompleteTags',
        \ 'css' : 'csscomplete#CompleteCSS',
        \ 'scss' : 'csscomplete#CompleteCSS',
        \ 'sass' : 'csscomplete#CompleteCSS',
        \ 'xml' : 'xmlcomplete#CompleteTags',
        \ 'markdown' : 'htmlcomplete#CompleteTags',
        \ })

  call deoplete#custom#source('omni', 'input_patterns', {
        \ 'html' : '<[^>]',
        \ 'css'  : '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]',
        \ 'scss' : '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]',
        \ 'sass' : '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]',
        \ 'xml'  : '<[^>]*',
        \ 'md'   : '<[^>]*',
        \ })

  " fix conflict with multiple cursors
  function! Multiple_cursors_before()
    call deoplete#custom#buffer_option('auto_complete', v:false)
  endfunction

  function! Multiple_cursors_after()
    call deoplete#custom#buffer_option('auto_complete', v:true)
  endfunction
endif
