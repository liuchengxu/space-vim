function! s:get_color(group, attr) abort
  return synIDattr(synIDtrans(hlID(a:group)), a:attr)
endfunction

function! s:bufname(bufnr) abort
  let l:file = bufname(a:bufnr)

  if l:file ==# ''
    return '[No Name] '
  endif

  let l:buftype = getbufvar(a:bufnr, 'buftype')

  if l:buftype ==# 'nofile'
    if l:file =~# '\/.'
      let l:file = substitute(l:file, '.*\/\ze.', '', '')
    endif
  else
    let l:file = fnamemodify(l:file, ':p:t')
  endif

  return l:file.' '
endfunction

function! s:bufnr(tabnr) abort
  let buflist = tabpagebuflist(a:tabnr)
  let winnr = tabpagewinnr(a:tabnr)
  return buflist[winnr - 1]
endfunction

function! s:sep() abort
  return get(g:, 'airline_powerline_fonts', 0) ? ["\ue0b0", "\ue0b1"] : ['', '']
endfunction

function! spacevim#vim#tab#TabLine()
  let s = ''

  function! s:append_common(str, tabnr, bufnr) abort
    let str = a:str
    let str .= ' '.a:tabnr.':'.s:bufname(a:bufnr)
    if getbufvar(a:bufnr, "&mod")
      let str .= '[+]'
    endif
    return str
  endfunction

  for tabnr in range(1, tabpagenr('$'))

    let s .= '%'.tabnr.'T'

    let bufnr = s:bufnr(tabnr)

    if tabnr == tabpagenr()
      let s .= '%#SpacevimTabLineActiveSep#'.s:sep()[0].'%*'.'%#SpacevimTabLineSel#'
      let s = s:append_common(s, tabnr, bufnr)
      let s .= '%#SpacevimTabLineInactiveSep#'.s:sep()[0].'%*'
    else
      let s .= '%#SpacevimTabLine#'
      let s = s:append_common(s, tabnr, bufnr)
      let s .= '%#SpacevimTabLineInactiveSep#'.s:sep()[1].'%*'
    endif

  endfor

  let s .= '%#TabLineFill#%T'
  let s .= tabpagenr('$') > 1 ? '%=%#TabLine#%999XX' : 'X'

  hi default link SpacevimTabLineSel User1
  hi default link SpacevimTabLine    User2
  hi default link SpacevimTabLineInactiveSep SpacevimTabLine

  function! s:use_gui() abort
    return has('termguicolors') && &termguicolors
  endfunction

  let bg = s:get_color('SpacevimTabLineSel', 'bg')
  let fg = s:get_color('SpacevimTabLine', 'bg')
  let attrs = s:use_gui() ? "guibg=".bg." guifg=".fg : "ctermbg=".bg." ctermfg=".fg

  execute "hi SpacevimTabLineActiveSep" attrs

  let fg = s:get_color('SpacevimTabLineSel', 'bg')
  let bg = s:get_color('SpacevimTabLine', 'bg')
  let attrs = s:use_gui() ? "guibg=".bg." guifg=".fg : "ctermbg=".bg." ctermfg=".fg

  execute "hi SpacevimTabLineInactiveSep" attrs

  return s
endfunction
