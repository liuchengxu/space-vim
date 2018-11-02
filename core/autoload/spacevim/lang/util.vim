let s:coc = get(g:, 'spacevim_lsp_prefer_coc', v:false)

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

" ================================================
" LSP
" ================================================
function! spacevim#lang#util#FindReferences() abort
  if s:coc
    call CocAction('jumpReferences')
    return
  endif

  call LanguageClient#textDocument_references()
endfunction

function! spacevim#lang#util#Rename() abort
  if s:coc
    call CocAction('rename')
    return
  endif

  call LanguageClient#textDocument_rename()
endfunction

function! spacevim#lang#util#Format() abort
  if s:coc
    call CocAction('format')
  elseif exists('*LanguageClient#textDocument_formatting')
    call LanguageClient#textDocument_formatting()
  elseif exists(':Autoformat')
    Autoformat
  elseif exists(':ALEFix')
    ALEFix
  endif
endfunction

function! spacevim#lang#util#DocumentSymbol() abort
  if s:coc
    call CocAction('documentSymbols')
  endif
  call LanguageClient#textDocument_documentSymbol()
endfunction

function! spacevim#lang#util#WorkspaceSymbol() abort
  if s:coc
    call CocAction('workspaceSymbols')
  endif
  call LanguageClient#workspace_symbol()
endfunction

function! spacevim#plug#util#CodeAction() abort
  if s:coc
    call CocAction('codeAction', '')
  endif
  call LanguageClient#textDocument_codeAction()
endfunction

function! spacevim#lang#util#DiagnosticPrevious(type) abort
  if s:coc
    call CocAction('diagnosticPrevious')
    return
  endif

  ALEPreviousWrap
endfunction

function! spacevim#lang#util#DiagnosticNext() abort
  if s:coc
    call CocAction('diagnosticNext')
  endif

  ALENextWrap
endfunction

" ---------------------------------------------
" goto
" ---------------------------------------------
function! spacevim#lang#util#Definition() abort
  if s:coc
    call CocAction('jumpDefinition')
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
  if s:coc
    call CocAction('jumpTypeDefinition')
    return
  endif
endfunction

function! spacevim#lang#util#Implementation() abort
  if s:coc
    call CocAction('jumpImplementation')
    return
  endif
endfunction
