scriptencoding utf-8

" unite.vim {
  let g:unite_source_menu_menus = {}

  " menu prefix key (for all Unite menus)
  nnoremap [menu] <Nop>
  nmap <LocalLeader> [menu]

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

  " unite.vim useful resources:
  " https://github.com/joedicastro/dotfiles/tree/master/vim
  " unite prefix: LocalLeader=','
  " menus menu
  nnoremap <silent>[menu]m :Unite -silent -winheight=40 menu<CR>

  " [menu]x : menu.edition {
  let g:unite_source_menu_menus.x = {
              \ 'description' : '    text             ⌘ [menu]x',
              \}
  let g:unite_source_menu_menus.x.command_candidates = [
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
  nnoremap <silent>[menu]x :Unite -silent -winheight=20
              \ menu:x<CR>
  " }

  " [menu]f : menu.files {
  let g:unite_source_menu_menus.f = {
              \ 'description' : '    fzf.vim          ⌘ [menu]f',
              \}
  " supported by fzf layer
  let g:unite_source_menu_menus.f.command_candidates = [
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
  nnoremap <silent>[menu]f :Unite -silent -winheight=20
              \ menu:f<CR>
  " }

  " [menu]p : menu.plugins {
  let g:unite_source_menu_menus.p = {
              \ 'description' : '    plugins          ⌘ [menu]s',
              \}
  let g:unite_source_menu_menus.p.command_candidates = [
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
  nnoremap <silent>[menu]p :Unite -silent
              \ menu:p<CR>
  " }

  " [menu]t : menu.toggle {
  let g:unite_source_menu_menus.t = {
              \ 'description' : '    toggle           ⌘ [menu]t',
              \}
  let g:unite_source_menu_menus.t.command_candidates = [
              \['►   nerdtree                                          (toggle)       ⌘ <F4>',
              \'NERDTreeToggle'],
              \['►   tagbar                                            (toggle)       ⌘ <F6>',
              \'TagbarToggle'],
              \['►   indent-line                                       (toggle)       ⌘',
              \'IndentGuidesToggle'],
              \['►   syntastic                                         (toggle)       ⌘',
              \'SyntasticToggleMode'],
              \]
  nnoremap <silent>[menu]t :Unite -silent
              \ menu:t<CR>
  " }

  " [menu]u : menu.unite.vim {
  let g:unite_source_menu_menus.u = {
              \ 'description' : '    unite.vim        ⌘ [menu]u',
              \}
  let g:unite_source_menu_menus.u.command_candidates = [
              \['►    ➞  unite sources',
              \'Unite source'],
              \]
  nnoremap <silent>[menu]u :Unite -silent
              \ menu:u<CR>
  " }

  " [menu]v : menu.vim {
  let g:unite_source_menu_menus.v = {
              \ 'description' : '    vim              ⌘ [menu]v',
              \}
  let g:unite_source_menu_menus.v.command_candidates = [
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
  nnoremap <silent>[menu]v :Unite -silent
              \ menu:v<CR>
  " }
" }
