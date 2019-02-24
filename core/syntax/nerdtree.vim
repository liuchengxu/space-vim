" https://github.com/scrooloose/nerdtree/issues/807
" remove the slashes after each directory node
setlocal conceallevel=3
syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained

function! s:get_color(group, attr) abort
  return synIDattr(synIDtrans(hlID(a:group)), a:attr)
endfunction

let s:use_gui = has('gui_running') || (has('termguicolors') && &termguicolors)
let s:gui_or_cterm = s:use_gui ? 'gui' : 'cterm'
let s:normal_bg = s:get_color('Normal', 'bg')

function! s:get_attrs(group) abort
  let fg = s:get_color(a:group, 'fg')
  return printf('%sbg=%s %sfg=%s', s:gui_or_cterm, s:normal_bg, s:gui_or_cterm, fg)
endfunction

" NERDTress File highlighting
function! s:hl(extension, group, ext_group)
  let ext_group_name = 'ext_'.a:extension
  execute 'syntax match' ext_group_name '/\f*'.a:extension.'$/'
  execute 'syntax match' a:extension    '/^\s\+.*'.a:extension.'$/' 'contains='.ext_group_name

  execute 'hi!' a:extension    s:get_attrs(a:group)
  execute 'hi!' ext_group_name s:get_attrs(a:ext_group)
endfunction

let s:hi_group = {
      \ 'Comment':     [ 'Constant',       [ 'md', 'org', 'txt'                                      ]  ] ,
      \ 'Constant':    [ 'SpecialComment', [ 'ignore', 'editorconfig', 'gitconfig'                   ]  ] ,
      \ 'String':      [ 'Character',      [ 'toml', 'yml', 'ini', 'info', 'conf', 'yaml', 'json'    ]  ] ,
      \ 'Character':   [ 'Number',         [ 'png', 'svg', 'jpg', 'bmp', 'gif'                       ]  ] ,
      \ 'Number':      [ 'Float',          [ 'sass', 'scss', 'css', 'less', 'coffee'                 ]  ] ,
      \ 'Float':       [ 'Identifier',     [ 'sh', 'ps1', 'bat', 'cmd'                               ]  ] ,
      \ 'Identifier':  [ 'Function',       [ 'vim', 'swift', 'dart'                                  ]  ] ,
      \ 'Function':    [ 'Statement',      [ 'html', 'ts', 'vue', 'js', 'jsx', 'ts'                  ]  ] ,
      \ 'Statement':   [ 'Label',          [ 'py', 'pyc', 'pyo', 'rb', 'php', 'lua'                  ]  ] ,
      \ 'Label':       [ 'Operator',       [ 'hs', 'go', 'java', 'rs'                                ]  ] ,
      \ 'Operator':    [ 'SpecialComment', [ 'rc', 'lesshst'                                         ]  ] ,
      \ 'PreCondit':   [ 'SpecialComment', [ 'profile', 'zshenv'                                     ]  ] ,
      \ 'Boolean':     [ 'Include',        [ 'cpp', 'cc', 'hpp', 'cxx', 'hxx', 'h'                   ]  ] ,
      \ 'Include':     [ 'SpecialComment', [ 'history', 'vimsize'                                    ]  ] ,
      \ 'Conditional': [ 'SpecialKey',     [ 'log', 'tags'                                           ]  ] ,
      \ 'SpecialKey':  [ 'PreProc',        [ 'lock'                                                  ]  ] ,
      \ 'PreProc':     [ 'SpecialComment', [ 'LICENSE', 'AUTHOR',                                    ]  ] ,
      \ 'TypeDef':     [ 'Comment',        [ 'Makefile'                                              ]  ] ,
      \ 'Delimiter':   [ 'Macro',          [ 'docs', 'doc', 'cnx', 'pdf'                             ]  ] ,
      \ }

function! s:def_hi() abort
  for [group, exts] in items(s:hi_group)
    let [ext_group, exts] = [exts[0], exts[1]]
    for ext in exts
      call s:hl(ext, group, ext_group)
    endfor
  endfor
endfunction

call s:def_hi()

unlet s:hi_group s:use_gui s:gui_or_cterm s:normal_bg
