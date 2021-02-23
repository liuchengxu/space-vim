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

function! spacevim#lang#util#Hover() abort
  call s:dispatch('doHover', 'LanguageClient#textDocument_hover')
endfunction

function! spacevim#lang#util#Rename() abort
  call s:dispatch('rename', 'textDocument_rename')
endfunction

function! s:DocumentSymbolsCb(error, response) abort
  if getpos('.') != s:old_pos_on_request
    return
  endif
  if empty(a:error)
    if !a:response
      call spacevim#lang#lsp_ui#NotFound()
    endif
  else
    call spacevim#util#err('fail to get Document Symbols via coc')
  endif
endfunction

function! spacevim#lang#util#DocumentSymbol() abort
  if s:engine == 'coc'
    call CocActionAsync('documentSymbols', function('s:DocumentSymbolsCb'))
    let s:old_pos_on_request = getpos('.')
  else
    call LanguageClient#textDocument_documentSymbol()
  endif
  " call s:dispatch('documentSymbols', 'textDocument_documentSymbol')
endfunction

function! spacevim#lang#util#WorkspaceSymbol() abort
  call s:dispatch('workspaceSymbols', 'workspace_symbol')
endfunction

function! spacevim#lang#util#Format() abort
  if s:engine == 'coc'
    call CocActionAsync('format')
  elseif exists(':RustFmt')
    RustFmt
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
    call CocAction('codeLensAction')
    return
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

function! s:DefinitionCb(error, response) abort
  if empty(a:error)
    if !a:response && getpos('.') == s:old_pos_on_request
      call spacevim#lang#lsp_ui#NotFound()
    endif
  else
    call spacevim#util#err('fail to go to definition via coc')
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
    call CocActionAsync('jumpDefinition', function('s:DefinitionCb'))
    let s:old_pos_on_request = getpos('.')
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
