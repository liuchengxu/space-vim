if LayerLoaded('lightline')

    " lightline.vim {
    "if IsDir('lightline.vim')
    "    let g:lightline = {
    "                \ 'colorscheme': 'wombat',
    "                \ }
    "endif
    let g:lightline = {
                \ 'active': {
                \ 'colorscheme': g:colors_name,
                \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
                \   'right': [ [ 'syntastic', 'ale', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
                \ },
                \ 'component_function': {
                \   'fugitive': 'LightlineFugitive',
                \   'filename': 'LightlineFilename',
                \   'fileformat': 'LightlineFileformat',
                \   'filetype': 'LightlineFiletype',
                \   'fileencoding': 'LightlineFileencoding',
                \   'mode': 'LightlineMode',
                \   'ctrlpmark': 'CtrlPMark',
                \ },
                \ 'component_expand': {
                \   'syntastic': 'SyntasticStatuslineFlag',
                \   'ale': 'ALEGetStatusLine',
                \ },
                \ 'component_type': {
                \   'syntastic': 'error',
                \   'ale': 'error',
                \ },
                \ 'separator': { 'left': '❯', 'right': '❮' },
                \ 'subseparator': { 'left': '〉', 'right': '〈' }
                \ }

    "based on https://github.com/itchyny/lightline.vim/issues/104
    function! LightlineSwitchTheme(theme)
        " Firstly set the new colorscheme
        try
            let g:lightline.colorscheme = a:theme
        catch
            call lightline#error('Could not load colorscheme ' . g:lightline.colorscheme . '.')
            let g:lightline.colorscheme = 'default'
        endtry
        " Secondly tell the lightline to load the settings of g:lightline
        call lightline#init()

        " Thirdly generate the colors based on the value of g:lightline.colorscheme
        call lightline#colorscheme()

        " Lastly update all the statusline of the windows
        call lightline#update()
    endfunction

    function! LightlineModified()
        return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction

    function! LightlineReadonly()
        return &ft !~? 'help' && &readonly ? '' : ''
    endfunction

    function! LightlineFilename()
        let fname = expand('%:t')
        return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
                    \ fname == '__Tagbar__' ? g:lightline.fname :
                    \ fname =~ '__Gundo\|NERD_tree' ? '' :
                    \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
                    \ &ft == 'unite' ? unite#get_status_string() :
                    \ &ft == 'vimshell' ? vimshell#get_status_string() :
                    \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
                    \ ('' != fname ? fname : '[No Name]') .
                    \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
    endfunction

    function! LightlineFugitive()
        try
            if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
                let mark = ''  " edit here for cool mark
                let branch = fugitive#head()
                return branch !=# '' ? mark.branch : ''
            endif
        catch
        endtry
        return ''
    endfunction

    function! LightlineFileformat()
        return winwidth(0) > 70 ? &fileformat : ''
    endfunction

    function! LightlineFiletype()
        return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
    endfunction

    function! LightlineFileencoding()
        return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
    endfunction

    function! LightlineMode()
        let fname = expand('%:t')
        return fname == '__Tagbar__' ? 'Tagbar' :
                    \ fname == 'ControlP' ? 'CtrlP' :
                    \ fname == '__Gundo__' ? 'Gundo' :
                    \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
                    \ fname =~ 'NERD_tree' ? 'NERDTree' :
                    \ &ft == 'unite' ? 'Unite' :
                    \ &ft == 'vimfiler' ? 'VimFiler' :
                    \ &ft == 'vimshell' ? 'VimShell' :
                    \ winwidth(0) > 60 ? lightline#mode() : ''
    endfunction

    function! CtrlPMark()
        if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
            call lightline#link('iR'[g:lightline.ctrlp_regex])
            return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
                        \ , g:lightline.ctrlp_next], 0)
        else
            return ''
        endif
    endfunction

    let g:ctrlp_status_func = {
                \ 'main': 'CtrlPStatusFunc_1',
                \ 'prog': 'CtrlPStatusFunc_2',
                \ }

    function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
        let g:lightline.ctrlp_regex = a:regex
        let g:lightline.ctrlp_prev = a:prev
        let g:lightline.ctrlp_item = a:item
        let g:lightline.ctrlp_next = a:next
        return lightline#statusline(0)
    endfunction

    function! CtrlPStatusFunc_2(str)
        return lightline#statusline(0)
    endfunction

    let g:tagbar_status_func = 'TagbarStatusFunc'

    function! TagbarStatusFunc(current, sort, fname, ...) abort
        let g:lightline.fname = a:fname
        return lightline#statusline(0)
    endfunction

    augroup AutoSyntastic
        autocmd!
        autocmd BufWritePost *.c,*.cpp call s:syntastic()
    augroup END
    function! s:syntastic()
        SyntasticCheck
        call lightline#update()
    endfunction

    let g:unite_force_overwrite_statusline = 0
    let g:vimfiler_force_overwrite_statusline = 0
    let g:vimshell_force_overwrite_statusline = 0

    " }
endif

