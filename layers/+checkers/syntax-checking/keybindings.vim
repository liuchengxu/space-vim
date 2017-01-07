if IsDir('syntastic')
    call SpacevimBind('map', 'el', 'error-list', 'call SpacevimErrorList()', 1)
    call SpacevimBind('nmap', 'ts', 'toggle-syntastic-mode', 'SyntasticToggleMode', 1)
endif
call SpacevimBind('map', 'en', 'next-error', 'call SpacevimErrorNext()', 1)
call SpacevimBind('map', 'eN', 'previous-error', 'call SpacevimErrorPrev()', 1)
call SpacevimBind('map', 'ep', 'previous-error', 'call SpacevimErrorPrev()', 1)
