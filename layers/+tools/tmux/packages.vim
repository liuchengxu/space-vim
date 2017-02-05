if g:spacevim_tmux
    MP 'christoomey/vim-tmux-navigator'
    if core_config#LayerLoaded('unite')
        MP 'lucidstack/ctrlp-tmux.vim',{'on': 'CtrlPTmux'}
    endif
    MP 'jebaum/vim-tmuxify'
endif
