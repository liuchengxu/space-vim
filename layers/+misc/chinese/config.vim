scriptencoding utf-8

if g:spacevim.gui

  " 解决菜单栏乱码
  let $LANG = 'zh_CN.UTF-8'
  set langmenu=zh_CN
  source $VIMRUNTIME/delmenu.vim
  source $VIMRUNTIME/menu.vim

  " windows GUI界面乱码设置
  if g:spacevim.os.windows
      "处理consle输出乱码
      language messages zh_CN.utf-8
      " Set extra options when running in GUI mode
      set guifont=Consolas:h13
      set guitablabel=%M\ %t
      set linespace=2
      set noimdisable
  elseif g:spacevim.os.mac
      set guifont=Source\ Code\ Pro\ for\ Powerline:h12
  endif

endif
