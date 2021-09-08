" OmniSharp/omnisharp-vim: {
  let g:OmniSharp_popup_position = winwidth(0) >= 80 ? 'peek' : 'center'
  if has('nvim')
    let g:OmniSharp_popup_options = {
    \ 'winhl': 'Normal:NormalFloat'
    \}
  else
    let g:OmniSharp_popup_options = {
    \ 'highlight': 'Normal',
    \ 'padding': [0, 0, 0, 0],
    \ 'border': [1]
    \}
  endif
  let g:OmniSharp_popup_mappings = {
  \ 'pageDown': ['<C-f>', '<PageDown>'],
  \ 'pageUp': ['<C-b>', '<PageUp>']
  \}

  "if s:using_snippets
  "  let g:OmniSharp_want_snippet = 1
  "endif

  let g:OmniSharp_highlight_groups = {
  \ 'ExcludedCode': 'NonText'
  \}
  "\ 'Comment': 'NonText',
  "\ 'XmlDocCommentName': 'Identifier',
  "\ 'XmlDocCommentText': 'NonText'
  "\}

  if spacevim#load('clap')
    let g:OmniSharp_selector_findusages = 'clap'
  endif
  let g:OmniSharp_autoselect_existing_sln = 1
  let g:OmniSharp_highlighting = 3
  let g:OmniSharp_diagnostic_exclude_paths = [ 'Temp[/\\]', 'obj[/\\]', '\.nuget[/\\]' ]
  "let g:OmniSharp_fzf_options = { 'down': '10'  }']]]' ]

  " The following autoformats the code on write per OmniSharp
  " configuration when g:OmniSharp_code_format is set.
  " Each codebase might have different configuration.
  " Some codebases might be messy, where autoformat is a burden in making patches, thus this is false by default.
  " https://github.com/OmniSharp/omnisharp-roslyn/wiki/Configuration-Options
  let g:OmniSharp_code_format = v:false
  augroup codeformatOmniSharp
    autocmd!
    autocmd BufWritePre *.cs :if g:OmniSharp_code_format | :OmniSharpCodeFormat | :endif
  augroup END

  " Cache the 'project' data from OmniSharp-Roslyn to each cs buffer
  augroup cacheOmniSharpProject
    autocmd!
    autocmd FileType cs call s:CacheOmniSharpProjectInBuffer({->0})
  augroup END

  function! s:CacheOmniSharpProjectInBuffer(callback)
    if &filetype ==# 'cs'
      let bufnr = bufnr('%')
      let host = OmniSharp#GetHost(bufnr)
      if !has_key(host, 'project')
        " 'project' not in cache, must query from OmniSharp-Roslyn, is async
        call OmniSharp#actions#project#Get(bufnr, a:callback)
      endif
    endif
  endfunction

  if spacevim#load('programming')
    if exists('g:vista_executive_for') && v:t_dict == type(g:vista_executive_for)
      call extend(g:vista_executive_for, {'cs': 'ctags'})
    else
      let g:vista_executive_for = {'cs': 'ctags'}
    endif
  endif
" }

" nickspoons/vim-sharpenup: {
  " We want everything from vim-sharpenup but the keybindings due to integration
  let g:sharpenup_create_mappings = 0
  let g:sharpenup_map_legacy_csproj_actions = 0

  " TODO: integrate mappings better:
  nmap <C-\> <Plug>(omnisharp_signature_help)
  imap <C-\> <Plug>(omnisharp_signature_help)
  nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
  "nmap <prefix>ca <Plug>(omnisharp_code_actions)
  "xmap <prefix>ca <Plug>(omnisharp_code_actions)
  "nmap <silent> <buffer> <prefix>. <Plug>(omnisharp_code_action_repeat)
  "xmap <silent> <buffer> <prefix>. <Plug>(omnisharp_code_action_repeat)

  " A `Dictionary-function` containing vim-which-key mappings
  function! s:whichkey_omnisharp_integration()
    if &filetype ==# 'cs'
      let s:new_keymap = get(s:, 'new_keymap', {
      \ 'name': '+omnisharp',
      \ '.': ['<Plug>(omnisharp_code_action_repeat)', 'repeat'],
      \ 'a': ['<Plug>(omnisharp_code_actions)'      , 'code-action'],
      \ 'c': ['<Plug>(omnisharp_global_code_check)' , 'global-code-check'],
      \ 'f': ['<Plug>(omnisharp_code_format)'       , 'formatting'],
      \ 'h': ['<Plug>(omnisharp_signature_help)'    , 'hover'],
      \ 'H': ['<Plug>(omnisharp_highlight)'         , 'highlight'],
      \ 'r': ['<Plug>(omnisharp_find_usages)'       , 'references'],
      \ 'R': ['<Plug>(omnisharp_rename)'            , 'rename'],
      \ 's': ['<Plug>(omnisharp_documentation)'     , 'document-symbol'],
      \ 'S': ['<Plug>(omnisharp_find_symbol)'       , 'workspace-symbol'],
      \ 'g': {
        \ 'name': '+goto',
        \ 'd': ['<Plug>(omnisharp_go_to_definition)', 'definition'],
        \ 't': ['<Plug>(omnisharp_find_type)'       , 'type-definition'],
        \ 'i': ['<Plug>(omnisharp_find_implementations)', 'implementation'],
        \ 's': ['<Plug>(omnisharp_find_symbol)'     , 'symbol'],
        \ },
      \ 'p': {
        \ 'name': '+preview',
        \ 'd': ['<Plug>(omnisharp_preview_definition)'     , 'definition'],
        \ 'i': ['<Plug>(omnisharp_preview_implementations)', 'implementation'],
        \ },
      \ 'b': {
        \ 'name': '+build',
        \ 'p': ['<Plug>(omnisharp_build_project)'      , 'build-project'],
        \ 's': ['<Plug>(omnisharp_build_solution)'     , 'build-solution'],
        \ 'd': ['<Plug>(omnisharp_debug_project)'      , 'debug-project'],
        \ 'v': ['<Plug>(omnisharp_create_debug_config)', 'create-vimspector-config'],
        \ },
      \ 't': {
        \ 'name': '+test',
        \ 't': ['<Plug>(omnisharp_run_test)'         , 'run-test'],
        \ 'n': ['<Plug>(omnisharp_run_test_no_build)', 'run-test-no-build'],
        \ 'T': ['<Plug>(omnisharp_run_tests_in_file)', 'run-tests-in-file'],
        \ 'N': ['<Plug>(omnisharp_run_tests_in_file_no_build)', 'run-tests-in-file-no-build'],
        \ 'd': ['<Plug>(omnisharp_debug_test)'         , 'debug-test'],
        \ 'D': ['<Plug>(omnisharp_debug_test_no_build)', 'debug-test-no-build'],
        \ },
      \ 'x': {
        \ 'name': '+csproj-modify',
        \ 'a': ['<Plug>(omnisharp_add_to_csproj)'   , 'add-to-csproj'],
        \ 'r': ['<Plug>(omnisharp_rename_in_csproj)', 'rename-in-csproj'],
        \ },
      \ 'X': {
        \ 'name': '+server',
        \ 's': [':OmniSharpStatus!'                    , 'status'],
        \ 'S': ['<Plug>(omnisharp_start_server)'       , 'start'],
        \ 't': ['<Plug>(omnisharp_stop_server)'        , 'stop'],
        \ 'T': ['<Plug>(omnisharp_stop_all_servers)'   , 'stop-all'],
        \ 'r': ['<Plug>(omnisharp_restart_server)'     , 'restart'],
        \ 'R': ['<Plug>(omnisharp_restart_all_servers)', 'restart-all'],
        \ },
      \ })
      return s:new_keymap
    else
      return s:keep_keymap
    endif
  endfunction

  " Integrate OmniSharp hotkeys with vim-which-key
  if spacevim#load('which-key')
    let s:keep_keymap = get(s:, 'keep_keymap', deepcopy(g:spacevim#map#leader#desc['l']))
    let g:spacevim#map#leader#desc['l'] = function('s:whichkey_omnisharp_integration')
  endif
" }

" mattn/vim-lsp-settings: {
  if exists('g:spacevim_lsp_engine') && g:spacevim_lsp_engine ==# 'vim_lsp'
    let g:lsp_settings = get(g:, 'lsp_settings', {})
    if !has_key(g:lsp_settings, 'omnisharp-lsp')
      let g:lsp_settings['omnisharp-lsp'] = {}
    endif
    let g:lsp_settings['omnisharp-lsp'].disabled = 1
  endif
" }

" itchyny/lightline.vim: {
  let g:sharpenup_statusline_opts = { 'Text': '%s (%p/%P)' }
  let g:sharpenup_statusline_opts.Highlight = 0
" }

" As alternative to OmniSharpCodeFormat, can use different formatter
" vim-autoformat/vim-autoformat: {
  "let g:formatdef_my_custom_cs = '"astyle --mode=cs --style=ansi -pcHs".&shiftwidth'
" }
