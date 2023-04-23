MP 'luochen1990/rainbow'  , { 'lazy': g:spacevim.speed_up_via_timer }
MP 'sheerun/vim-polyglot' , { 'lazy': g:spacevim.speed_up_via_timer }
MP 'airblade/vim-rooter'  , { 'lazy': g:spacevim.speed_up_via_timer }
MP 'editorconfig/editorconfig-vim', { 'lazy': g:spacevim.speed_up_via_timer }

MP 'matze/vim-move', { 'on_map': [
            \ '<Plug>MoveBlockDown',
            \ '<Plug>MoveBlockUp',
            \ '<Plug>MoveLineDown',
            \ '<Plug>MoveLineUp',
            \ '<Plug>MoveCharLeft',
            \ '<Plug>MoveCharRight',
            \ ]}

MP 'junegunn/rainbow_parentheses.vim', { 'on_ft': ['lisp', 'clojure', 'scheme'] }

" Need to disable airline extension for tagbar, see vim-airline issue 1313.
"
MP 'majutsushi/tagbar', { 'on_cmd': 'TagbarToggle' }

MP 'liuchengxu/vista.vim'

MP 'Yggdroot/indentLine',             { 'on_cmd': 'IndentLinesToggle',
  \ 'hook_source': function('spacevim#autocmd#indent#Init') }
MP 'nathanaelkane/vim-indent-guides', { 'on_cmd': 'IndentGuidesToggle',
  \ 'hook_source': function('spacevim#autocmd#indent#Init') }

MP 'skywind3000/asyncrun.vim',        { 'on_cmd': ['AsyncRun'] }
