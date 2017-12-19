scriptencoding utf-8

let g:spacevim#plug#ale#linters = {
            \ 'sh' : ['shellcheck'],
            \ 'vim' : ['vint'],
            \ 'html' : ['tidy'],
            \ 'python' : ['flake8'],
            \ 'markdown' : ['mdl'],
            \ 'javascript' : ['eslint'],
            \}

if exists('emoji#for')
  let g:spacevim#plug#ale#sign_error = emoji#for('boom')
  let g:spacevim#plug#ale#sign_warning = emoji#for('small_orange_diamond')
else
  let g:spacevim#plug#ale#sign_error = '•'
  let g:spacevim#plug#ale#sign_warning = '•'
endif

let g:spacevim#plug#ale#echo_msg_error_str = g:spacevim_gui ? 'Error' : '✹ Error'
let g:spacevim#plug#ale#echo_msg_warning_str = g:spacevim_gui ? 'Warning' : '⚠ Warning'

" [DEPRECATED] ALE statusline integration
function! spacevim#plug#ale#ALEGetError()
  let l:res = ale#statusline#Status()
  if l:res ==# 'OK'
    return ''
  else
    let l:e_w = split(l:res)
    if len(l:e_w) == 2 || match(l:e_w, 'E') > -1
      return ' •' . matchstr(l:e_w[0], '\d\+') .' '
    endif
  endif
endfunction

function! spacevim#plug#ale#ALEGetWarning()
  let l:res = ale#statusline#Status()
  if l:res ==# 'OK'
    return ''
  else
    let l:e_w = split(l:res)
    if len(l:e_w) == 2
      return ' •' . matchstr(l:e_w[1], '\d\+')
    elseif match(l:e_w, 'W') > -1
      return ' •' . matchstr(l:e_w[0], '\d\+')
    endif
  endif
endfunction
