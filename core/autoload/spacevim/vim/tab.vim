let s:use_fancy_style = get(g:, 'airline_powerline_fonts', 0)

"    
let s:sep = s:use_fancy_style ? ["\ue0b0", "\ue0b1"] : ['', '']
"    
let s:right_sep = s:use_fancy_style ? ["\ue0b2", "\ue0b3"] : ['', '']

function! s:get_color(group, attr) abort
  return synIDattr(synIDtrans(hlID(a:group)), a:attr)
endfunction

function! s:use_gui() abort
  return has('gui_running') || (has('termguicolors') && &termguicolors)
endfunction

function! s:bufname(bufnr) abort
  let l:file = bufname(a:bufnr)

  if l:file ==# ''
    return s:use_fancy_style ?'❓' : '[No Name] '
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

function! s:append_common(str, tabnr, bufnr) abort
  let str = a:str
  let str .= ' '.a:tabnr.':'.s:bufname(a:bufnr)
  if getbufvar(a:bufnr, "&mod")
    let str .= '[+]'
  endif
  return str
endfunction

function! s:get_attrs(fg, bg) abort
  let fg = call(function('s:get_color'), a:fg)
  let bg = call(function('s:get_color'), a:bg)
  let g_c = s:use_gui() ? 'gui' : 'cterm'
  return printf('%sfg=%s %sbg=%s', g_c, fg, g_c, bg)
endfunction

function! s:hi() abort
  hi SpacevimTabLineSel ctermfg=232 ctermbg=178 guifg=#333300 guibg=#ffbb7d
  hi SpacevimTabLine    ctermfg=178 ctermbg=243 guifg=#ffbb7d guibg=#767676

  hi! link TabLineFill StatusLine

  execute 'hi SpacevimTabLineActiveSep'       s:get_attrs(['SpacevimTabLine'    , 'bg'] , ['SpacevimTabLineSel' , 'bg'])
  execute 'hi SpacevimTabLineInactiveSep'     s:get_attrs(['SpacevimTabLineSel' , 'bg'] , ['SpacevimTabLine'    , 'bg'])
  execute 'hi SpacevimTabLineLastActiveSep'   s:get_attrs(['SpacevimTabLine'    , 'bg'] , ['StatusLine'         , 'bg'])
  execute 'hi SpacevimTabLineLastInactiveSep' s:get_attrs(['SpacevimTabLineSel' , 'bg'] , ['StatusLine'         , 'bg'])

  execute 'hi SpacevimTabLineRightXSep'       s:get_attrs(['SpacevimTabLineSel' , 'bg'] , ['StatusLine'    , 'bg'])
  execute 'hi SpacevimTabLineRightX'          s:get_attrs(['SpacevimTabLineSel' , 'bg'] , ['StatusLine'    , 'bg'])
  execute 'hi SpacevimTabLineRightSep'        s:get_attrs(['SpacevimTabLineSel' , 'bg'] , ['StatusLine'    , 'bg'])
  execute 'hi SpacevimTabLineRightTabs'       s:get_attrs(['SpacevimTabLine'    , 'bg'] , ['SpacevimTabLineSel' , 'bg'])
endfunction

function! spacevim#vim#tab#TabLine()
  let tabline = ''

  let last_tabnr = tabpagenr('$')

  for tabnr in range(1, last_tabnr)

    let tabline .= '%'.tabnr.'T'

    let bufnr = s:bufnr(tabnr)

    if tabnr == tabpagenr()
      let tabline .= '%#SpacevimTabLineActiveSep#'.s:sep[0].'%*'.'%#SpacevimTabLineSel#'
      let tabline = s:append_common(tabline, tabnr, bufnr)

      if tabnr == last_tabnr
        let tabline .= '%#SpacevimTabLineLastInactiveSep#'.s:sep[0].'%*'
      else
        let tabline .= '%#SpacevimTabLineInactiveSep#'.s:sep[0].'%*'
      endif

    else

      let tabline .= '%#SpacevimTabLine#'
      let tabline = s:append_common(tabline, tabnr, bufnr)

      if tabnr == last_tabnr
        let tabline .= '%#SpacevimTabLineLastActiveSep#'.s:sep[0].'%*'
      else
        let tabline .= '%#SpacevimTabLineInactiveSep#'.s:sep[1].'%*'
      endif
    endif

  endfor

  let tabline .= '%#TabLineFill#%T'
  let tabline .= tabpagenr('$') > 1 ? '%=%#TabLine#%999X' : ''

  let tabline .= '%#SpacevimTabLineRightXSep#'.s:right_sep[1].'%*'
  let tabline .= '%#SpacevimTabLineRightX# X %*'

  let tabline .= '%#SpacevimTabLineRightSep#'.s:right_sep[0].'%*'
  let tabline .= '%#SpacevimTabLineRightTabs# tabs %*'

  call s:hi()

  return tabline
endfunction
