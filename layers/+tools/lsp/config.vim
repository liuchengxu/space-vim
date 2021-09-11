" Or map each action separately
nnoremap <silent> gd :call spacevim#lang#util#Definition()<CR>

" If hidden not set, TextEdit might fail.
" Required for operations modifying multiple buffers like rename.
set hidden

function! s:try_show_signature_help() abort
  let ignore_list = ['vista', 'clap_input', 'nerdtree', 'tagbar', 'fzf', 'gitcommit', 'coc']
  if index(ignore_list, &filetype) > -1
    return
  endif
  silent! call CocActionAsync('showSignatureHelp')
endfunction

function! s:coc() abort
  " Better display for messages
  set cmdheight=2

  " Smaller updatetime for CursorHold & CursorHoldI
  set updatetime=300

  " always show signcolumns
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate.
  inoremap <expr> <TAB> spacevim#vim#complete#Tab()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  " Use <c-space> for trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <C-x><C-o> to complete 'word', 'emoji' and 'include' sources
  imap <silent> <C-x><C-o> <Plug>(coc-complete-custom)

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <cr> for confirm completion.
  " Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

  " Use K for show documentation in preview window
  nnoremap <silent> K :call spacevim#plug#coc#show_documentation()<CR>

  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Remap for format selected region
  vmap <localleader>=  <Plug>(coc-format-selected)
  nmap <localleader>=  <Plug>(coc-format-selected)
endfunction

function! s:lcn() abort
  let g:LanguageClient_loggingFile = '/tmp/LanguageClient.log'
  let g:LanguageClient_loggingLevel = 'INFO'
  let g:LanguageClient_serverStderr = '/tmp/LanguageServer.log'
  let g:LanguageClient_settingsPath = fnamemodify(resolve(expand('<sfile>:p')),':h').'/settings.json'

  let g:LanguageClient_serverCommands = {
        \ 'c': ['ccls', '--log-file=/tmp/cq.log'],
        \ 'cpp': ['ccls', '--log-file=/tmp/cq.log'],
        \ 'objc': ['ccls'],
        \ 'go': ['go-langserver', '-gocodecompletion', '-func-snippet-enabled', '-logfile=/tmp/gols.log'],
        \ 'python': ['pyls', '--log-file=/tmp/pyls.log'],
        \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
        \ 'sh': ['bash-language-server', 'start'],
        \ 'typescript': ['javascript-typescript-stdio'],
        \ 'javascript': ['javascript-typescript-stdio'],
        \ 'javascript.jsx': ['javascript-typescript-stdio'],
        \ 'haskell': ['hie-wrapper', '--lsp', '-r', spacevim#util#RootDirectory()],
        \ }

  let g:LanguageClient_rootMarkers = {
         \ 'haskell': ['*.cabal', 'stack.yaml']
         \ }

  let g:LanguageClient_diagnosticsDisplay =
  \    {
  \        1: {
  \            "name": "Error",
  \            "texthl": "Error",
  \            "signText": "✖",
  \            "signTexthl": "ErrorMsg",
  \            "virtualTexthl": "ErrorMsg",
  \        },
  \        2: {
  \            "name": "Warning",
  \            "texthl": "Warning",
  \            "signText": "⚠",
  \            "signTexthl": "WarningMsg",
  \            "virtualTexthl": "WarningMsg",
  \        },
  \        3: {
  \            "name": "Information",
  \            "texthl": "Type",
  \            "signText": "ℹ",
  \            "signTexthl": "Type",
  \            "virtualTexthl": "Type",
  \        },
  \        4: {
  \            "name": "Hint",
  \            "texthl": "String",
  \            "signText": "➤",
  \            "signTexthl": "String",
  \            "virtualTexthl": "String",
  \        },
  \    }

endfunction

function! s:vim_lsp() abort
  let g:lsp_diagnostics_enabled = 0
  if executable('rls')
    autocmd User lsp_setup call spacevim#lang#lsp#register_rls()
  endif
  if executable('go-langserver')
    autocmd User lsp_setup call spacevim#lang#lsp#register_go()
  endif
  if executable('pyls')
    autocmd User lsp_setup call spacevim#lang#lsp#register_python()
  endif
endfunction

call s:{g:spacevim_lsp_engine}()
