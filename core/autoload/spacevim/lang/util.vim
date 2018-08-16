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

function! s:GotoDefinitionHandler(output) abort
  let output = a:output
  if has_key(output, 'error')
    echom "ERROR fall back to searchdecl()"
    call searchdecl(expand('<cword>'))
  elseif (has_key(output, 'result') && empty(output['result']))
    echom "not found! fall back to searchdecl()"
    call searchdecl(expand('<cword>'))
  endif
endfunction

function! spacevim#lang#util#GotoDefinition() abort
  if LanguageClient#serverStatus() == 1
    call spacevim#vim#cursor#TruncatedEcho('Language Server is busy now, please try again l ater.')
  else
    " https://github.com/autozimu/LanguageClient-neovim/issues/560
    call LanguageClient#textDocument_definition({'handle': v:true}, function('s:GotoDefinitionHandler'))
  endif
endfunction
