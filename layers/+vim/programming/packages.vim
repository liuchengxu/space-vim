MP 'luochen1990/rainbow'
MP 'editorconfig/editorconfig-vim', { 'on': 'EditorConfigReload' }

MP 'matze/vim-move', { 'on': [
            \   '<Plug>MoveBlockDown',
            \   '<Plug>MoveBlockUp',
            \   '<Plug>MoveLineDown',
            \   '<Plug>MoveLineUp',
            \   ]}

MP 'junegunn/rainbow_parentheses.vim', { 'for': ['lisp', 'clojure', 'scheme'] }

MP 'jiangmiao/auto-pairs'

" Refer to https://github.com/junegunn/vim-plug/wiki/faq
" Load on nothing
MP 'SirVer/ultisnips', { 'on': [] } | MP 'honza/vim-snippets', { 'on': [] }

augroup load_snips
    autocmd!
    autocmd InsertEnter * call plug#load('ultisnips', 'vim-snippets')
                \| autocmd! load_snips
augroup END

" Do not lazy loading tagbar, see vim-airline issue 1313.
if funcs#LayerLoaded('airline')
    MP 'majutsushi/tagbar'
else
    MP 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
endif

MP 'Chiel92/vim-autoformat',          { 'on': 'Autoformat' }

MP 'Yggdroot/indentLine',             { 'on': 'IndentLinesToggle' }
MP 'nathanaelkane/vim-indent-guides', { 'on': 'IndentGuidesToggle' }

MP 'skywind3000/asyncrun.vim',        { 'on': ['AsyncRun!', 'AsyncRun'] }

MP 'scrooloose/nerdcommenter',        { 'on': '<Plug>NERDCommenterToggle' }

MP 'sheerun/vim-polyglot'
