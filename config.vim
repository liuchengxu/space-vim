"  Plugins {

    if has_key(g:default_layers, 'better-defaults')
        source ~/.space-vim/layers/better-defaults.vim
    endif

    if has_key(g:default_layers, 'programming')
        source ~/.space-vim/layers/programming.vim
    endif

    if has_key(g:default_layers, 'markdown')
        source ~/.space-vim/layers/markdown.vim
    endif

    if has_key(g:default_layers, 'fzf')
        source ~/.space-vim/layers/fzf.vim
    endif

    if has_key(g:default_layers, 'text-align')
        source ~/.space-vim/layers/text-align.vim
    endif

    if has_key(g:default_layers, 'syntax-checking')
        source ~/.space-vim/layers/syntax-checking.vim
    endif

    if has_key(g:default_layers, 'unite')
        source ~/.space-vim/layers/unite.vim
    endif

    if has_key(g:default_layers, 'ycmd')
        source ~/.space-vim/layers/ycmd.vim
    endif

" }


