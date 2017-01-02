scriptencoding utf-8

function! SpacevimBuffers()
    if exists(':Buffers')
        execute 'Buffers'
    elseif exists('g:loaded_unite')
        execute 'Unite -start-insert buffer'
    elseif exists('g:loaded_ctrlp')
        execute 'CtrlPBuffer'
    else
        execute 'buffers'
    endif
endfunction

function! SpacevimCommands()
    if exists(':Commands')
        execute 'Commands'
    elseif exists('g:loaded_unite')
        execute 'Unite -start-insert command'
    else
        execute 'call feedkeys(":\<Tab>")'
    endif
endfunction

function! SpacevimCommentLine()
    if exists('g:loaded_commentary')
        execute 'call feedkeys(":CommentaryLine\<CR>")'
    elseif exists('g:loaded_nerd_comments')
        execute 'call NERDComment("n", "Toggle")'
    endif
endfunction

function! SpacevimCommentOperator(visual)
    if exists('g:loaded_commentary')
        if a:visual
            execute 'call feedkeys(":''<,''>Commentary\<CR>")'
        else
            execute 'call feedkeys(":Commentary\<CR>")'
        endif
    elseif exists('g:loaded_nerd_comments')
        if a:visual
            execute 'call NERDComment("v", "Toggle")'
        else
            execute 'call NERDComment("n", "Toggle")'
        endif
    endif
endfunction

function! SpacevimExplorerToggle()
    if exists(':NERDTreeToggle')
        execute 'NERDTreeToggle'
    elseif exists('g:loaded_dirvish')
        execute 'Dirvish'
    elseif exists('g:loaded_vimfiler')
        execute 'VimFiler'
    else
        execute 'Lexplore'
    endif
endfunction

if IsDir('syntastic')
    function! SpacevimErrorList()
        let l:old_last_winnr = winnr('$')
        SyntasticToggleMode
        if l:old_last_winnr == winnr('$')
            " Nothing was closed, open syntastic error location panel
            SyntasticCheck
        endif
    endfunction
endif


" fixes some weirdness in the case of only one error
" SEE: https://github.com/scrooloose/syntastic/issues/32
" also causes it to cycle around, which is quite nice!
function! SpacevimErrorPrev()
    try
        lprev
    catch /^Vim\%((\a\+)\)\=:E553/
        llast
    endtry
endfunction

function! SpacevimErrorNext()
    try
        lnext
    catch /^Vim\%((\a\+)\)\=:E553/
        lfirst
    endtry
endfunction

function! SpacevimFindFiles()
    if exists(':Files')
        execute 'Files %:h'
    elseif exists('g:loaded_unite')
        execute 'Unite -start-insert file'
    elseif exists('g:loaded_ctrlp')
        execute 'CtrlPCurFile'
    endif
endfunction

function! SpacevimGitLog()
    if exists(':GV')
        execute 'GV'
    else
        execute 'silent! Glog<CR>:bot copen'
    endif
endfunction

function! SpacevimKillBuffer()
    if exists(':Bdelete')
        " https://github.com/moll/vim-bbye
        execute 'Bdelete'
    else
        execute 'bdelete'
    endif
endfunction

function! SpacevimKillOtherBuffers()
    if confirm('Killing all buffers except "'. @% . '"?')
        " see https://github.com/vim-scripts/BufOnly.vim/blob/master/plugin/BufOnly.vim
        let buffer = bufnr('%')
        let last_buffer = bufnr('$')

        let delete_count = 0
        let n = 1
        while n <= last_buffer
            if n != buffer && buflisted(n)
                if getbufvar(n, '&modified')
                    echohl ErrorMsg
                    echomsg 'No write since last change for buffer'
                                \ n
                    echohl None
                else
                    silent exe 'bdel ' . n
                    if ! buflisted(n)
                        let delete_count = delete_count+1
                    endif
                endif
            endif
            let n = n+1
        endwhile

        if delete_count == 1
            echomsg delete_count 'Buffer deleted'
        elseif delete_count > 1
            echomsg delete_count 'Buffers deleted'
        endif
    endif
endfunction

function! SpacevimMaximizeBuffer()
    if exists('s:maximize_session')
        exec 'source ' . s:maximize_session
        call delete(s:maximize_session)
        unlet s:maximize_session
        let &hidden=s:maximize_hidden_save
        unlet s:maximize_hidden_save
    else
        let s:maximize_hidden_save = &hidden
        let s:maximize_session = tempname()
        set hidden
        exec 'mksession! ' . s:maximize_session
        only
    endif
endfunction

function! SpacevimProjectDirectory()
    if exists(':ProjectRootExe')
        if exists(':NERDTreeToggle')
            execute 'ProjectRootExe NERDTreeToggle'
        elseif exists('g:loaded_dirvish')
            execute 'ProjectRootExe Dirvish'
        elseif exists('g:loaded_vimfiler')
            execute 'ProjectRootExe VimFiler'
        else
            execute 'ProjectRootExe Lexplore'
        endif
    else
        call SpacevimExplorerToggle()
    endif
endfunction

function! SpacevimProjectFindFile()
    if exists(':GitFiles')
        execute 'GitFiles'
    elseif exists('g:loaded_unite')
        execute 'UniteWithProjectDir -start-insert file_rec/async'
    elseif exists('g:loaded_ctrlp')
        execute 'CtrlPRoot'
    endif
endfunction

function! SpacevimProjectInvalidateCache()
    if exists('g:loaded_unite')
        execute 'call feedkeys(":UniteWithProjectDir\<CR>\<C-l>\<Esc>")'
    elseif exists('g:loaded_ctrlp')
        execute 'CtrlPClearCache'
    endif
endfunction

function! SpacevimRecentf()
    if exists(':History')
        execute 'History'
    elseif exists('g:loaded_unite')
        execute 'Unite -start-insert file_mru'
    elseif exists('g:loaded_ctrlp')
        execute 'CtrlPMRU'
    else
        execute 'oldfiles'
    endif
endfunction

function! SpacevimSmartSearchWithInput(visual)
    if a:visual
        execute 'Ag ' . <SID>spacevim_get_visual_selection()
    else
        execute 'Ag ' . expand('<cword>')
    endif
endfunction

function! SpacevimToggleSyntax()
    if exists('g:syntax_on')
        syntax off
    else
        syntax enable
    endif
endfunction

function! SpacevimToggleWrap()
    if &formatoptions =~# 't'
        setlocal formatoptions-='t'
    else
        setlocal formatoptions+='t'
    endif
endfunction
