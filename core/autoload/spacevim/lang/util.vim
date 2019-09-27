let s:engine = g:spacevim_lsp_engine

" Infer executable from the first line
function! spacevim#lang#util#InferExecutable() abort
  " #!/usr/bin/env python
  let l:exe = split(getline(1), ' ')[-1]
  if executable(l:exe)
    return l:exe
  endif
  " #!/bin/sh
  let l:exe = split(getline(1), '/')[-1]
  return executable(l:exe) ? l:exe : ''
endfunction

" coc or LCN
function! s:dispatch(...) abort
  if a:0 == 2
    if s:engine == 'coc'
      let cmd = printf('call CocAction("%s")', a:1)
    elseif s:engine == 'lcn'
      let cmd = printf('call LanguageClient#%s()', a:2)
    else
      call spacevim#util#err('Unknown LSP engine')
      return
    endif

    execute cmd
  endif
endfunction

" ================================================
" LSP
" ================================================
function! spacevim#lang#util#FindReferences() abort
  call s:dispatch('jumpReferences', 'textDocument_references')
endfunction

function! spacevim#lang#util#Rename() abort
  call s:dispatch('rename', 'textDocument_rename')
endfunction

function! spacevim#lang#util#DocumentSymbol() abort
  call s:dispatch('documentSymbols', 'textDocument_documentSymbol')
endfunction

function! spacevim#lang#util#WorkspaceSymbol() abort
  call s:dispatch('workspaceSymbols', 'workspace_symbol')
endfunction

function! spacevim#lang#util#Format() abort
  if s:engine == 'coc'
    call CocAction('format')
  elseif exists('*LanguageClient#textDocument_formatting')
    call LanguageClient#textDocument_formatting()
  elseif exists(':Autoformat')
    Autoformat
  elseif exists(':ALEFix')
    ALEFix
  endif
endfunction

function! spacevim#lang#util#CodeAction() abort
  if s:engine == 'coc'
    call CocAction('codeAction', '')
  endif
  call LanguageClient#textDocument_codeAction()
endfunction

function! spacevim#lang#util#DiagnosticPrevious(type) abort
  if s:engine == 'coc'
    call CocAction('diagnosticPrevious')
    return
  endif

  ALEPreviousWrap
endfunction

function! spacevim#lang#util#DiagnosticNext() abort
  if s:engine == 'coc'
    call CocAction('diagnosticNext')
  endif

  ALENextWrap
endfunction

" TODO move to another file
function! s:Close() abort
  if getpos('.') == s:old_pos
    return
  endif
  if nvim_win_is_valid(s:floating_winid)
    call nvim_win_close(s:floating_winid, v:true)
  endif
  if nvim_win_is_valid(s:floating_icon_winid)
    call nvim_win_close(s:floating_icon_winid, v:true)
  endif
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
  hi NotFoundIcon ctermfg=196 ctermbg=235 guifg=#292b2e guifg=#f2241f
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
  call nvim_win_set_option(s:floating_winid, 'winhl', 'Normal:DefinitionNotFound')
endfunction

function! s:CursorWarning() abort
  let msg = 'ﯦ  Cannot find declaration to go to '
  if has('nvim')
    let msg = ' Cannot find declaration to go to '
  else
    let msg = 'Cannot find declaration to go to'
  endif
  let v = "  "
  let x = "  "
  let x = "  "

  if !hlexists('DefinitionNotFound')
    hi DefinitionNotFound ctermbg=196 guibg=#af3f53 ctermfg=249 guifg=#b2b2b2 cterm=bold gui=bold
  endif

  if exists('s:old_pos')
    if getpos('.') == s:old_pos
          \ && exists('s:floating_winid')
          \ && nvim_win_is_valid(s:floating_winid)
      return
    endif
  endif

  let s:old_pos = getpos('.')
  if has('nvim')
    call s:open_floating_icon()
    call s:open_floating_msg(msg)
    call nvim_win_set_option(s:floating_icon_winid, 'winhl', 'Normal:MyNormal')
    autocmd CursorMoved * call s:Close()
    return
  else
    let winid = popup_atcursor(msg, {'padding': [0, 1, 0, 1]})
    call setwinvar(winid, '&wincolor', 'DefinitionNotFound')
  endif
endfunction

" ---------------------------------------------
" goto
" ---------------------------------------------
function! spacevim#lang#util#Definition() abort
  if &filetype ==# 'vim'
    call spacevim#lang#vim#Goto()
    return
  endif

  if s:engine == 'coc'
    let found = CocAction('jumpDefinition')
    if !found
      call s:CursorWarning()
    endif
    return
  endif

  function! s:GotoDefinitionHandler(output) abort
    let output = a:output
    if has_key(output, 'error')
      echom "ERROR"
    elseif (has_key(output, 'result') && empty(output['result']))
      echom "Not found!"
    endif
  endfunction

  if LanguageClient#serverStatus() == 1
    call spacevim#vim#cursor#TruncatedEcho('Language Server is busy now, please try again later.')
  else
    " https://github.com/autozimu/LanguageClient-neovim/issues/560
    call LanguageClient#textDocument_definition({'handle': v:true}, function('s:GotoDefinitionHandler'))
  endif
endfunction

function! spacevim#lang#util#TypeDefinition() abort
  call s:dispatch('jumpTypeDefinition', 'textDocument_typeDefinition')
endfunction

function! spacevim#lang#util#Implementation() abort
  call s:dispatch('jumpImplementation', 'textDocument_implementation')
endfunction
