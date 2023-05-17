"                                           _
"       ___ _ __   __ _  ___ ___     __   _(_)_ __ ___
"      / __| -_ \ / _- |/ __/ _ \____\ \ / / | -_ - _ \
"      \__ \ |_) | (_| | (_|  __/_____\ V /| | | | | | |
"      |___/ .__/ \__._|\___\___|      \_/ |_|_| |_| |_|
"          |_|
"
"   Copyright (c) 2017 Liu-Cheng Xu & Contributors
"
"   You can customize space-vim with .spacevim
"   and don't have to take care of this file.
"
"   Author: Liu-Cheng Xu <xuliuchengxlc@gmail.com>
"   URL: https://github.com/liuchengxu/space-vim
"   License: MIT

scriptencoding utf-8

let g:spacevim = get(g:, 'spacevim', {})
let g:spacevim.base = fnamemodify(resolve(expand('<sfile>:p')),':h')
let g:spacevim.version = '0.9.0'

" Identify platform {
let g:spacevim.os = {}
let g:spacevim.os.mac = has('macunix')
let g:spacevim.os.linux = has('unix') && !has('macunix') && !has('win32unix')
let g:spacevim.os.windows = has('win32')
" }

" Windows Compatible {
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if g:spacevim.os.windows
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif
" }


""
"" core runtimepath
""

let &runtimepath = &runtimepath . ',' . g:spacevim.base . '/core'


""
"" plug.vim runtimepath
""

let g:spacevim_plugvim_cachepath = '~/.cache/space-vim'
let g:spacevim_plugvim_runtimepath = g:spacevim_plugvim_cachepath . '/site'
let g:spacevim_plugvim_filepath = g:spacevim_plugvim_runtimepath . '/autoload/plug.vim'

let &runtimepath = g:spacevim_plugvim_runtimepath . ',' . &runtimepath


""
"" bootstrap
""

call spacevim#bootstrap()
