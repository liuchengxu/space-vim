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

" vim-lsp {
function! s:vim_lsp() abort
  let g:lsp_diagnostics_enabled = 1
  if executable('rls')
    autocmd User lsp_setup call spacevim#lang#lsp#register_rls()
  endif
  if executable('go-langserver')
    autocmd User lsp_setup call spacevim#lang#lsp#register_go()
  endif
  if executable('pyls')
    autocmd User lsp_setup call spacevim#lang#lsp#register_python()
  endif
  if spacevim#load('which-key')
    let s:keep_keymap_normal = get(s:, 'keep_keymap_normal', deepcopy(g:spacevim#map#leader#desc['l']))
    let g:spacevim#map#leader#desc['l'] = function('s:whichkey_vim_lsp_integration')
    let s:keep_keymap_visual = get(s:, 'keep_keymap_visual', has_key(g:spacevim#map#leader#desc_visual, 'l') ? deepcopy(g:spacevim#map#leader#desc_visual['l']): {})
    let g:spacevim#map#leader#desc_visual['l'] = function('s:whichkey_vim_lsp_integration_visual')
  endif
endfunction

function! s:whichkey_vim_lsp_integration()
  if get(b:, 'spacevim_lsp_engine', g:spacevim_lsp_engine) ==# 'vim_lsp'
    let s:new_keymap_normal = get(s:, 'new_keymap_normal', {
    \ 'name': '+vim-lsp',
    \ '.': ['<plug>(lsp-code-lens)'            , 'code-lens'],
    \ 'a': ['<plug>(lsp-code-action)'          , 'code-action'],
    \ 'f': ['<plug>(lsp-document-format)'      , 'formatting'],
    \ 'F': ['<plug>(lsp-document-range-format)', 'range-formatting'],
    \ 'h': ['<plug>(lsp-hover)'                , 'hover'],
    \ 'H': ['<plug>(lsp-signature-help)'       , 'signature-help'],
    \ 'r': ['<plug>(lsp-references)'           , 'references'],
    \ 'R': ['<plug>(lsp-rename)'               , 'rename'],
    \ 's': ['<plug>(lsp-document-symbol)'      , 'document-symbol'],
    \ 'S': ['<plug>(lsp-workspace-symbol)'     , 'workspace-symbol'],
    \ 'g': {
      \ 'name': '+goto',
      \ 'r': ['<plug>(lsp-next-reference)'         , 'next-reference'],
      \ 'R': ['<plug>(lsp-previous-reference)'     , 'previous-reference'],
      \ 'c': ['<plug>(lsp-declaration)'            , 'declaration'],
      \ 'd': ['<plug>(lsp-definition)'             , 'definition'],
      \ 't': ['<plug>(lsp-type-definition)'        , 'type-definition'],
      \ 'i': ['<plug>(lsp-implementation)'         , 'implementation'],
      \ 's': ['<plug>(lsp-document-symbol-search)' , 'document-symbol-search'],
      \ 'S': ['<plug>(lsp-workspace-symbol-search)', 'workspace-symbol-search'],
      \ },
    \ 'p': {
      \ 'name': '+preview',
      \ 'c': ['<plug>(lsp-peek-declaration)'    , 'declaration'],
      \ 'd': ['<plug>(lsp-peek-definition)'     , 'definition'],
      \ 't': ['<plug>(lsp-peek-type-definition)', 'type-definition'],
      \ 'i': ['<plug>(lsp-peek-implementation)' , 'implementation'],
      \ 'h': ['<plug>(lsp-hover-float)'         , 'hover-float'],
      \ 'p': ['<plug>(lsp-hover-preview)'       , 'hover-preview'],
      \ 'f': ['<plug>(lsp-preview-focus)'       , 'preview-focus'],
      \ 'x': ['<plug>(lsp-preview-close)'       , 'preview-close'],
      \ },
    \ 'O': {
      \ 'name': '+hierarchy',
      \ 't': ['<plug>(lsp-type-hierarchy)'         , 'type-hierarchy'],
      \ 'i': ['<plug>(lsp-call-hierarchy-incoming)', 'call-hierarchy-in'],
      \ 'o': ['<plug>(lsp-call-hierarchy-outgoing)', 'call-hierarchy-out'],
      \ },
    \ 'd': {
      \ 'name': '+diagnostic',
      \ 'r': ['<plug>(lsp-document-diagnostics)', 'document-diagnostics'],
      \ 'd': ['<plug>(lsp-next-diagnostic)'     , 'next-diagnostic'],
      \ 'D': ['<plug>(lsp-previous-diagnostic)' , 'previous-diagnostic'],
      \ 'w': ['<plug>(lsp-next-warning)'        , 'next-warning'],
      \ 'W': ['<plug>(lsp-previous-warning)'    , 'previous-warning'],
      \ 'e': ['<plug>(lsp-next-error)'          , 'next-error'],
      \ 'E': ['<plug>(lsp-previous-error)'      , 'previous-error'],
      \ },
    \ 'X': {
      \ 'name': '+server',
      \ 's': ['<plug>(lsp-status)', 'status'],
      \ 'a': ['lsp#print_server_status()', 'status-all'],
      \ 'S': [':echo "change text to invoke vim-lsp start"'  , 'start'],
      \ 't': ['lsp#stop_server(lsp#get_whitelisted_servers(bufnr("%"))[0])', 'stop'],
      \ 'T': ['map(copy(lsp#get_whitelisted_servers()), {s -> lsp#stop_server(s)})', 'stop-all'],
      \ 'd': {
        \ 'name': '+diagnostics',
        \ 'n': ['execute("echo ".string(lsp#get_server_names()),"")', 'echo-names'],
        \ 'N': ['setbufvar(bufnr("%"), "lsp_names", lsp#get_server_names())', 'get-names b:lsp_names'],
        \ 'a': ['execute("echo ".string(lsp#get_allowed_servers(bufnr("%"))),"")', 'echo-allowed'],
        \ 'A': ['setbufvar(bufnr("%"), "lsp_allowed", lsp#get_allowed_servers(bufnr("%")))', 'get-allowed b:lsp_allowed'],
        \ 'w': ['execute("echo ".string(lsp#get_whitelisted_servers(bufnr("%"))),"")', 'echo-whitelisted'],
        \ 'W': ['setbufvar(bufnr("%"), "lsp_whitelisted", lsp#get_whitelisted_servers(bufnr("%")))', 'get-whitelisted b:lsp_whitelisted'],
        \ 'I': ['setbufvar(bufnr("%"), "lsp_info", lsp#get_server_info(lsp#get_whitelisted_servers(bufnr("%"))[0]))', 'get-info b:lsp_info'],
        \ 'c': ['execute("echo ".string(lsp#get_server_capabilities(lsp#get_whitelisted_servers(bufnr("%"))[0])),"")', 'echo-capabilities'],
        \ 'C': ['setbufvar(bufnr("%"), "lsp_caps", lsp#get_server_capabilities(lsp#get_whitelisted_servers(bufnr("%"))[0]))', 'get-capabilities b:lsp_caps'],
        \ 's': ['execute("echo ".string(asyncomplete#get_source_names()),"")', 'echo-asyncomplete-sources'],
        \ },
      \ },
    \ })
    return s:new_keymap_normal
  else
    return s:keep_keymap_normal
  endif
endfunction

function! s:whichkey_vim_lsp_integration_visual()
  if get(b:, 'spacevim_lsp_engine', g:spacevim_lsp_engine) ==# 'vim_lsp'
    let s:new_keymap_visual = get(s:, 'new_keymap_visual', {
    \ 'name': '+vim-lsp',
    \ 'f': ['<plug>(lsp-document-format)'      , 'formatting'],
    \ 'F': ['<plug>(lsp-document-range-format)', 'range-formatting'],
    \ })
    return s:new_keymap_visual
  else
    return s:keep_keymap_visual
  endif
endfunction
" }

call s:{g:spacevim_lsp_engine}()
