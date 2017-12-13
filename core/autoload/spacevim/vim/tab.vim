function! spacevim#vim#tab#TabLine()
  let l:s = ''
  let l:t = tabpagenr()
  let l:i = 1
  while l:i <= tabpagenr('$')
    let l:buflist = tabpagebuflist(l:i)
    let l:winnr = tabpagewinnr(l:i)
    let l:s .= '%' . l:i . 'T'
    let l:s .= (l:i == l:t ? '%1*' : '%2*')
    let l:s .= ' '
    " Remove the complicated information
    " let l:s .= 'T-' . l:i . ':'
    " let l:s .= l:winnr . '/' . tabpagewinnr(l:i,'$') .'W'
    let l:s .= l:i
    let l:s .= ' %*'
    let l:s .= (l:i == l:t ? '%#TabLineSel#' : '%#TabLine#')
    let l:bufnr = l:buflist[l:winnr - 1]
    let l:file = bufname(l:bufnr)
    let l:buftype = getbufvar(l:bufnr, 'buftype')
    if l:buftype ==# 'nofile'
      if l:file =~# '\/.'
        let l:file = substitute(l:file, '.*\/\ze.', '', '')
      endif
    else
      let l:file = fnamemodify(l:file, ':p:t')
    endif
    if l:file ==# ''
      let l:file = '[No Name]'
    endif
    let l:s .= ' '.l:file.' '
    let l:i = l:i + 1
  endwhile
  let l:s .= '%T%#TabLineFill#%='
  let l:s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
  return l:s
endfunction
