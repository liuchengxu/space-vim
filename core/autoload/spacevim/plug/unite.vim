scriptencoding utf-8

let g:spacevim#plug#unite#menus = {}

" [menu]x : menu.edition {
let g:spacevim#plug#unite#menus.x = {
            \ 'description' : '    text             ⌘ [menu]x',
            \}
let g:spacevim#plug#unite#menus.x.command_candidates = [
            \['►   show-hidden-chars',
            \'set list!'],
            \['►   x d ➞  delete-trailing-whitespaces                         ⌘  SPC x d',
            \'StripWhitespace'],
            \['►   a | ➞  align-repeat-bar                                    ⌘  SPC a |',
            \'Tabularize /|'],
            \['►   a = ➞  align-repeat-equal                                  ⌘  SPC a =',
            \'Tabularize /^[^=]*\zs='],
            \['►   s c ➞  cancel-highlight-of-searched-result                 ⌘  SPC s c',
            \'nohl'],
            \['►   t p ➞  toggle-paste-mode                                   ⌘  SPC t p',
            \'setlocal paste!'],
            \]
" }

" [menu]f : menu.files {
let g:spacevim#plug#unite#menus.f = {
            \ 'description' : '    fzf.vim          ⌘ [menu]f',
            \}
" supported by fzf layer
let g:spacevim#plug#unite#menus.f.command_candidates = [
            \['►   Buffers                                          (fzf)',
            \'Buffers'],
            \['►   Files                                            (fzf)',
            \'Files'],
            \['►   GFiles                                           (fzf)',
            \'GFiles?'],
            \['►   Windows                                          (fzf)',
            \'Windows'],
            \['►   Marks                                            (fzf)',
            \'Marks'],
            \['►   Maps                                             (fzf)',
            \'Maps'],
            \['►   History                                          (fzf)',
            \'History'],
            \['►   History:                                         (fzf)',
            \'History:'],
            \['►   History/                                         (fzf)',
            \'History/'],
            \]
" }

" [menu]p : menu.plugins {
let g:spacevim#plug#unite#menus.p = {
            \ 'description' : '    plugins          ⌘ [menu]s',
            \}
let g:spacevim#plug#unite#menus.p.command_candidates = [
            \['►   install-plugin                                    (vim-plug)',
            \'PlugInstall'],
            \['►   clean-plugin                                      (vim-plug)',
            \'PlugClean'],
            \['►   update-plugin                                     (vim-plug)',
            \'PlugUpdate'],
            \['►   show-plugin-status                                (vim-plug)',
            \'PlugStatus'],
            \['►   ycm-restart-server                                (ycmd)',
            \'YcmRestartServer'],
            \['►   generate-markdown-toc                             (markdown-toc)',
            \'GenTocGFM'],
            \]
" }

" [menu]t : menu.toggle {
let g:spacevim#plug#unite#menus.t = {
            \ 'description' : '    toggle           ⌘ [menu]t',
            \}
let g:spacevim#plug#unite#menus.t.command_candidates = [
            \['►   nerdtree                                          (toggle)       ⌘ <F4>',
            \'NERDTreeToggle'],
            \['►   tagbar                                            (toggle)       ⌘ <F6>',
            \'TagbarToggle'],
            \['►   indent-line                                       (toggle)       ⌘',
            \'IndentGuidesToggle'],
            \['►   syntastic                                         (toggle)       ⌘',
            \'SyntasticToggleMode'],
            \]
" }

" [menu]u : menu.unite.vim {
let g:spacevim#plug#unite#menus.u = {
            \ 'description' : '    unite.vim        ⌘ [menu]u',
            \}
let g:spacevim#plug#unite#menus.u.command_candidates = [
            \['►    ➞  unite sources',
            \'Unite source'],
            \]
" }

" [menu]v : menu.vim {
let g:spacevim#plug#unite#menus.v = {
            \ 'description' : '    vim              ⌘ [menu]v',
            \}
let g:spacevim#plug#unite#menus.v.command_candidates = [
            \['►   init.vim',
            \'e ~/.vimrc'],
            \['►   .spacevim',
            \'e ~/.spacevim'],
            \['►   vim-help',
            \'Unite help -start-insert'],
            \['►   vim-commands',
            \'Unite command -start-insert'],
            \['►   vim-mappings',
            \'Unite mapping -start-insert'],
            \['►   vim-functions',
            \'Unite function -start-insert'],
            \['►   vim-runtimepath',
            \'Unite runtimepath -start-insert '],
            \['►   vim-command-output',
            \'Unite output'],
            \]
" }
