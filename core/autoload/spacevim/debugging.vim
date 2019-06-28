function! s:PrettyPrintDict(var) abort
  let keys = sort(keys(a:var))
  for key in keys
    let value = a:var[key]
    echo '        '.key.' = '. string(value).','
  endfor
endfunction

function! s:GetGlobalVariables() abort
  let variable_list = []

  for key in keys(g:)
    if key =~# '^spacevim'
      call add(variable_list, key)
    endif
  endfor

  call sort(variable_list)

  return variable_list
endfunction

function! spacevim#debugging#Info() abort
  let global_variables = s:GetGlobalVariables()

  echohl Type   | echo '    Current FileType: ' | echohl NONE
  echohl Normal | echon &filetype               | echohl NONE
  echohl Type   | echo '    Global Variables:'  | echohl NONE
  for variable in global_variables
    let var = g:[variable]
    if type(var) == type({})
      echo printf('    let g:%s = {', variable)
      call s:PrettyPrintDict(var)
      echo '    }'
    else
      echo '    let g:'.variable.' = '. string(var)
    endif
  endfor
endfunction

function! spacevim#debugging#InfoToClipboard() abort
  redir => l:output
    silent call spacevim#debugging#Info()
  redir END

  let @+ = l:output
  echohl Type     | echo '[space-vim] '               | echohl NONE
  echohl Function | echon 'space-vim info'            | echohl NONE
  echohl Normal   | echon ' copied to your clipboard' | echohl NONE
endfunction
