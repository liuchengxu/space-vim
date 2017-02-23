scriptencoding utf-8

" ctrlp.vim {
    let g:ctrlp_working_path_mode = 'ra'	" search for nearest ancestor like .git, .hg, and the directory of the current file
    let g:ctrlp_match_window_bottom = 0		" show the match window at the top of the screen
    let g:ctrlp_by_filename = 1
    let g:ctrlp_max_height = 10				" maxiumum height of match window
    let g:ctrlp_switch_buffer = 'et'		" jump to a file if it's open already
    let g:ctrlp_regexp = 1
    let g:ctrlp_use_caching = 1				" enable caching
    let g:ctrlp_clear_cache_on_exit=0  		" speed up by not removing clearing cache evertime
    let g:ctrlp_mruf_max = 250 				" number of recently opened files
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlP'
    let g:ctrlp_follow_symlinks=1
    let g:ctrlp_mruf_relative = 1
    let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*'
    let g:ctrlp_custom_ignore = {
                \   'dir':  '\v[\/]\.(git|hg|svn|build)$',
                \   'file': '\v\.(exe|so|dll|zip|tar|tar.gz)$',
                \   'link': 'SOME_BAD_SYMBOLIC_LINKS',
                \ }

    " If ag available, use it to replace grep
    if executable('ag')
        " Use Ag over Grep
        set grepprg=ag\ --nogroup\ --nocolor
        " Use ag in CtrlP for listing files.
        let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
        " Ag is fast enough that CtrlP doesn't need to cache
        let g:ctrlp_use_caching = 0
    else
        let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
    endif

    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
    nnoremap <Leader>fr :CtrlPMRU<CR>
    nnoremap <C-p> :CtrlP<CR>
" }

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
