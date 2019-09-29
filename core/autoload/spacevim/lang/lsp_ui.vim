if !hlexists('DefinitionNotFound')
  hi DefinitionNotFound ctermbg=196 guibg=#af3f53 ctermfg=249 guifg=#b2b2b2 cterm=bold gui=bold
endif

if !hlexists('NotFoundIcon')
  hi NotFoundIcon ctermfg=196 ctermbg=235 guifg=#292b2e guifg=#f2241f
endif

if has('nvim')

  function! s:close() abort
    if getpos('.') == s:old_pos
      return
    endif
    if nvim_win_is_valid(s:floating_winid)
      call nvim_win_close(s:floating_winid, v:true)
    endif
    if nvim_win_is_valid(s:floating_icon_winid)
      call nvim_win_close(s:floating_icon_winid, v:true)
    endif
    silent autocmd! spacevimLspNotFound
  endfunction

  function! s:open_floating_icon() abort
    let x = ""
    let x = ""
    let x = "▼"
    let x = "▾"
    let x = '🔻'
    let buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(buf, 0, -1, v:true, [x])
    let opts = {'relative': 'cursor', 'width': strlen(x), 'height': 1, 'col': -2,'row': -1, 'anchor': 'NW'}
    silent let s:floating_icon_winid = nvim_open_win(buf, 0, opts)
    call setwinvar(s:floating_icon_winid, '&winblend', 30)
    call nvim_win_set_option(s:floating_icon_winid, 'cursorline', v:false)
    call nvim_win_set_option(s:floating_icon_winid, 'number', v:false)
    call nvim_win_set_option(s:floating_icon_winid, 'winhl', 'Normal:NotFoundIcon')
  endfunction

  function! s:open_floating_msg(msg) abort
    let buf = nvim_create_buf(v:false, v:true)
    let msg = a:msg
    let lines = [msg]
    call nvim_buf_set_lines(buf, 0, -1, v:true, lines)
    let opts = {'relative': 'cursor', 'width': strlen(msg)+2, 'height': len(lines), 'col': -strlen(msg)/2, 'row': -2, 'anchor': 'NW'}
    silent let s:floating_winid = nvim_open_win(buf, 0, opts)

    call nvim_win_set_option(s:floating_winid, 'cursorline', v:false)
    call nvim_win_set_option(s:floating_winid, 'listchars', '')
    call nvim_win_set_option(s:floating_winid, 'number', v:false)
    call nvim_win_set_option(s:floating_winid, 'winhl', 'Normal:DefinitionNotFound')
  endfunction

  function! s:say_not_found() abort
    let msg = ' ﯦ  Cannot find declaration to go to '
    let msg = ' ﯦ  Cannot find declaration to go to '

    if exists('s:old_pos')
      if getpos('.') == s:old_pos
            \ && exists('s:floating_winid')
            \ && nvim_win_is_valid(s:floating_winid)
        return
      endif
    endif

    let s:old_pos = getpos('.')
    call s:open_floating_icon()
    call s:open_floating_msg(msg)
    call nvim_win_set_option(s:floating_icon_winid, 'winhl', 'Normal:MyNormal')
    augroup spacevimLspNotFound
      autocmd!
      autocmd CursorMoved * call s:close()
    augroup END
    return
  endfunction

else

  function! s:say_not_found() abort
    let msg = 'ﯦ  Cannot find declaration to go to'
    let winid = popup_atcursor(msg, {'padding': [0, 1, 0, 1]})
    call setwinvar(winid, '&wincolor', 'DefinitionNotFound')
  endfunction

endif

function! spacevim#lang#lsp_ui#NotFound() abort
  call s:say_not_found()
endfunction
