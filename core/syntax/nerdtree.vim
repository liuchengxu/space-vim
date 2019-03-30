" https://github.com/scrooloose/nerdtree/issues/807
" remove the slashes after each directory node
setlocal conceallevel=3
syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained

function! s:get_color(group, attr) abort
  return synIDattr(synIDtrans(hlID(a:group)), a:attr)
endfunction

function! s:get_attrs(group) abort
  let fg = s:get_color(a:group, 'fg')
  if empty(fg)
    let fg = s:get_color('Normal', 'fg')
  endif
  return printf('%sbg=%s %sfg=%s', s:gui_or_cterm, s:normal_bg, s:gui_or_cterm, fg)
endfunction

" NERDTress File highlighting
function! s:highlight(extension, group, ext_group)
  let ext_group_name = 'ext_'.a:extension
  execute 'syntax match' ext_group_name '/\f*'.a:extension.'$/'
  execute 'syntax match' a:extension    '/^\s\+.*'.a:extension.'$/' 'contains='.ext_group_name

  execute 'hi!' a:extension    s:get_attrs(a:group)
  execute 'hi!' ext_group_name s:get_attrs(a:ext_group)
endfunction

let s:use_gui = has('gui_running') || (has('termguicolors') && &termguicolors)
let s:gui_or_cterm = s:use_gui ? 'gui' : 'cterm'
let s:normal_bg = s:get_color('Normal', 'bg')

let s:hi_group = {
      \ 'Comment':     [ 'Constant',       [ 'md',  'MD', 'org', 'txt'                               ]  ] ,
      \ 'Character':   [ 'Number',         [ 'png', 'svg', 'jpg', 'bmp', 'gif'                       ]  ] ,
      \ 'Number':      [ 'Float',          [ 'sass', 'scss', 'css', 'less', 'coffee'                 ]  ] ,
      \ 'Float':       [ 'Identifier',     [ 'sh', 'ps1', 'bat', 'cmd'                               ]  ] ,
      \ 'Identifier':  [ 'Function',       [ 'vim', 'swift', 'dart'                                  ]  ] ,
      \ 'Function':    [ 'Statement',      [ 'html', 'ts', 'vue', 'js', 'jsx', 'ts'                  ]  ] ,
      \ 'Statement':   [ 'Label',          [ 'py', 'pyc', 'pyo', 'rb', 'php', 'lua'                  ]  ] ,
      \ 'Label':       [ 'Operator',       [ 'hs', 'go', 'java', 'rs'                                ]  ] ,
      \ 'Boolean':     [ 'Include',        [ 'cpp', 'cc', 'hpp', 'cxx', 'hxx', 'h'                   ]  ] ,
      \ 'Delimiter':   [ 'Macro',          [ 'docs', 'doc', 'cnx', 'pdf'                             ]  ] ,
      \ 'Constant':    [ 'SpecialComment', [ 'ignore', 'editorconfig', 'gitconfig', 'gitattributes'  ]  ] ,
      \ 'String':      [ 'SpecialComment', [ 'toml', 'yml', 'ini', 'info', 'conf', 'yaml', 'json'    ]  ] ,
      \ 'Operator':    [ 'SpecialComment', [ 'rc', 'lesshst'                                         ]  ] ,
      \ 'PreCondit':   [ 'SpecialComment', [ 'profile', 'zshenv'                                     ]  ] ,
      \ 'Include':     [ 'SpecialComment', [ 'history', 'vimsize', 'wasm'                            ]  ] ,
      \ 'Conditional': [ 'SpecialComment', [ 'log', 'tags'                                           ]  ] ,
      \ 'SpecialKey':  [ 'SpecialComment', [ 'lock'                                                  ]  ] ,
      \ 'PreProc':     [ 'SpecialComment', [ 'LICENSE', 'AUTHOR',                                    ]  ] ,
      \ 'TypeDef':     [ 'SpecialComment', [ 'Makefile', 'Dockerfile'                                ]  ] ,
      \ }

function! s:def_hi() abort
  for [group, exts] in items(s:hi_group)
    let [ext_group, exts] = [exts[0], exts[1]]
    for ext in exts
      call s:highlight(ext, group, ext_group)
    endfor
  endfor
endfunction

call s:def_hi()

unlet s:hi_group s:use_gui s:gui_or_cterm s:normal_bg
delfunction s:get_color
delfunction s:get_attrs
delfunction s:highlight
delfunction s:def_hi
