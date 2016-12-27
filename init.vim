"                                           _
"       ___ _ __   __ _  ___ ___     __   _(_)_ __ ___
"      / __| -_ \ / _- |/ __/ _ \____\ \ / / | -_ - _ \
"      \__ \ |_) | (_| | (_|  __/_____\ V /| | | | | | |
"      |___/ .__/ \__._|\___\___|      \_/ |_|_| |_| |_|
"          |_|
"
"   You can customize spacevim with .spacevim
"   and don't have to take care of this file.
"
"   Author: Liu-Cheng Xu <xuliuchengxlc@gmail.com>
"   URL: https://github.com/liuchengxu/space-vim
"
"   Copyright © 2016 Liu-Cheng Xu

scriptencoding utf-8

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

    " Windows Compatible {
    " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
    " across (heterogeneous) systems easier.
    if WINDOWS()
        set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    endif
    " }

    silent function! Source(file)
        if filereadable(expand(a:file))
            execute 'source ' . fnameescape(a:file)
        else
            echom '[space-vim] ' . a:file . ' does not exist, which may cause unexpected errors.'
        endif
    endfunction

" }

let g:spacevim_dir = $HOME.'/.space-vim'
let g:spacevim_core_dir = '/core'
let g:spacevim_version = '0.5.0'

call Source(g:spacevim_dir . g:spacevim_core_dir . '/core_config.vim')

call LayersBegin()

" Default layers
Layer 'fzf'
Layer 'unite'
Layer 'better-defaults'

call LayersEnd()
