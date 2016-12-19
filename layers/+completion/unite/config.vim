scriptencoding utf-8
if LayerLoaded('unite')

    " if ctrlp.vim {
    if IsDir('ctrlp.vim')
        let g:ctrlp_map = '<c-p>'
        let g:ctrlp_cmd = 'CtrlP'
        let g:ctrlp_custom_ignore = {
                    \ 'dir':  '\v[\/](node_modules|target|dist)|\.(git|hg|svn|rvm)$',
                    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz)$',
                    \ }
        let g:ctrlp_follow_symlinks=1
        let g:ctrlp_mruf_relative = 1
        let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*'
        nnoremap <Leader>fr :CtrlPMRU<CR>
    endif
    " }

    " unite.vim {
    if IsDir('unite.vim')
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
                    \['    ➞  show-hidden-chars',
                    \'set list!'],
                    \['x d ➞  delete-trailing-whitespaces                         ⌘ <Leader> x d',
                    \'FixWhitespace'],
                    \['a | ➞  align-repeat-bar                                    ⌘ <Leader> a |',
                    \'Tabularize /|'],
                    \['a = ➞  align-repeat-equal                                  ⌘ <Leader> a =',
                    \'Tabularize /^[^=]*\zs='],
                    \['s c ➞  cancel-highlight-of-searched-result                 ⌘ <Leader> s c',
                    \'nohl'],
                    \['t p ➞  toggle-paste-mode                                   ⌘ <Leader> t p',
                    \'setlocal paste!'],
                    \]
        nnoremap <silent>[menu]x :Unite -silent -winheight=20
                    \ menu:x<CR>
        " }

        " [menu]f : menu.files {
        let g:unite_source_menu_menus.f = {
                    \ 'description' : '    fzf.vim          ⌘ [menu]f',
                    \}
        " supported by fzf.vim
        let g:unite_source_menu_menus.f.command_candidates = [
                    \['▷   ➞  Buffers',
                    \'Buffers'],
                    \['▷   ➞  Files',
                    \'Files'],
                    \['▷   ➞  Windows',
                    \'Windows'],
                    \['▷   ➞  Maps',
                    \'Maps'],
                    \['▷   ➞  History',
                    \'History'],
                    \]
        nnoremap <silent>[menu]f :Unite -silent -winheight=20
                    \ menu:f<CR>
        " }

        " [menu]p : menu.plugins {
        let g:unite_source_menu_menus.p = {
                    \ 'description' : '    plugins          ⌘ [menu]s',
                    \}
        let g:unite_source_menu_menus.p.command_candidates = [
                    \['▷  ➞  install-plugin                                    (vim-plug)',
                    \'PlugInstall'],
                    \['▷  ➞  clean-plugin                                      (vim-plug)',
                    \'PlugClean'],
                    \['▷  ➞  update-plugin                                     (vim-plug)',
                    \'PlugUpdate'],
                    \['▷  ➞  syntastic-check                                   (syntastic)',
                    \'SyntasticCheck'],
                    \['▷  ➞  syntastic-info                                    (syntastic)',
                    \'SyntasticInfo'],
                    \['▷  ➞  syntastic-reset                                   (syntastic)',
                    \'SyntasticReset'],
                    \['▷  ➞  syntastic-errors                                  (syntastic)',
                    \'Errors'],
                    \['▷  ➞  ycm-restart-server                                (youcompleteme)',
                    \'YcmRestartServer'],
                    \['▷  ➞  generate-markdown-toc                             (vim-markdown-toc)',
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
                    \['▷  ➞  nerdtree                                          (plugin)       ⌘ <F3>',
                    \'NERDTreeToggle'],
                    \['▷  ➞  tagbar                                            (plugin)       ⌘ <F6>',
                    \'TagbarToggle'],
                    \['▷  ➞  syntastic                                         (plugin)       ⌘',
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
                    \['▷  ➞  unite sources',
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
                    \['▷  ➞  .vimrc',
                    \'e ~/.vimrc'],
                    \['▷  ➞  .spacevim',
                    \'e ~/.spacevim'],
                    \['▷  ➞  vim-help',
                    \'Unite help -start-insert'],
                    \['▷  ➞  vim-commands',
                    \'Unite command -start-insert'],
                    \['▷  ➞  vim-mappings',
                    \'Unite mapping -start-insert'],
                    \['▷  ➞  vim-functions',
                    \'Unite function -start-insert'],
                    \['▷  ➞  vim-runtimepath',
                    \'Unite runtimepath -start-insert '],
                    \['▷  ➞  vim-command-output',
                    \'Unite output'],
                    \]
        nnoremap <silent>[menu]v :Unite -silent
                    \ menu:v<CR>
        " }
    endif
    " }
endif
