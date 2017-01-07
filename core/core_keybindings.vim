scriptencoding utf-8


call Source(g:spacevim_dir . g:spacevim_core_dir . '/core_funcs.vim')

let g:lmap = get(g:, 'lmap', {})

" default directories {{{
let g:lmap['a'] = {'name' : 'align'}
let g:lmap['b'] = { 'name' : '+buffers' }
let g:lmap['b']['m'] = { 'name': '+move' }
let g:lmap['c'] = { 'name': '+compile/comments' }
let g:lmap['e'] = { 'name' : '+errors' }
let g:lmap['f'] = { 'name' : '+files' }
let g:lmap['f']['e'] = { 'name': '+files/vim' }
let g:lmap['f']['C'] = { 'name': '+files/convert' }
let g:lmap['g'] = { 'name' : '+git/version control' }
let g:lmap['h'] = { 'name': '+help/highlight' }
let g:lmap['j'] = { 'name' : '+jump' }
let g:lmap['m'] = { 'name' : '+move/motion'}
let g:lmap['q'] = { 'name' : '+quit' }
let g:lmap['w'] = { 'name' : '+windows' }
let g:lmap['t'] = { 'name' : '+toggle' }
let g:lmap['t']['C'] = { 'name': '+toggles/colors' }
let g:lmap['T'] = { 'name': '+UI toggles/themes' }
let g:lmap['x'] = { 'name' : '+text' }
let g:lmap[';'] = { 'name' : '+comments' }
"}}}

" Helpers {{{
function! SpacevimBind(map, binding, name, value, isCmd)
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
        if exists('g:spacevim_debug') && g:spacevim_debug !=# '0'
            echom l:noremap . ' <silent> <SID>' . a:name . '# ' . l:value
            echom a:map . ' <Leader>' . a:binding . ' <SID>' . a:name . '#'
        endif
        execute l:noremap . ' <silent> <SID>' . a:name . '# ' . l:value
        execute a:map . ' <Leader>' . a:binding . ' <SID>' . a:name . '#'
    endif
endfunction

function! SpacevimBindPlug(map, binding, name, value)
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
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" default
call SpacevimBind('map', '<Tab>', 'last-buffer', 'b#', 1)
call SpacevimBind('map', '!', 'shell-cmd', 'call feedkeys(":! ")', 1)
call SpacevimBind('map', '/', 'smart-search', 'Ag', 1)
call SpacevimBind('nmap', '*', 'smart-search-with-input', 'call SpacevimSmartSearchWithInput(0)', 1)
call SpacevimBind('vmap', '*', 'smart-search-with-input', 'call SpacevimSmartSearchWithInput(1)', 1)
call SpacevimBind('map', 'qq', 'prompt-kill-vim', 'quitall', 1)
call SpacevimBind('map', 'qQ', 'kill-vim', 'quitall!', 1)
call SpacevimBind('map', 'qs', 'save-buffers-kill-vim', 'xall', 1)

" windows {{{
"call SpacevimBind('map', 'w1', 'window-1', '1wincmd w', 1)
"call SpacevimBind('map', 'w2', 'window-2', '2wincmd w', 1)
"call SpacevimBind('map', 'w3', 'window-3', '3wincmd w', 1)
"call SpacevimBind('map', 'w4', 'window-4', '4wincmd w', 1)
"call SpacevimBind('map', 'w5', 'window-5', '5wincmd w', 1)
"call SpacevimBind('map', 'w6', 'window-6', '6wincmd w', 1)
"call SpacevimBind('map', 'w7', 'window-7', '7wincmd w', 1)
"call SpacevimBind('map', 'w8', 'window-8', '8wincmd w', 1)
"call SpacevimBind('map', 'w9', 'window-9', '9wincmd w', 1)
"call SpacevimBind('map', 'w0', 'window-10', '10wincmd w', 1)
call SpacevimBind('map', 'w-', 'split-window-below', 'split', 1)
call SpacevimBind('map', 'w/', 'split-window-right', 'vsplit', 1)
call SpacevimBind('map', 'w=', 'balance-windows', 'wincmd =', 1)
call SpacevimBind('map', 'wc', 'delete-window', 'q', 1)
call SpacevimBind('map', 'wh', 'window-left', 'wincmd h', 1)
call SpacevimBind('map', 'wH', 'window-move-far-left', 'wincmd H', 1)
call SpacevimBind('map', 'wj', 'window-down', 'wincmd j', 1)
call SpacevimBind('map', 'wJ', 'window-move-far-down', 'wincmd J', 1)
call SpacevimBind('map', 'wk', 'window-up', 'wincmd k', 1)
call SpacevimBind('map', 'wK', 'window-move-far-up', 'wincmd K', 1)
call SpacevimBind('map', 'wl', 'window-right', 'wincmd l', 1)
call SpacevimBind('map', 'wL', 'window-move-far-right', 'wincmd L', 1)
call SpacevimBind('map', 'wm', 'maximize-buffer', 'call SpacevimMaximizeBuffer()', 1)
call SpacevimBind('map', 'ws', 'split-window-below', 'split', 1)
call SpacevimBind('map', 'wS', 'split-window-below-and-focus', 'split\|wincmd w', 1)
call SpacevimBind('map', 'wv', 'split-window-right', 'vsplit', 1)
call SpacevimBind('map', 'wV', 'split-window-right-and-focus', 'vsplit\|wincmd w', 1)
call SpacevimBind('map', 'ww', 'other-window', 'wincmd w', 1)
"}}}

" buffers {{{
"call SpacevimBind('nmap', '<Tab>', 'next-buffer', 'bn', 1)
"call SpacevimBind('map', 'b1', 'buffer-1', 'buffer1', 1)
"call SpacevimBind('map', 'b2', 'buffer-2', 'buffer2', 1)
"call SpacevimBind('map', 'b3', 'buffer-3', 'buffer3', 1)
"call SpacevimBind('map', 'b4', 'buffer-4', 'buffer4', 1)
"call SpacevimBind('map', 'b5', 'buffer-5', 'buffer5', 1)
"call SpacevimBind('map', 'b6', 'buffer-6', 'buffer6', 1)
"call SpacevimBind('map', 'b7', 'buffer-7', 'buffer7', 1)
"call SpacevimBind('map', 'b8', 'buffer-8', 'buffer8', 1)
"call SpacevimBind('map', 'b9', 'buffer-9', 'buffer9', 1)
call SpacevimBind('map', 'bd', 'kill-this-buffer', 'call SpacevimKillBuffer()', 1)
call SpacevimBind('map', 'bK', 'kill-other-buffers', 'call SpacevimKillOtherBuffers()', 1)
call SpacevimBind('map', 'bn', 'next-useful-buffer', 'bnext', 1)
call SpacevimBind('map', 'bp', 'previous-useful-buffer', 'bprevious', 1)
call SpacevimBind('map', 'bR', 'safe-revert-buffer', 'e', 1)
call SpacevimBind('map', 'bmr', 'buf-rotate-down-right', 'wincmd r', 1)
call SpacevimBind('map', 'bmR', 'buf-rotate-up-left', 'wincmd R', 1)

call SpacevimBind('nmap', ';', 'comment-operator', 'call SpacevimCommentOperator(0)', 1)
call SpacevimBindPlug('nmap', ';;', 'comment-line', 'call SpacevimCommentLine()')
call SpacevimBind('vmap', ';', 'comment-operator', 'call SpacevimCommentOperator(1)', 1)
"}}}

" files {{{
call SpacevimBind('map', 'fc', 'copy-file', 'saveas', 1)

" files/convert {{{
call SpacevimBind('map', 'fD', 'delete-current-buffer-file', 'Remove', 1)
call SpacevimBind('map', 'fE', 'sudo-edit', 'call feedkeys(":SudoEdit ")', 1)
"call SpacevimBind('map', 'ff', 'find-files', 'call SpacevimFindFiles()', 1)
call SpacevimBind('map', 'fL', 'locate', 'call feedkeys(":Locate ")', 1)
call SpacevimBind('map', 'fR', 'rename-current-buffer-file', 'call feedkeys(":Rename ")', 1)
call SpacevimBind('map', 'fs', 'save-buffer', 'write', 1)
call SpacevimBind('map', 'fS', 'write-all', 'wall', 1)
call SpacevimBind('map', 'ft', 'file-explorer', 'call SpacevimExplorerToggle()', 1)

" vim related
call SpacevimBind('map', 'fed', 'find-dotfile', 'edit $MYVIMRC', 1)
call SpacevimBind('map', 'feR', 'sync-configuration', 'source $MYVIMRC', 1)
call SpacevimBind('map', 'fev', 'display-vim-version', 'version', 1)
" }}}

call SpacevimBind('nmap', 'tCp', 'parenthesis-highlight-mode', 'setlocal invshowmatch', 1)


" toggles {{{
call SpacevimBind('map', 'tf', 'wrap', 'call SpacevimToggleWrap()', 1)
call SpacevimBind('map', 'tl', 'truncate-line', 'setlocal invwrap', 1)
call SpacevimBind('map', 'tn', 'line-numbers', 'setlocal invnumber', 1)
call SpacevimBind('map', 'tr', 'linum-relative-toggle', 'setlocal invrelativenumber', 1)
call SpacevimBind('map', 'ts', 'syntax', 'call SpacevimToggleSyntax()', 1)
call SpacevimBind('map', 'tS', 'spelling', 'setlocal invspell', 1)

" toggles/highlight {{{
let g:lmap.t.h = { 'name': '+toggles/highlight' }
call SpacevimBind('nmap', 'thc', 'highlight-indentation-current-column', 'setlocal invcursorcolumn', 1)
call SpacevimBind('nmap', 'thl', 'highlight-current-line-globaly', 'setlocal invcursorline', 1)
" }}}
"
let g:lmap.t.C = { 'name': '+toggles/colors' }
call SpacevimBind('nmap', 'tCp', 'parenthesis-highlight-mode', 'setlocal invshowmatch', 1)
"}}}


" text {{{
call SpacevimBind('map', 'xd', 'strip-white-space', 'StripWhitespace', 1)
" }}}


" applications {{{
if LayerLoaded('core/applications')
    let g:lmap.a = { 'name': '+applications' }
    call SpacevimBind('map', 'au', 'undo-tree-visualize', 'UndotreeToggle', 1)
endif
" }}}

" capture/colors {{{
if LayerLoaded('core/capture-colors')
    let g:lmap.C = { 'name': '+capture/colors' }
endif
" }}}

" insertion {{{
if LayerLoaded('core/insertion')
    let g:lmap.i = { 'name': '+insertion' }
    call SpacevimBind('nmap', 'ij', 'vim-insert-line-below', 'mao<Esc>`a', 0)
    call SpacevimBind('nmap', 'ik', 'vim-insert-line-above', 'maO<Esc>`a', 0)
endif
" }}}

" join/split {{{
if LayerLoaded('core/join-split')
    let g:lmap.j = { 'name': '+join/split' }
    call SpacevimBind('nmap', 'j=', 'indent-region-or-buffer', 'mzgg=G`z', 0)
    call SpacevimBind('vmap', 'j=', 'indent-region-or-buffer', '==', 0)
    call SpacevimBind('map', 'jj', 'sp-newline', 'i<CR><Esc>', 0)
    call SpacevimBind('map', 'jJ', 'split-and-newline', 'i<CR><Esc>', 0) " same as j.j ?
    call SpacevimBind('map', 'jo', 'open-line', 'i<CR><Esc>k$', 0)
endif
" }}}

" lisp {{{
if LayerLoaded('core/lisp')
    let g:lmap.k = { 'name': '+lisp' }
endif
" }}}

" narrow/numbers {{{
if LayerLoaded('core/narrow-numbers')
    let g:lmap.n = { 'name': '+narrow/numbers' }
    call SpacevimBind('map', 'n=', 'numbers-increase', '<C-a>', 0)
    call SpacevimBind('map', 'n+', 'numbers-increase', '<C-a>', 0)
    call SpacevimBind('map', 'n-', 'numbers-decrease', '<C-x>', 0)
    call SpacevimBind('map', 'n,', 'page-up', '<PageUp>', 0)
    call SpacevimBind('map', 'n.', 'page-down', '<PageDown>', 0)
    call SpacevimBind('map', 'n<lt>', 'half-page-up', '<C-u>', 0)
    call SpacevimBind('map', 'n>', 'half-page-down', '<C-d>', 0)
endif
" }}}

" projects {{{
if LayerLoaded('core/projects')
    let g:lmap.p = { 'name': '+projects' }
    call SpacevimBind('map', 'pf', 'project-find-file', 'call SpacevimProjectFindFile()', 1)
    call SpacevimBind('map', 'pD', 'project-directory', 'call SpacevimProjectDirectory()', 1)
    call SpacevimBind('map', 'pI', 'project-invalidate-cache', 'call SpacevimProjectInvalidateCache()', 1)
endif
" }}}

" quit {{{
if LayerLoaded('core/quit')
    let g:lmap.q = { 'name': '+quit' }
endif
" }}}

" registers/rings {{{
if LayerLoaded('core/registers-rings')
    let g:lmap.r = { 'name': '+registers/rings' }
endif
" }}}

" search/symbol {{{
if LayerLoaded('core/search-symbol')
    let g:lmap.s = { 'name': '+search/symbol' }
    call SpacevimBind('map', 'sc', 'highlight-persist-remove-all', 'noh', 1)
    call SpacevimBind('map', 'sp', 'smart-search', 'Ag', 1)
    call SpacevimBind('nmap', 'ss', 'vim-swoop', 'call Swoop()', 1)
    call SpacevimBind('vmap', 'ss', 'vim-swoop', 'call SwoopSelection()', 1)
    call SpacevimBind('nmap', 'sP', 'smart-search-with-input', 'call SpacevimSmartSearchWithInput(0)', 1)
    call SpacevimBind('vmap', 'sP', 'smart-search-with-input', 'call SpacevimSmartSearchWithInput(1)', 1)
endif
" }}}

" zoom {{{
if LayerLoaded('core/zoom')
    let g:lmap.z = { 'name': '+zoom' }
endif
" }}}

"function! s:spacevim_keybinding()
"    if exists('g:loaded_leaderGuide_vim')
"        function! s:spacevim_displayfunc()
"            let g:leaderGuide#displayname = substitute(g:leaderGuide#displayname, '\c<cr>$', '', '')
"            let g:leaderGuide#displayname = substitute(g:leaderGuide#displayname, '^<SID>', '', '')
"            let g:leaderGuide#displayname = substitute(g:leaderGuide#displayname, '#', '', '')
"        endfunction
"        if exists('g:leaderGuide_displayfunc')
"            call add(g:leaderGuide_displayfunc, function('s:spacevim_displayfunc'))
"        else
"            let g:leaderGuide_displayfunc = [function('s:spacevim_displayfunc')]
"        endif
"
"        call leaderGuide#register_prefix_descriptions(g:mapleader, 'g:lmap')
"        nnoremap <silent> <leader> :<c-u>LeaderGuide g:mapleader<CR>
"        vnoremap <silent> <leader> :<c-u>LeaderGuideVisual g:mapleader<CR>
"    endif
"endfunction

"if IsDir('vim-leader-guide')
"    call leaderGuide#register_prefix_descriptions(g:mapleader, 'g:lmap')
"    nnoremap <silent> <leader> :<c-u>LeaderGuide g:mapleader<CR>
"    vnoremap <silent> <leader> :<c-u>LeaderGuideVisual g:mapleader<CR>
"endif
