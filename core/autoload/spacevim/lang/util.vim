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

function! spacevim#lang#util#GotoDefinition() abort
  if LanguageClient#serverStatus()
    call spacevim#vim#cursor#TruncatedEcho('Language Server is busy now, please try again later.')
    return
  endif
  call LanguageClient#textDocument_definition()
endfunction
