"                                           _
"       ___ _ __   __ _  ___ ___     __   _(_)_ __ ___
"      / __| -_ \ / _- |/ __/ _ \____\ \ / / | -_ - _ \ 
"      \__ \ |_) | (_| | (_|  __/_____\ V /| | | | | | |
"      |___/ .__/ \__._|\___\___|      \_/ |_|_| |_| |_|
"          |_|
"
"   This is the personal .vimrc file of Liu-Cheng Xu.
"   Considering it is beneficial for general use, I would
"   recommend picking out the parts you want and understand.
"
"   Author: Liu-Cheng Xu <xuliuchengxlc@gmail.com>
"   URL: https://github.com/liuchengxu/space-vim
"
"   Copyright © 2016 Liu-Cheng Xu
"
"

let g:spacevim_base_dir = "~/.space-vim"
let g:spacevim_core_dir = "/core"

" Tools {

    " Identify platform {
    silent function! OSX()
        return has('macunix')
    endfunction
    silent function! LINUX()
        return has('unix') && !has('macunix') && !has('win32unix')
    endfunction
    silent function! WINDOWS()
        return (has('win32') || has('win64'))
    endfunction
    " }

    silent function! Source(file)
        if filereadable(expand(a:file))
            execute "source " . fnameescape(a:file)
        else
            echom a:file . ' does not exist, which may cause unexpected errors.'
        endif
    endfunction

    function! LoadPrivateConfig(relative_path)
        let s:config_file = g:spacevim_base_dir . a:relative_path
        if filereadable(expand(s:config_file))
            execute "source " . fnameescape(s:config_file)
        endif
    endfunction


" }

call LoadPrivateConfig("/private/before_vimrc.vim")

if exists('g:spacevim_leader')
    let mapleader=g:spacevim_leader
else
    let mapleader = "\<Space>"
endif

if exists('g:spacevim_localleader')
    let maplocalleader=g:spacevim_localleader
else
    let maplocalleader = ','
endif

call Source(g:spacevim_base_dir . g:spacevim_core_dir . '/core_config.vim')

""""""""""""""""""""""""""""""""""""""""""""""
" Put layer here you want to load
""""""""""""""""""""""""""""""""""""""""""""""
call LayersBegin()

Layer 'fzf'
Layer 'ycmd'
Layer 'unite'
Layer 'emoji'
Layer 'c-c++'
Layer 'colors'
Layer 'python'
Layer 'markdown'
Layer 'text-align'
Layer 'programming'
Layer 'better-defaults'
Layer 'syntax-checking'

call LayersEnd()
"""""""""""""""""""""""""""""""""""""""""""""
