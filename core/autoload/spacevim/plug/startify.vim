scriptencoding utf-8

function! s:get_nvim_version()
    redir => l:s
    silent! version
    redir END
    return matchstr(l:s, 'NVIM v\zs[^\n]*')
endfunction

let s:version = g:spacevim_nvim ? 'nvim '.s:get_nvim_version() : 'vim '.v:version
let g:spacevim#plug#startify#header = [
            \'                                             _',
            \'         ___ _ __   __ _  ___ ___     __   _(_)_ __ ___',
            \'        / __| -_ \ / _- |/ __/ _ \____\ \ / / | -_ - _ \',
            \'        \__ \ |_) | (_| | (_|  __/_____\ V /| | | | | | |',
            \'        |___/ .__/ \__._|\___\___|      \_/ |_|_| |_| |_|',
            \'            |_|',
            \'                  [ space-vim ' . g:spacevim_version . ' ＠' . s:version . ' ]',
            \]

let g:spacevim#plug#startify#list_order = [
            \ ['   Recent Files:'],
            \ 'files',
            \ ['   Project:'],
            \ 'dir',
            \ ['   Sessions:'],
            \ 'sessions',
            \ ['   Bookmarks:'],
            \ 'bookmarks',
            \ ['   Commands:'],
            \ 'commands',
            \ ]
