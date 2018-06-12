" Infer executable from the first line, e.g., #!/usr/bin/env python
function! spacevim#lang#util#InferExecutable()
  let l:exe = split(getline(1), ' ')[-1]
  let l:valid = ['python', 'python3', 'node', 'sh', 'bash']
  return index(l:valid, l:exe) >= 0 ? l:exe : ''
endfunction
