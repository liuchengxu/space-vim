scriptencoding utf-8

" Put the :hi command after any :colorscheme command,
" or the colorscheme can overwrite your highlighting.
silent! color space-vim-dark

augroup SPACEVIM_BASIC
    " Restore cursor position when opening file
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   execute "normal! g`\"" |
                \ endif

    autocmd BufReadPre *
                \   if getfsize(expand("%")) > 10000000 |
                \   syntax off |
                \   endif

    autocmd BufEnter * call MyLastWindow()
    function! MyLastWindow()
        " if the window is quickfix/locationlist go on
        if &buftype ==# 'quickfix' || &buftype ==# 'locationlist'
            " if this window is last on screen quit without warning
            if winbufnr(2) == -1
                quit!
            endif
        endif
    endfunction
augroup END

" Show trailing white space
hi ExtraWhitespace guifg=#FF2626 gui=underline ctermfg=198 cterm=underline
match ExtraWhitespace /\s\+$/

" Refer to http://vim.wikia.com/wiki/Show_tab_number_in_your_tab_line
if g:spacevim_gui_running
    set guioptions-=e
endif
function! MyTabLine()
    let l:s = ''
    let l:t = tabpagenr()
    let l:i = 1
    while l:i <= tabpagenr('$')
        let l:buflist = tabpagebuflist(l:i)
        let l:winnr = tabpagewinnr(l:i)
        let l:s .= '%' . l:i . 'T'
        let l:s .= (l:i == l:t ? '%1*' : '%2*')
        let l:s .= ' '
        let l:s .= 'T-' . l:i . ':'
        let l:s .= l:winnr . '/' . tabpagewinnr(l:i,'$') .'W'
        let l:s .= ' %*'
        let l:s .= (l:i == l:t ? '%#TabLineSel#' : '%#TabLine#')
        let l:bufnr = l:buflist[l:winnr - 1]
        let l:file = bufname(l:bufnr)
        let l:buftype = getbufvar(l:bufnr, 'buftype')
        if l:buftype ==# 'nofile'
            if l:file =~# '\/.'
                let l:file = substitute(l:file, '.*\/\ze.', '', '')
            endif
        else
            let l:file = fnamemodify(l:file, ':p:t')
        endif
        if l:file ==# ''
            let l:file = '[No Name]'
        endif
        let l:s .= l:file
        let l:i = l:i + 1
    endwhile
    let l:s .= '%T%#TabLineFill#%='
    let l:s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return l:s
endfunction
silent! set showtabline=1
silent! set tabline=%!MyTabLine()

" The decoration of statusline was stealed from
" https://github.com/junegunn/dotfiles/blob/master/vimrc.
"
" %< Where to truncate
" %n buffer number
" %F Full path
" %m Modified flag: [+], [-]
" %r Readonly flag: [RO]
" %y Type:          [vim]
" fugitive#statusline()
" %= Separator
" %-14.(...)
" %l Line
" %c Column
" %V Virtual column
" %P Percentage
" %#HighlightGroup#
if !core_config#LayerLoaded('airline') && !core_config#LayerLoaded('lightline')

    function! S_buf_num()
        let l:circled_num_list = ['① ', '② ', '③ ', '④ ', '⑤ ', '⑥ ', '⑦ ', '⑧ ', '⑨ ', '⑩ ',
                    \             '⑪ ', '⑫ ', '⑬ ', '⑭ ', '⑮ ', '⑯ ', '⑰ ', '⑱ ', '⑲ ', '⑳ ']

        return bufnr('%') > 20 ? bufnr('%') : l:circled_num_list[bufnr('%')-1]
    endfunction

    function! S_buf_total_num()
        return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
    endfunction

    function! S_file_size(f)
        let l:size = getfsize(expand(a:f))
        if l:size == 0 || l:size == -1 || l:size == -2
            return ''
        endif
        if l:size < 1024
            return l:size.' bytes'
        elseif l:size < 1024*1024
            return printf('%.1f', l:size/1024.0).'k'
        elseif l:size < 1024*1024*1024
            return printf('%.1f', l:size/1024.0/1024.0) . 'm'
        else
            return printf('%.1f', l:size/1024.0/1024.0/1024.0) . 'g'
        endif
    endfunction


    function! S_full_path()
        if &filetype ==# 'startify'
            return ''
        else
            return expand('%:p:t')
        endif
    endfunction

    function! S_ale_error()
        if !exists('g:loaded_ale')
            return ''
        endif
        return !empty(ALEGetError())?ALEGetError():''
    endfunction

    function! S_ale_warning()
        if !exists('g:loaded_ale')
            return ''
        endif
        return !empty(ALEGetWarning())?ALEGetWarning():''
    endfunction

    function! S_fugitive()
        if !exists('g:loaded_fugitive')
            return ''
        endif
        let l:head = fugitive#head()
        return empty(l:head) ? '' : ' ⎇ '.l:head . ' '
    endfunction

    let s:job_status = {}
    function! S_git_status()
        if g:spacevim_vim8
            if !exists('g:loaded_fugitive')
                return ''
            endif
            let l:roots = values(s:job_status)
            let l:root = fugitive#head()
            if index(roots, root) >= 0
                return ''
            endif
            let job_id = jobstart(['git-status'], {
                \ 'cwd': root,
                \ 'on_stdout': function('s:JobHandler', [root]),
                \ 'on_stderr': function('s:JobHandler', [root]),
                \ 'on_exit': function('s:JobHandler', [root])
                \})
            if job_id == 0 || job_id == -1 | return '' | endif
            let s:job_status[job_id] = root
            return ''
        endif
    endfunction

    function! MyStatusLine()

        if g:spacevim_gui_running
            let l:buf_num = '%1* [B-%n] [W-%{winnr()}] %*'
        else
            let l:buf_num = '%1* %{S_buf_num()} ❖ %{winnr()} %*'
        endif
        let l:tot = '%2*[TOT:%{S_buf_total_num()}]%*'
        let l:fs = '%3* %{S_file_size(@%)} %*'
        let l:fp = '%4* %{S_full_path()} %*'
        let l:paste = "%#paste#%{&paste?'⎈ paste ':''}%*"
        let l:ale_e = '%#ale_error#%{S_ale_error()}%*'
        let l:ale_w = '%#ale_warning#%{S_ale_warning()}%*'
        let l:git = '%6*%{S_fugitive()}%*'
        let l:m_r_f = '%7* %m%r%y %*'
        let l:ff = '%8* %{&ff} |'
        let l:enc = " %{''.(&fenc!=''?&fenc:&enc).''} | %{(&bomb?\",BOM\":\"\")}"
        let l:pos = '%l:%c%V %*'
        let l:pct = '%9* %P %*'

        return l:buf_num.l:tot.'%<'.l:fs.l:fp.l:git.l:paste.l:ale_e.l:ale_w.
                    \   '%='.l:m_r_f.l:ff.l:enc.l:pos.l:pct
    endfunction
    " See the statusline highlightings in s:post_user_config() of core/autoload/core_config.vim

    " Note that the "%!" expression is evaluated in the context of the
    " current window and buffer, while %{} items are evaluated in the
    " context of the window that the statusline belongs to.
    set statusline=%!MyStatusLine()
endif
