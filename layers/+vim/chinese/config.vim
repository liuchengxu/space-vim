
if LayerLoaded('chinese')

    if has('gui_running')

        " 解决菜单栏乱码
        let $LANG = 'zh_CN.UTF-8'
        set langmenu=zh_CN
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim

        " windows GUI界面乱码设置
        if WINDOWS() && has('gui_running')
            "处理consle输出乱码
            language messages zh_CN.utf-8
            " Set extra options when running in GUI mode
            set guifont=Consolas:h13
            if has('gui_gtk2')
                set guifont=Monaco\ 12,Monospace\ 12
            endif
            set guitablabel=%M\ %t
            set linespace=2
            set noimdisable

        elseif OSX() && has('gui_running')
            set guifont=Source\ Code\ Pro\ for\ Powerline:h12
        endif
    endif

endif
