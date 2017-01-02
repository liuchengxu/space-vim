scriptencoding utf-8
if LayerLoaded('leader-guide')

    let g:lmap = get(g:, 'lmap', {})

    function! s:spacevim_postinstall()
        if exists('g:loaded_leaderGuide_vim')
            function! s:spacevim_displayfunc()
                let g:leaderGuide#displayname = substitute(g:leaderGuide#displayname, '\c<cr>$', '', '')
                let g:leaderGuide#displayname = substitute(g:leaderGuide#displayname, '^<SID>', '', '')
                let g:leaderGuide#displayname = substitute(g:leaderGuide#displayname, '#', '', '')
            endfunction
            if exists('g:leaderGuide_displayfunc')
                call add(g:leaderGuide_displayfunc, function('s:spacevim_displayfunc'))
            else
                let g:leaderGuide_displayfunc = [function('s:spacevim_displayfunc')]
            endif

            call leaderGuide#register_prefix_descriptions('<Space>', 'g:lmap')
            nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
            vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>
        endif
    endfunction
    augroup spacevim_postinstall
        autocmd!
        autocmd VimEnter * call s:spacevim_postinstall()
    augroup END

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Helpers
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    function! s:spacevim_bind(map, binding, name, value, isCmd)
        if a:isCmd
            let l:value = ':' . a:value . '<cr>'
        else
            let l:value = a:value
        endif
        if a:map ==# 'map' && maparg('<Leader>' . a:binding, '') ==# ''
            let l:noremap = 'noremap'
        elseif a:map ==# 'nmap' && maparg('<Leader>' . a:binding, 'n') ==# ''
            let l:noremap = 'nnoremap'
        elseif a:map ==# 'vmap' && maparg('<Leader>' . a:binding, 'v') ==# ''
            let l:noremap = 'vnoremap'
        else
            let l:noremap = ''
        endif

        if l:noremap !=# ''
            execute l:noremap . ' <silent> <SID>' . a:name . '# ' . l:value
            execute a:map . ' <Leader>' . a:binding . ' <SID>' . a:name . '#'
        endif
    endfunction

    function! s:spacevim_bind_plug(map, binding, name, value)
        if a:map ==# 'map' && maparg('<Leader>' . a:binding, '') ==# ''
            let l:map = 'map'
        elseif a:map ==# 'nmap' && maparg('<Leader>' . a:binding, 'n') ==# ''
            let l:map = 'nmap'
        elseif a:map ==# 'vmap' && maparg('<Leader>' . a:binding, 'v') ==# ''
            let l:map = 'vmap'
        else
            let l:map = ''
        endif

        if l:map !=# ''
            execute l:map . ' <silent> <SID>' . a:name . '# <Plug>' . a:value
            execute a:map . ' <Leader>' . a:binding . ' <SID>' . a:name . '#'
        endif
    endfunction

    function! s:spacevim_is_layer_enabled(name)
        if !exists('g:spacevim_enabled_layers')
            return 1
        endif
        return index(g:spacevim_enabled_layers, a:name) != -1
    endfunction

    function! s:spacevim_get_visual_selection()
        let [lnum1, col1] = getpos("'<")[1:2]
        let [lnum2, col2] = getpos("'>")[1:2]
        let lines = getline(lnum1, lnum2)
        let lines[-1] = lines[-1][: col2 - 2]
        let lines[0] = lines[0][col1 - 1:]
        return join(lines, '\n')
    endfunction

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Bindings
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    if s:spacevim_is_layer_enabled('core/root')
        call s:spacevim_bind('map', '<Tab>', 'last-buffer', 'b#', 1)
        call s:spacevim_bind('map', '!', 'shell-cmd', 'call feedkeys(":! ")', 1)
        call s:spacevim_bind('map', '/', 'smart-search', 'Ag', 1)
        call s:spacevim_bind('nmap', '*', 'smart-search-with-input', 'call SpacevimSmartSearchWithInput(0)', 1)
        call s:spacevim_bind('vmap', '*', 'smart-search-with-input', 'call SpacevimSmartSearchWithInput(1)', 1)

        call s:spacevim_bind('map', '1', 'window-1', '1wincmd w', 1)
        call s:spacevim_bind('map', '2', 'window-2', '2wincmd w', 1)
        call s:spacevim_bind('map', '3', 'window-3', '3wincmd w', 1)
        call s:spacevim_bind('map', '4', 'window-4', '4wincmd w', 1)
        call s:spacevim_bind('map', '5', 'window-5', '5wincmd w', 1)
        call s:spacevim_bind('map', '6', 'window-6', '6wincmd w', 1)
        call s:spacevim_bind('map', '7', 'window-7', '7wincmd w', 1)
        call s:spacevim_bind('map', '8', 'window-8', '8wincmd w', 1)
        call s:spacevim_bind('map', '9', 'window-9', '9wincmd w', 1)
        call s:spacevim_bind('map', '0', 'window-10', '10wincmd w', 1)

        call s:spacevim_bind('map', ':', 'M-x', 'call SpacevimCommands()', 1)

        call s:spacevim_bind('nmap', ';', 'comment-operator', 'call SpacevimCommentOperator(0)', 1)
        call s:spacevim_bind_plug('nmap', ';;', 'comment-line', 'call SpacevimCommentLine()')
        call s:spacevim_bind('vmap', ';', 'comment-operator', 'call SpacevimCommentOperator(1)', 1)
    endif

    " applications {{{
    if s:spacevim_is_layer_enabled('core/applications')
        let g:lmap.a = { 'name': '+applications' }
        call s:spacevim_bind('map', 'au', 'undo-tree-visualize', 'UndotreeToggle', 1)
    endif
    " }}}

    " buffers {{{
    if s:spacevim_is_layer_enabled('core/buffers')
        let g:lmap.b = { 'name': '+buffers' }
        call s:spacevim_bind('map', 'bb', 'buffers', 'call SpacevimBuffers()', 1)
        call s:spacevim_bind('map', 'bd', 'kill-this-buffer', 'call SpacevimKillBuffer()', 1)
        call s:spacevim_bind('map', 'bK', 'kill-other-buffers', 'call SpacevimKillOtherBuffers()', 1)
        call s:spacevim_bind('map', 'bn', 'next-useful-buffer', 'bnext', 1)
        call s:spacevim_bind('map', 'bp', 'previous-useful-buffer', 'bprevious', 1)
        call s:spacevim_bind('map', 'bR', 'safe-revert-buffer', 'e', 1)

        " buffers/move {{{
        if s:spacevim_is_layer_enabled('core/buffers/move')
            let g:lmap.b.m = { 'name': '+move' }
            call s:spacevim_bind('map', 'bmr', 'buf-rotate-down-right', 'wincmd r', 1)
            call s:spacevim_bind('map', 'bmR', 'buf-rotate-up-left', 'wincmd R', 1)
        endif
    endif
    " }}}

    " }}}

    " comile/comments {{{
    if s:spacevim_is_layer_enabled('core/compile-comments')
        let g:lmap.c = { 'name': '+compile/comments' }
    endif
    " }}}

    " capture/colors {{{
    if s:spacevim_is_layer_enabled('core/capture-colors')
        let g:lmap.C = { 'name': '+capture/colors' }
    endif
    " }}}

    " errors {{{
    if s:spacevim_is_layer_enabled('syntax-checking')
        let g:lmap.e = { 'name': '+errors' }
        call s:spacevim_bind('map', 'el', 'error-list', 'call SpacevimErrorList()', 1)
        call s:spacevim_bind('map', 'en', 'next-error', 'call SpacevimErrorNext()', 1)
        call s:spacevim_bind('map', 'eN', 'previous-error', 'call SpacevimErrorPrev()', 1)
        call s:spacevim_bind('map', 'ep', 'previous-error', 'call SpacevimErrorPrev()', 1)
    endif
    " }}}

    " files {{{
    if s:spacevim_is_layer_enabled('core/files')
        let g:lmap.f = { 'name': '+files' }
        call s:spacevim_bind('map', 'fc', 'copy-file', 'saveas', 1)

        " files/convert {{{
        if s:spacevim_is_layer_enabled('core/files/convert')
            let g:lmap.f.C = { 'name': '+files/convert' }
        endif
        " }}}

        call s:spacevim_bind('map', 'fD', 'delete-current-buffer-file', 'Remove', 1)
        call s:spacevim_bind('map', 'fE', 'sudo-edit', 'call feedkeys(":SudoEdit ")', 1)
        call s:spacevim_bind('map', 'ff', 'find-files', 'call SpacevimFindFiles()', 1)
        call s:spacevim_bind('map', 'fL', 'locate', 'call feedkeys(":Locate ")', 1)
        call s:spacevim_bind('map', 'fr', 'recentf', 'call SpacevimRecentf()', 1)
        call s:spacevim_bind('map', 'fR', 'rename-current-buffer-file', 'call feedkeys(":Rename ")', 1)
        call s:spacevim_bind('map', 'fs', 'save-buffer', 'write', 1)
        call s:spacevim_bind('map', 'fS', 'write-all', 'wall', 1)
        call s:spacevim_bind('map', 'ft', 'explorer-toggle', 'call SpacevimExplorerToggle()', 1)

        " files/vim {{{
        if s:spacevim_is_layer_enabled('core/files/vim')
            let g:lmap.f.e = { 'name': '+files/vim' }
            call s:spacevim_bind('map', 'fed', 'find-dotfile', 'edit $MYVIMRC', 1)
            call s:spacevim_bind('map', 'feR', 'sync-configuration', 'source $MYVIMRC', 1)
            call s:spacevim_bind('map', 'fev', 'display-vim-version', 'version', 1)
        endif
        " }}}

    endif
    " }}}

    " git/versions-control {{{
    if s:spacevim_is_layer_enabled('git')
        let g:lmap.g = { 'name': '+git/versions-control' }
        call s:spacevim_bind('map', 'gb', 'git-blame', 'Gblame', 1)
        call s:spacevim_bind('map', 'gc', 'git-commit', 'Gcommit', 1)
        call s:spacevim_bind('map', 'gC', 'git-checkout', 'Git checkout', 1)
        call s:spacevim_bind('map', 'gd', 'git-diff', 'Gdiff', 1)
        call s:spacevim_bind('map', 'gD', 'git-diff-head', 'Gdiff HEAD', 1)
        call s:spacevim_bind('map', 'gf', 'git-fetch', 'Gfetch', 1)
        call s:spacevim_bind('map', 'gF', 'git-pull', 'Gpull', 1)
        call s:spacevim_bind('map', 'gi', 'git-init', 'Git init', 1)
        call s:spacevim_bind('map', 'gI', 'git-ignore', 'Gedit .gitignore', 1)
        call s:spacevim_bind('map', 'gl', 'git-log', 'call SpacevimGitLog()', 1)
        call s:spacevim_bind('map', 'gL', 'git-log-buffer-file', 'GV!', 1)
        call s:spacevim_bind('map', 'gr', 'git-checkout-current-file', 'Gread', 1)
        call s:spacevim_bind('map', 'gR', 'git-remove-current-file', 'Gremove', 1)
        call s:spacevim_bind('map', 'gs', 'git-status', 'Gstatus', 1)
        call s:spacevim_bind('map', 'gS', 'git-stage-file', 'call feedkeys(":Git add -- ")', 1)
        call s:spacevim_bind('map', 'gw', 'git-stage-current-file', 'Gwrite', 1)

        if s:spacevim_is_layer_enabled('git/vcs-micro-state')
            let g:lmap.g['.'] = { 'name': '+vcs-micro-state' }
            call s:spacevim_bind('nmap', 'g.s', 'stage', 'GitGutterStageHunk', 1)
            call s:spacevim_bind('nmap', 'g.r', 'revert', 'GitGutterRevertHunk', 1)
            call s:spacevim_bind('nmap', 'g.h', 'show-hunk', 'GitGutterPreviewHunk', 1)
            call s:spacevim_bind('nmap', 'g.n', 'next', 'GitGutterNextHunk', 1)
            call s:spacevim_bind('nmap', 'g.N', 'previous', 'GitGutterPrevHunk', 1)
            call s:spacevim_bind('nmap', 'g.p', 'previous', 'GitGutterPrevHunk', 1)
            call s:spacevim_bind('nmap', 'g.t', 'toggle margin', 'GitGutterSignsToggle', 1)
        endif
    endif
    " }}}

    " help/highlight {{{
    if s:spacevim_is_layer_enabled('core/help-highlight')
        let g:lmap.h = { 'name': '+help/highlight' }
    endif
    " }}}

    " insertion {{{
    if s:spacevim_is_layer_enabled('core/insertion')
        let g:lmap.i = { 'name': '+insertion' }
        call s:spacevim_bind('nmap', 'ij', 'vim-insert-line-below', 'mao<Esc>`a', 0)
        call s:spacevim_bind('nmap', 'ik', 'vim-insert-line-above', 'maO<Esc>`a', 0)
    endif
    " }}}

    " join/split {{{
    if s:spacevim_is_layer_enabled('core/join-split')
        let g:lmap.j = { 'name': '+join/split' }
        call s:spacevim_bind('nmap', 'j=', 'indent-region-or-buffer', 'mzgg=G`z', 0)
        call s:spacevim_bind('vmap', 'j=', 'indent-region-or-buffer', '==', 0)
        call s:spacevim_bind('map', 'jj', 'sp-newline', 'i<CR><Esc>', 0)
        call s:spacevim_bind('map', 'jJ', 'split-and-newline', 'i<CR><Esc>', 0) " same as j.j ?
        call s:spacevim_bind('map', 'jo', 'open-line', 'i<CR><Esc>k$', 0)
    endif
    " }}}

    " lisp {{{
    if s:spacevim_is_layer_enabled('core/lisp')
        let g:lmap.k = { 'name': '+lisp' }
    endif
    " }}}

    " narrow/numbers {{{
    if s:spacevim_is_layer_enabled('core/narrow-numbers')
        let g:lmap.n = { 'name': '+narrow/numbers' }
        call s:spacevim_bind('map', 'n=', 'numbers-increase', '<C-a>', 0)
        call s:spacevim_bind('map', 'n+', 'numbers-increase', '<C-a>', 0)
        call s:spacevim_bind('map', 'n-', 'numbers-decrease', '<C-x>', 0)
        call s:spacevim_bind('map', 'n,', 'page-up', '<PageUp>', 0)
        call s:spacevim_bind('map', 'n.', 'page-down', '<PageDown>', 0)
        call s:spacevim_bind('map', 'n<lt>', 'half-page-up', '<C-u>', 0)
        call s:spacevim_bind('map', 'n>', 'half-page-down', '<C-d>', 0)
    endif
    " }}}

    " projects {{{
    if s:spacevim_is_layer_enabled('core/projects')
        let g:lmap.p = { 'name': '+projects' }
        call s:spacevim_bind('map', 'pf', 'project-find-file', 'call SpacevimProjectFindFile()', 1)
        call s:spacevim_bind('map', 'pD', 'project-directory', 'call SpacevimProjectDirectory()', 1)
        call s:spacevim_bind('map', 'pI', 'project-invalidate-cache', 'call SpacevimProjectInvalidateCache()', 1)
    endif
    " }}}

    " quit {{{
    if s:spacevim_is_layer_enabled('core/quit')
        let g:lmap.q = { 'name': '+quit' }
        call s:spacevim_bind('map', 'qq', 'prompt-kill-vim', 'quitall', 1)
        call s:spacevim_bind('map', 'qQ', 'kill-vim', 'quitall!', 1)
        call s:spacevim_bind('map', 'qs', 'save-buffers-kill-vim', 'xall', 1)
    endif
    " }}}

    " registers/rings {{{
    if s:spacevim_is_layer_enabled('core/registers-rings')
        let g:lmap.r = { 'name': '+registers/rings' }
    endif
    " }}}

    " search/symbol {{{
    if s:spacevim_is_layer_enabled('core/search-symbol')
        let g:lmap.s = { 'name': '+search/symbol' }
        call s:spacevim_bind('map', 'sc', 'highlight-persist-remove-all', 'noh', 1)
        call s:spacevim_bind('map', 'sp', 'smart-search', 'Ag', 1)
        call s:spacevim_bind('nmap', 'ss', 'vim-swoop', 'call Swoop()', 1)
        call s:spacevim_bind('vmap', 'ss', 'vim-swoop', 'call SwoopSelection()', 1)
        call s:spacevim_bind('nmap', 'sP', 'smart-search-with-input', 'call SpacevimSmartSearchWithInput(0)', 1)
        call s:spacevim_bind('vmap', 'sP', 'smart-search-with-input', 'call SpacevimSmartSearchWithInput(1)', 1)
    endif
    " }}}

    " toggles {{{
    if s:spacevim_is_layer_enabled('core/toggles')
        let g:lmap.t = { 'name': '+toggles' }
        call s:spacevim_bind('map', 'tf', 'wrap', 'call SpacevimToggleWrap()', 1)
        call s:spacevim_bind('map', 'tl', 'truncate-line', 'setlocal invwrap', 1)
        call s:spacevim_bind('map', 'tn', 'line-numbers', 'setlocal invnumber', 1)
        call s:spacevim_bind('map', 'tr', 'linum-relative-toggle', 'setlocal invrelativenumber', 1)
        call s:spacevim_bind('map', 'ts', 'syntax', 'call SpacevimToggleSyntax()', 1)
        call s:spacevim_bind('map', 'tS', 'spelling', 'setlocal invspell', 1)

        " toggles/highlight {{{
        if s:spacevim_is_layer_enabled('core/toggles/highlight')
            let g:lmap.t.h = { 'name': '+toggles/highlight' }
            call s:spacevim_bind('nmap', 'thc', 'highlight-indentation-current-column', 'setlocal invcursorcolumn', 1)
            call s:spacevim_bind('nmap', 'thl', 'highlight-current-line-globaly', 'setlocal invcursorline', 1)
        endif
        " }}}
        "
        if s:spacevim_is_layer_enabled('core/toggles/colors')
            let g:lmap.t.C = { 'name': '+toggles/colors' }
            call s:spacevim_bind('nmap', 'tCp', 'parenthesis-highlight-mode', 'setlocal invshowmatch', 1)
        endif

    endif
    " }}}

    " UI toggles/themes {{{
    if s:spacevim_is_layer_enabled('core/ui-toggles-themes')
        let g:lmap.T = { 'name': '+UI toggles/themes' }
        if s:spacevim_is_layer_enabled('git')
            call s:spacevim_bind('map', 'Td', 'version-control-margin', 'GitGutterToggle', 1)
        endif
    endif
    " }}}

    " windows {{{
    if s:spacevim_is_layer_enabled('core/windows')
        let g:lmap.w = { 'name': '+windows' }
        call s:spacevim_bind('map', 'w-', 'split-window-below', 'split', 1)
        call s:spacevim_bind('map', 'w/', 'split-window-right', 'vsplit', 1)
        call s:spacevim_bind('map', 'w=', 'balance-windows', 'wincmd =', 1)
        call s:spacevim_bind('map', 'wc', 'delete-window', 'q', 1)
        call s:spacevim_bind('map', 'wh', 'window-left', 'wincmd h', 1)
        call s:spacevim_bind('map', 'wH', 'window-move-far-left', 'wincmd H', 1)
        call s:spacevim_bind('map', 'wj', 'window-down', 'wincmd j', 1)
        call s:spacevim_bind('map', 'wJ', 'window-move-far-down', 'wincmd J', 1)
        call s:spacevim_bind('map', 'wk', 'window-up', 'wincmd k', 1)
        call s:spacevim_bind('map', 'wK', 'window-move-far-up', 'wincmd K', 1)
        call s:spacevim_bind('map', 'wl', 'window-right', 'wincmd l', 1)
        call s:spacevim_bind('map', 'wL', 'window-move-far-right', 'wincmd L', 1)
        call s:spacevim_bind('map', 'wm', 'maximize-buffer', 'call SpacevimMaximizeBuffer()', 1)
        call s:spacevim_bind('map', 'ws', 'split-window-below', 'split', 1)
        call s:spacevim_bind('map', 'wS', 'split-window-below-and-focus', 'split\|wincmd w', 1)
        call s:spacevim_bind('map', 'wv', 'split-window-right', 'vsplit', 1)
        call s:spacevim_bind('map', 'wV', 'split-window-right-and-focus', 'vsplit\|wincmd w', 1)
        call s:spacevim_bind('map', 'ww', 'other-window', 'wincmd w', 1)
    endif
    " }}}

    " text {{{
    if s:spacevim_is_layer_enabled('core/text')
        let g:lmap.x = { 'name': '+text' }
    endif
    " }}}

    if s:spacevim_is_layer_enabled('core/root')
        call s:spacevim_bind_plug('nmap', 'y', 'easymotion-line', '(easymotion-bd-jk)')
        call s:spacevim_bind_plug('vmap', 'y', 'easymotion-line', '(easymotion-bd-jk)')
    endif

    " zoom {{{
    if s:spacevim_is_layer_enabled('core/zoom')
        let g:lmap.z = { 'name': '+zoom' }
    endif
    " }}}

    "let g:leaderGuide_default_group_name = '+prefix'
    "" leader-guide{
    "" Define prefix dictionary
    "let g:lmap = {}
    ""let g:lmap = {
    ""            \'m' : {'name' : 'easymotion'},
    ""            \'a' : {'name' : 'applications'},
    ""            \'c' : {'name' : 'comment'},
    ""            \'e' : {'name' : 'errors'},
    ""            \'f' : {'name' : 'file'},
    ""            \'g' : {'name' : 'git/version control'},
    ""            \'j' : {'name' : 'jump'},
    ""            \'t' : {'name' : 'toggle'},
    ""            \'x' : {'name' : 'text'},
    ""            \}
    "" Second level dictionaries:
    "let g:lmap['a'] = {'name' : 'align'}
    "let g:lmap['b'] = {'name' : 'buffers'}
    "let g:lmap['c'] = { 'name' : 'comment' }
    "let g:lmap['c'] = { 'name' : 'comment' }
    "let g:lmap['e'] = { 'name' : 'errors' }
    "let g:lmap['f'] = { 'name' : 'file' }
    "let g:lmap['g'] = { 'name' : 'git/version control' }
    "let g:lmap['j'] = { 'name' : 'jump' }
    "let g:lmap['m'] = { 'name' : 'easymotion'}
    "let g:lmap['t'] = { 'name' : 'toggle' }
    "let g:lmap['w'] = { 'name' : 'window' }
    "let g:lmap['x'] = { 'name' : 'text' }
    "let g:lmap[';'] = { 'name' : 'comments' }
    "" 'name' is a special field. It will define the name of the group.
    "" leader-f is the "File Menu" group.
    "" Unnamed groups will show a default string

    "" align
    "let g:lmap['a']['&'] = [':Tabularize /&', 'align &']
    "let g:lmap['a']['='] = [':Tabularize /=', 'align equal']
    "let g:lmap['a']['=>'] = [':Tabularize /^[^=]*\zs=', 'align array (=>)']
    "let g:lmap['a'][':'] = [':Tabularize /:', 'align colon']
    "let g:lmap['a'][':;'] = [':Tabularize /:\zs', 'align colon']
    "let g:lmap['a'][','] = [':Tabularize /,', 'align comma']
    "let g:lmap['a'][',,'] = [':Tabularize /,\zs', 'align comma']
    "let g:lmap['a']['|'] = [':Tabularize /<Bar>', 'align pipeline']
    "let g:lmap['a']['"'] = [':Tabularize /"', 'align quotation mark']
    "let g:lmap['a']['#'] = [':Tabularize /#', 'align sharp']

    "" bufers
    "let g:lmap['b']['b'] = [':Buffers', 'list buffers']
    "let g:lmap['b']['?'] = [':Buffers', 'list buffers']
    "let g:lmap['b']['h'] = [':Startify', 'startify']


    "" easy-motion
    "let g:lmap.j['f'] = ['<Plugin>(easymotion-s)', 'Find char to bidirection']
    "let g:lmap.j['l'] = ['<Plugin>(easymotion-bd-jk)', 'move to line']
    "let g:lmap.j['j'] = ['<Plugin>(easymotion-bd-f)', 'move to word']
    "let g:lmap.j['J'] = ['<Plugin>(easymotion-overwin-f2)', 'move to word (same to normal mode "s")']
    "let g:lmap.j['w'] = ['<Plugin>(easymotion-bd-w)', 'move to word']
    "let g:lmap.j['.'] = ['<Plugin>(easymotion-repeat)', 'repeat']

    "" file related key mappings
    "let g:lmap.f.f = ['NERDTreeFind', 'Find in NERDTree']
    "let g:lmap.f.R = ['source ~/.vimrc', 'reload vimrc']

    "" error related key mappings
    "let g:lmap.e.e = [':call ToggleErrors()', 'open error panel']
    "let g:lmap.e.r = ['SyntasticReset', 'syntastic clear']
    "let g:lmap.e.h = ['SyntasticInfo', 'describe checker']
    "let g:lmap.e.n = [':call WrapCommand("down", "l")', 'previous error']
    "let g:lmap.e.p = [':call WrapCommand("up", "l")', 'next error']

    "" git related key mappings
    "let g:lmap['g']['b'] = [':Gblame', 'git blame']
    "let g:lmap['g']['c'] = [':Gcommit', 'git commit']
    "let g:lmap['g']['d'] = [':Gdiff', 'git diff']
    "let g:lmap['g']['l'] = [':Glog', 'git log']
    "let g:lmap['g']['p'] = [':Gpush', 'git push']
    "let g:lmap['g']['s'] = [':Gstatus', 'git status']
    "let g:lmap['g']['g'] = [':SignifyToggle', 'show diff (deprecated)']

    "" jump
    "let g:lmap.j.d = [':YcmCompleter GoTo', 'jump to']
    "let g:lmap.j.D = [':YcmCompleter GoToDeclaration', 'jump to']
    "let g:lmap.j.f = [':CtrlPFunky', 'jump without ctag']
    "let g:lmap.j.F = [':execute "CtrlPFunky " . expand("<cword>")', 'init a list by a word under cursor']
    "let g:lmap.j.m = [':CtrlPMRU', 'most recent used']
    "let g:lmap.j.b = [':CtrlPBuffer', 'jump to buffer']
    "let g:lmap.j.p = [':CtrlP', 'ctrlp']
    "let g:lmap.j.T = [':CtrlPClearCache', 'clear cache']

    "" toggle settings
    "let g:lmap['t']['f'] = [':NERDTreeToggle', 'toggle NERDTree']
    "let g:lmap['t']['g'] = [':GitGutterToggle', 'toggle Git diff in file']
    "let g:lmap['t']['i'] = [':IndentGuidesToggle', 'toggle visualize indent']
    "if IsDir('syntastic')
    "    let g:lmap['t']['s'] = [':SyntasticToggleMode', 'toggle syntastic mode between active / passive']
    "endif
    "let g:lmap['t']['t'] = [':TagbarToggle', 'toggle Tagbar']
    "let g:lmap['t']['y'] = [':Goyo', 'toggle Goyo mode']

    "" window management
    "if has('gui_running')
    "    let g:lmap['w']['m'] = [':call <SID>full_screen_toggle()', 'maximize']
    "endif
    "let g:lmap['w']['?'] = [':Windows', 'list windows']

    "" text
    "let g:lmap['x']['a'] = ['EasyAlign', 'interactive align']
    "let g:lmap['x']['a'] = ['EasyAlign', 'interactive align']
    ""let g:lmap.x.a = {
    ""            \'name' : 'align',
    ""            \'a' : [':EasyAlign', 'interactive align'],
    ""            \' ' : [':EasyAlign *\\', 'align space'],
    ""            \'=' : [':EasyAlign *=', 'align equal'],
    ""            \':' : [':EasyAlign *:', 'align colon'],
    ""            \'|' : [':EasyAlign *<Bar>', 'align pipeline'],
    ""            \'"' : [':EasyAlign *"', 'align quotation mark'],
    ""            \'#' : [':EasyAlign *#', 'align sharp'],
    ""            \}

    "let g:leaderGuide_submode_mappings = {
    "            \ '<C-C>': 'win_close',
    "            \ '<C-F>': 'page_down',
    "            \ '<C-B>': 'page_up'
    "            \}

    "augroup leader_guide_prevent
    "    " for fugitive
    "    autocmd FileType gitcommit  noremap <buffer> <leader> <Plug>leaderguide-buffer
    "    "autocmd FileType markdown noremap <buffer> <leader> <Plug>leaderguide-buffer

    "    " for tagbar
    "    autocmd BufEnter __Tagbar__  noremap <buffer> <leader> <Plug>leaderguide-buffer
    "augroup END

    "call leaderGuide#register_prefix_descriptions(g:mapleader, 'g:lmap')
    "nnoremap <silent> <leader> :<c-u>LeaderGuide g:mapleader<CR>
    "vnoremap <silent> <leader> :<c-u>LeaderGuideVisual g:mapleader<CR>

    "" localleader settings
    "" Group names can be defined by filetype. Add the following lines:
    "let g:llmap = {}
    "augroup LG_MARKDOWN
    "    autocmd!
    "    autocmd FileType markdown let g:llmap['1'] = { 'name' : 'H1' }
    "    autocmd FileType markdown let g:llmap['2'] = { 'name' : 'H2' }
    "    autocmd FileType markdown let g:llmap['3'] = { 'name' : 'H3' }
    "    autocmd FileType markdown let g:llmap['4'] = { 'name' : 'H4' }
    "    autocmd FileType markdown let g:llmap['5'] = { 'name' : 'H5' }
    "augroup END

    "if IsDir('vim-xmark')
    "    augroup LG_MD
    "        autocmd!
    "        autocmd FileType markdown let g:llmap.cp = {'name': 'Xmark'}
    "    augroup END
    "endif

    "call leaderGuide#register_prefix_descriptions(g:maplocalleader, 'g:llmap')

    "" to name the <localleader>-n group vimtex in tex files.
    "nnoremap <localleader> :<c-u>LeaderGuide  g:maplocalleader<CR>
    "vnoremap <localleader> :<c-u>LeaderGuideVisual  g:maplocalleader<CR>
    "map <localleader>. <Plug>leaderguide-buffer
    " }

endif
