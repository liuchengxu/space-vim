if IsDir('fzf.vim')
    call SpacevimBindPlug('nmap', '?', 'fzf-mapping', 'fzf-maps-n')
    call SpacevimBindPlug('xmap', '?', 'fzf-mapping', 'fzf-maps-x')
    call SpacevimBindPlug('omap', '?', 'fzf-mapping', 'fzf-maps-o')
    call SpacevimBind('map', 'bb', 'buffers', 'Buffers', 1)
    call SpacevimBind('map', 'b?', 'buffers', 'Buffers', 1)
    call SpacevimBind('map', 'w?', 'windows-list', 'Windows', 1)
    call SpacevimBind('map', 'f?', 'file-list', 'Files', 1)
    call SpacevimBind('map', 'ff', 'home-dir-file-list', 'Files ~', 1)
endif


if IsDir('fzf-filemru')
    call SpacevimBind('nmap', 'pr', 'recent-projects', 'ProjectMru --tiebreak=end', 1)
else
    call SpacevimBind('nmap', '?', 'keybinding-list', 'nmap', 1)
endif
