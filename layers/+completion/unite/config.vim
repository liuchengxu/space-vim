scriptencoding utf-8

" unite.vim {
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

  let g:unite_source_menu_menus = g:spacevim#plug#unite#menus

  " menu prefix key (for all Unite menus)
  nnoremap [menu] <Nop>
  nmap <LocalLeader> [menu]

  " unite.vim useful resources:
  " https://github.com/joedicastro/dotfiles/tree/master/vim
  " unite prefix: LocalLeader=','
  " menus menu
  nnoremap <silent>[menu]m :Unite -silent -winheight=40 menu<CR>

  nnoremap <silent>[menu]x :Unite -silent -winheight=20
              \ menu:x<CR>
  nnoremap <silent>[menu]f :Unite -silent -winheight=20
              \ menu:f<CR>
  nnoremap <silent>[menu]p :Unite -silent
              \ menu:p<CR>
  nnoremap <silent>[menu]t :Unite -silent
              \ menu:t<CR>
  nnoremap <silent>[menu]u :Unite -silent
              \ menu:u<CR>
  nnoremap <silent>[menu]v :Unite -silent
              \ menu:v<CR>
" }
