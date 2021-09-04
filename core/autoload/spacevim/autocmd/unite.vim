scriptencoding utf-8

let s:menus = {}

" [menu]x : menu.edition {
let s:menus.x = {
            \ 'description' : '    text             ⌘ [menu]x',
            \}
let s:menus.x.command_candidates = [
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
let s:menus.f = {
            \ 'description' : '    fzf.vim          ⌘ [menu]f',
            \}
" supported by fzf layer
let s:menus.f.command_candidates = [
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
let s:menus.p = {
            \ 'description' : '    plugins          ⌘ [menu]s',
            \}
let s:menus.p.command_candidates = [
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
let s:menus.t = {
            \ 'description' : '    toggle           ⌘ [menu]t',
            \}
let s:menus.t.command_candidates = [
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
let s:menus.u = {
            \ 'description' : '    unite.vim        ⌘ [menu]u',
            \}
let s:menus.u.command_candidates = [
            \['►    ➞  unite sources',
            \'Unite source'],
            \]
" }

" [menu]v : menu.vim {
let s:menus.v = {
            \ 'description' : '    vim              ⌘ [menu]v',
            \}
let s:menus.v.command_candidates = [
            \['►   init.vim',
            \'e '.g:spacevim.base.'/init.vim'],
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

function! spacevim#autocmd#unite#Init()
  let g:unite_source_history_yank_enable = 1
  let g:unite_enable_start_insert = 0
  let g:unite_enable_short_source_mes = 0
  let g:unite_force_overwrite_statusline = 0
  let g:unite_prompt = '>>> '
  let g:unite_marked_icon = '✓'
  let g:unite_candidate_icon = '∘'
  let g:unite_winheight = 15
  let g:unite_update_time = 200
  let g:unite_split_rule = 'botright'
  let g:unite_source_buffer_time_format = '(%d-%m-%Y %H:%M:%S) '
  let g:unite_source_file_mru_time_format = '(%d-%m-%Y %H:%M:%S) '
  let g:unite_source_directory_mru_time_format = '(%d-%m-%Y %H:%M:%S) '

  let g:unite_source_menu_menus = s:menus
endfunction
