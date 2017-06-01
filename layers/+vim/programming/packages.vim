MP 'luochen1990/rainbow'
MP 'editorconfig/editorconfig-vim', { 'on': 'EditorConfigReload' }

MP 'matze/vim-move', { 'on': [
            \ '<Plug>MoveBlockDown',
            \ '<Plug>MoveBlockUp',
            \ '<Plug>MoveLineDown',
            \ '<Plug>MoveLineUp',
            \ ]}

MP 'junegunn/rainbow_parentheses.vim', { 'for': ['lisp', 'clojure', 'scheme'] }

" Do not lazy loading tagbar, see vim-airline issue 1313.
if spacevim#funcs#LayerLoaded('airline')
  MP 'majutsushi/tagbar'
else
  MP 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
endif

MP 'Chiel92/vim-autoformat',          { 'on': 'Autoformat' }

MP 'Yggdroot/indentLine',             { 'on': 'IndentLinesToggle' }
MP 'nathanaelkane/vim-indent-guides', { 'on': 'IndentGuidesToggle' }

MP 'skywind3000/asyncrun.vim',        { 'on': ['AsyncRun!', 'AsyncRun'] }

MP 'sheerun/vim-polyglot'
