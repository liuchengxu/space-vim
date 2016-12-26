MP 'luochen1990/rainbow'
MP 'editorconfig/editorconfig-vim'

MP 'junegunn/rainbow_parentheses.vim', { 'for': ['lisp', 'clojure', 'scheme'] }

" Refer to https://github.com/junegunn/vim-plug/wiki/faq
" Load on nothing
MP 'SirVer/ultisnips', { 'on': [] } | MP 'honza/vim-snippets', { 'on': [] }

augroup load_snips
    autocmd!
    autocmd InsertEnter * call plug#load('ultisnips', 'vim-snippets')
                \| autocmd! load_snips
augroup END

" Do not lazy loading tagbar, see vim-airline issue 1313.
if LayerLoaded('airline')
    MP 'majutsushi/tagbar'
else
    MP 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
endif

MP 'Chiel92/vim-autoformat',          { 'on': 'Autoformat'}

MP 'nathanaelkane/vim-indent-guides', { 'on': 'IndentGuidesToggle'}

MP 'skywind3000/asyncrun.vim',        { 'on': ['AsyncRun!', 'AsyncRun'] }

MP 'scrooloose/nerdcommenter',        { 'on': '<Plug>NERDCommenterToggle' }

