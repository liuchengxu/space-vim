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

scriptencoding utf-8

let g:spacevim_base_dir = '~/.space-vim'
let g:spacevim_core_dir = '/core'

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

if exists('g:spacevim_leader')
    let g:mapleader=g:spacevim_leader
else
    let g:mapleader = "\<Space>"
endif

if exists('g:spacevim_localleader')
    let g:maplocalleader=g:spacevim_localleader
else
    let g:maplocalleader = ','
endif

call Source(g:spacevim_base_dir . g:spacevim_core_dir . '/core_config.vim')

""""""""""""""""""""""""""""""""""""""""""""""
" Load layers
""""""""""""""""""""""""""""""""""""""""""""""
call LayersBegin()

Layer 'fzf'
Layer 'ycmd'
Layer 'html'
Layer 'unite'
Layer 'emoji'
Layer 'c-c++'
Layer 'colors'
Layer 'python'
Layer 'airline'
Layer 'markdown'
Layer 'text-align'
Layer 'programming'
Layer 'better-defaults'
Layer 'syntax-checking'

call LayersEnd()
"""""""""""""""""""""""""""""""""""""""""""""
