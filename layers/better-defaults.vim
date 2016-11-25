" space-vim-dark {
if isdirectory(expand("~/.vim/plugged/space-vim-dark"))
    color space-vim-dark
endif
" }

" vim-airline {
if isdirectory(expand("~/.vim/plugged/vim-airline"))
    " let g:airline_theme="luna"
    let g:airline_theme="violet"
    " let g:airline_theme="powerlineish"
    let g:Powerline_symbols="fancy"
    " use powerline font. If not, let g:airline_powerline_fonts=0
    let g:airline_powerline_fonts=1
    let g:airline#extensions#default#layout = [
                \ [ 'a', 'b', 'c' ],
                \ [ 'x', 'y', 'z', 'error', 'warning' ]
                \ ]
    " let g:airline_section_x = '%>%ft'
    let g:airline#extensions#tabline#enabled=1
    let g:airline#extensions#tabline#buffer_nr_show=1
    " let g:airline#extensions#whitespce#enabled=0
    " let g:airline#extensions#whitespace#symbol='!'
    " let g:airline#extensions#whitespace#mixed_indent_algo=2
    if !exists('g:airline_powerline_fonts')
        let g:airline_left_sep='>'
        let g:airline_right_sep='<'
    endif
endif

" }

" ultisnips {
if isdirectory(expand("~/.vim/plugged/ultisnips"))
    " Set ultisnips triggers
    let g:UltiSnipsSnippetDirectories=['UltiSnips']
    let g:UltiSnipsSnippetsDir = '~/.vim/plugged/vim-snippets/UltiSnips/'
    let g:UltiSnipsListSnippets = '<C-Tab>'
    let g:UltiSnipsJumpForwardTrigger = '<Tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
    " 解决ultisnips与YCM 的tab键补全冲突
    " ultisnips选中后按enter键进行补全
    let g:UltiSnipsExpandTrigger = "<nop>"
    let g:ulti_expand_or_jump_res = 0
    function! ExpandSnippetOrCarriageReturn()
        let snippet = UltiSnips#ExpandSnippetOrJump()
        if g:ulti_expand_or_jump_res > 0
            return snippet
        else
            return "\<CR>"
        endif
    endfunction
    inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
endif
" }



" vim-startify {
if isdirectory(expand("~/.vim/plugged/vim-startify"))
    let g:startify_custom_header = [
                \ '          ................  *&(      ............        ',
                \ '         &................&      (  *..............*&    ',
                \ '         *.............../       (  (............../*    ',
                \ '          // .........////           ,//,.........//     ',
                \ '             .........//            . &.........//       ',
                \ '             .........//          . (.........(/         ',
                \ '             .........//        . /.. ....... /          ',
                \ '             .........//       ,.......... /             ',
                \ '             .........//    * .......... /   &(          ',
                \ '             ........//   ,  .........&/       &(        ',
                \ '         *   ........// ,  ..........#/  &         (     ',
                \ '       **    ......../(  ..........*/                (   ',
                \ '     //      ......./ ...........*/                   &# ',
                \ '       &     .................,/                    &    ',
                \ '         &   ................/..                   &     ',
                \ '             .............. ...                 &        ',
                \ '             ............/#     .             &          ',
                \ '             ........../       .    .....     .....      ',
                \ '             ......../(........   ..................     ',
                \ '             ......(/    ...,    ...     ...    ,...     ',
                \ '             ....(/     ....    ...(  & ...     ...      ',
                \ '             .. /       ...     ... &  (...    ...,      ',
                \ '             /     &  ...,&   ...     ...    #...        ',]
    autocmd VimEnter * if !argc() | Startify | endif
    nnoremap <silent><Leader>bh :Startify<CR>
    nnoremap <silent><Leader>fr :Startify<CR>
endif
" }

" vim-easymotion {
" <Leader><Leader>w : word, 在单词间移动，往前
" <Leader><Leader>b : back, 在单词间移动，往后
" <Leader><Leader>s : search, 字符搜索跳转，双向
" <leader><Leader>f : forward, 向前搜索字符
" <Leader><Leader>j
" <Leader><Leader>k
" Jump to line
map <Leader>jl <Plug>(easymotion-bd-jk)
nmap <Leader>jl <Plug>(easymotion-overwin-line)
" Jump to word
map  <Leader>jw <Plug>(easymotion-bd-w)
nmap <Leader>jw <Plug>(easymotion-overwin-w)
" }

" nerdtree {
if isdirectory(expand("~/.vim/plugged/nerdtree"))
    let NERDTreeShowHidden=1            " 显示隐藏文件
    let NERDTreeAutoDeleteBuffer=1      " 删除文件时自动删除文件对应buffer
    let NERDTreeIgnore=[
                \ '\.py[cd]$', '\~$', '\.swo$', '\.swp$',
                \ '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$',
                \ ]
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

    map <F4> :NERDTreeToggle<CR>
    imap <F4> <ESC>:NERDTreeToggle<CR>
    nnoremap <Leader>ft :NERDTreeToggle<CR>
endif
" }

"nerdtree-git-plugin {
if isdirectory(expand("~/.vim/plugged/nerdtree-git-plugin"))
    let g:NERDTreeIndicatorMapCustom = {
                \ "Modified"  : "✹",
                \ "Staged"    : "✚",
                \ "Untracked" : "✭",
                \ "Renamed"   : "➜",
                \ "Unmerged"  : "═",
                \ "Deleted"   : "✖",
                \ "Dirty"     : "✗",
                \ "Clean"     : "✔︎",
                \ "Unknown"   : "?"
                \ }
endif
" }

" vim-nerdtree-syntax-highlight {
if isdirectory(expand("~/.vim/plugged/vim-nerdtree-syntax-highlight"))
    let g:NERDTreeFileExtensionHighlightFullName = 1
    let g:NERDTreeExactMatchHighlightFullName = 1
    let g:NERDTreePatternMatchHighlightFullName = 1
    let g:NERDTreeLimitedSyntax = 1
    " you can add these colors to your .vimrc to help customizing
    let s:brown = "905532"
    let s:aqua =  "3AFFDB"
    let s:blue = "689FB6"
    let s:darkBlue = "44788E"
    let s:purple = "834F79"
    let s:lightPurple = "834F79"
    let s:red = "AE403F"
    let s:beige = "F5C06F"
    let s:yellow = "F09F17"
    let s:orange = "D4843E"
    let s:darkOrange = "F16529"
    let s:pink = "CB6F6F"
    let s:salmon = "EE6E73"
    let s:green = "8FAA54"
    let s:lightGreen = "31B53E"
    let s:white = "FFFFFF"
    let s:rspec_red = 'FE405F'
    let s:git_orange = 'F54D27'
    let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
    let g:NERDTreeExtensionHighlightColor['css'] = s:blue " sets the color of css files to blue
    let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
    let g:NERDTreeExtensionHighlightColor['org'] = s:pink " sets the color of css files to blue
    let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
    let g:NERDTreeExtensionHighlightColor['tex'] = s:rspec_red " sets the color of css files to blue
    let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
    let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files
    let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
    let g:NERDTreeExactMatchHighlightColor['.ipynb'] = s:lightPurple " sets the color for .ipynb files
    let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
    let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb
endif
" }

" vim-ctrlp {
if isdirectory(expand("~/.vim/plugged/ctrlp.vim"))
    let g:ctrlp_working_path_mode = 'ra'	" search for nearest ancestor like .git, .hg, and the directory of the current file
    let g:ctrlp_match_window_bottom = 0		" show the match window at the top of the screen
    let g:ctrlp_by_filename = 1
    let g:ctrlp_max_height = 10				" maxiumum height of match window
    let g:ctrlp_switch_buffer = 'et'		" jump to a file if it's open already
    let g:ctrlp_use_caching = 1				" enable caching
    let g:ctrlp_clear_cache_on_exit=0  		" speed up by not removing clearing cache evertime
    let g:ctrlp_mruf_max = 250 				" number of recently opened files
    let g:ctrlp_custom_ignore = {
                \ 'dir':  '\v[\/]\.(git|hg|svn|build)$',
                \ 'file': '\v\.(exe|so|dll)$',
                \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
                \ }
    let g:ctrlp_match_window_bottom = 0		" show the match window at the top of the screen
    let g:ctrlp_by_filename = 1
    let g:ctrlp_max_height = 10				" maxiumum height of match window
    let g:ctrlp_switch_buffer = 'et'		" jump to a file if it's open already
    let g:ctrlp_regexp = 1
    " 如果ag可用，使用ag替换grep进行搜索
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
endif
" }

" delimitMate {
if isdirectory(expand("~/.vim/plugged/delimitMate"))
    let delimitMate_expand_cr=1
endif
" }

" vim-trailing-whitespace {
if isdirectory(expand("~/.vim/plugged/vim-trailing-whitespace"))
    nnoremap <Leader>xd :FixWhitespace<CR>
endif
" }
