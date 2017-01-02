scriptencoding utf-8

if LayerLoaded('git')
    let g:lmap.g = { 'name': '+git/versions-control' }
    call SpacevimBind('map', 'gb', 'git-blame', 'Gblame', 1)
    call SpacevimBind('map', 'gc', 'git-commit', 'Gcommit', 1)
    call SpacevimBind('map', 'gC', 'git-checkout', 'Git checkout', 1)
    call SpacevimBind('map', 'gd', 'git-diff', 'Gdiff', 1)
    call SpacevimBind('map', 'gD', 'git-diff-head', 'Gdiff HEAD', 1)
    call SpacevimBind('map', 'gf', 'git-fetch', 'Gfetch', 1)
    call SpacevimBind('map', 'gF', 'git-pull', 'Gpull', 1)
    call SpacevimBind('map', 'gi', 'git-init', 'Git init', 1)
    call SpacevimBind('map', 'gI', 'git-ignore', 'Gedit .gitignore', 1)
    call SpacevimBind('map', 'gl', 'git-log', 'call SpacevimGitLog()', 1)
    call SpacevimBind('map', 'gL', 'git-log-buffer-file', 'GV!', 1)
    call SpacevimBind('map', 'gr', 'git-checkout-current-file', 'Gread', 1)
    call SpacevimBind('map', 'gR', 'git-remove-current-file', 'Gremove', 1)
    call SpacevimBind('map', 'gs', 'git-status', 'Gstatus', 1)
    call SpacevimBind('map', 'gS', 'git-stage-file', 'call feedkeys(":Git add -- ")', 1)
    call SpacevimBind('map', 'gw', 'git-stage-current-file', 'Gwrite', 1)
    call SpacevimBind('map', 'Td', 'version-control-margin', 'GitGutterToggle', 1)
endif

if LayerLoaded('git/vcs-micro-state')
    let g:lmap.g['.'] = { 'name': '+vcs-micro-state' }
    call SpacevimBind('nmap', 'g.s', 'stage', 'GitGutterStageHunk', 1)
    call SpacevimBind('nmap', 'g.r', 'revert', 'GitGutterRevertHunk', 1)
    call SpacevimBind('nmap', 'g.h', 'show-hunk', 'GitGutterPreviewHunk', 1)
    call SpacevimBind('nmap', 'g.n', 'next', 'GitGutterNextHunk', 1)
    call SpacevimBind('nmap', 'g.N', 'previous', 'GitGutterPrevHunk', 1)
    call SpacevimBind('nmap', 'g.p', 'previous', 'GitGutterPrevHunk', 1)
    call SpacevimBind('nmap', 'g.t', 'toggle margin', 'GitGutterSignsToggle', 1)
endif
