if IsDir('tagbar')
    call SpacevimBind('nmap', 'tt', 'toggle-tagbar', 'TagbarToggle', 1)
endif

if IsDir('nerdcommenter')
    call SpacevimBind('nmap', ';;', 'toggle-comment', 'NERDCommenterToggle', 1)
    call SpacevimBind('omap', ';;', 'toggle-comment', 'NERDCommenterToggle', 1)
    call SpacevimBind('vmap', ';;', 'toggle-comment', 'NERDCommenterToggle', 1)
endif

if IsDir('vim-indent-guides')
    call SpacevimBind('nmap', 'ti', 'toggle-indentguide', 'IndentGuidesToggle', 1)
endif
